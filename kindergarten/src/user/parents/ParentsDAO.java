package user.parents;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import attend.AttendanceVO;
import picture.ScheduleVO;
import picture.ImageVO;
import user.child.ChildVO;
import user.teacher.TeacherCalendarVO;
import user.teacher.TeacherFoodVO;
import user.teacher.TeacherNoticeVO;
import user.teacher.TeacherVO;

public class ParentsDAO {

	private static ParentsDAO instance = new ParentsDAO();

	public static ParentsDAO getInstance() {
		return instance;
	}

	private ParentsDAO() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/aban");
		return ds.getConnection();
	}

	/** parents signup - parents_app boolean(0false 1true) */
	public void parentsSignUp(ParentsVO parentsvo) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement("insert into parents(parents_id, parents_pwd, parents_name, parents_phone, parents_post, parents_addr, parents_date, parents_app) "
							+ "values (?,?,?,?,?,?,?,0)");
			pstmt.setString(1, parentsvo.getParents_id());
			pstmt.setString(2, parentsvo.getParents_pwd());
			pstmt.setString(3, parentsvo.getParents_name());
			pstmt.setString(4, parentsvo.getParents_phone());
			pstmt.setString(5, parentsvo.getParents_post());
			pstmt.setString(6, parentsvo.getParents_addr());
			pstmt.setTimestamp(7, parentsvo.getParents_date());
			pstmt.executeUpdate();

			pstmt = conn.prepareStatement("insert into parents_confirm(parents_id, con_child_name, con_child_class) values (?,?,?)");
			pstmt.setString(1, parentsvo.getParents_id());
			pstmt.setString(2, parentsvo.getCon_child_name());
			pstmt.setString(3, parentsvo.getCon_child_class());
			pstmt.executeUpdate();

			conn.commit();
			conn.setAutoCommit(true);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
	}

	/** parents idcheck */
	public int idCheck(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select parents_id from parents where parents_id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = 0; // 이미 있음
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return result;
	}

	/** user Login */
	public int userLogin(String user_id, String user_pwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		String sql = "";
		try {
			conn = getConnection();
			conn.setAutoCommit(false);

			sql = "select admin_id from admin where admin_id = ? and admin_pwd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, user_pwd);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = 1;
			}
			sql = "select teacher_id from teacher where teacher_id = ? and teacher_pwd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, user_pwd);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = 2;
			}
			sql = "select parents_id from parents where parents_id = ? and parents_pwd = ? and parents_app = 1";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, user_pwd);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = 3;
			}

			conn.commit();
			conn.setAutoCommit(true);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return result;

	}

	/** parents - notice - count+search */
	public int parentsNoticeCount(String select, String word) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		try {
			conn = getConnection();

			if (select.equals("title")) {
				pstmt = conn.prepareStatement("select count(notice_num) from notice where notice_title like ?");
				pstmt.setString(1, "%" + word + "%");
			} else if (select.equals("content")) {
				pstmt = conn.prepareStatement("select count(notice_num) from notice where notice_content like ?");
				pstmt.setString(1, "%" + word + "%");
			} else if (select.equals("none")) {
				pstmt = conn.prepareStatement("select count(notice_num) from notice where notice_title like ? or notice_content like ?");
				pstmt.setString(1, "%" + word + "%");
				pstmt.setString(2, "%" + word + "%");
			} else {
				pstmt = conn.prepareStatement("select count(notice_num) from notice");
			}
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return result;
	}

	/** parents - notice - list+search */
	public List<TeacherNoticeVO> parentsNoticeList(String select, String word, int start, int end) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TeacherNoticeVO> noticeList = null;
		try {
			conn = getConnection();

			if (select.equals("title")) {
				pstmt = conn.prepareStatement("select notice_num, notice_title, notice_content, notice_count, notice_fi, notice_date "
								+ "from notice " + "where notice_title like ? "
								+ "order by notice_fi desc, notice_date desc limit ?,?");
				pstmt.setString(1, "%" + word + "%");
				pstmt.setInt(2, start - 1);
				pstmt.setInt(3, end);
			} else if (select.equals("content")) {
				pstmt = conn.prepareStatement("select notice_num, notice_title, notice_content, notice_count, notice_fi, notice_date "
								+ "from notice " + "where notice_content like ? "
								+ "order by notice_fi desc, notice_date desc limit ?,?");
				pstmt.setString(1, "%" + word + "%");
				pstmt.setInt(2, start - 1);
				pstmt.setInt(3, end);
			} else if (select.equals("none")) {
				pstmt = conn.prepareStatement("select notice_num, notice_title, notice_content, notice_count, notice_fi, notice_date "
								+ "from notice " + "where notice_title like ? or notice_content like ? "
								+ "order by notice_fi desc, notice_date desc limit ?,?");
				pstmt.setString(1, "%" + word + "%");
				pstmt.setString(2, "%" + word + "%");
				pstmt.setInt(3, start - 1);
				pstmt.setInt(4, end);
			} else {
				pstmt = conn.prepareStatement("select notice_num, notice_title, notice_content, notice_count, notice_fi, notice_date "
								+ "from notice " + "order by notice_fi desc, notice_date desc limit ?,?");
				pstmt.setInt(1, start - 1);
				pstmt.setInt(2, end);
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				noticeList = new ArrayList<TeacherNoticeVO>(end);
				do {
					TeacherNoticeVO notice = new TeacherNoticeVO();
					notice.setNotice_num(rs.getInt("notice_num"));
					notice.setNotice_title(rs.getString("notice_title"));
					notice.setNotice_content(rs.getString("notice_content"));
					notice.setNotice_count(rs.getInt("notice_count"));
					notice.setNotice_fi(rs.getBoolean("notice_fi"));
					notice.setNotice_date(rs.getDate("notice_date"));
					noticeList.add(notice);

				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return noticeList;
	}

	/** parents - menu info */
	public ParentsVO parentsMenuInfo(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ParentsVO info = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select parents_name, parents_phone from parents where parents_id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				info = new ParentsVO();
				info.setParents_name(rs.getString("parents_name"));
				info.setParents_phone(rs.getString("parents_phone"));
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return info;
	}

	/** parents - menu info */
	public ChildVO parentsChildName(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ChildVO childinfo = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select child_name, child_num, child_pic from child, parents where child.parents_id = parents.parents_id and parents.parents_id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				childinfo = new ChildVO();
				childinfo.setChild_num(rs.getInt("child_num"));
				childinfo.setChild_name(rs.getString("child_name"));
				childinfo.setChild_pic(rs.getString("child_pic"));
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return childinfo;
	}

	/** parents - menu child pic */
	public String parentsMenuChildPic(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String childpic = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select child_pic from child, parents where child.parents_id = parents.parents_id and parents.parents_id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				childpic = rs.getString(1);
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return childpic;
	}

	/** parents-main - notice - 최신5개 */
	public List<TeacherNoticeVO> parentsMainNotice() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TeacherNoticeVO> noticeList = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select notice_num, notice_title, notice_date from notice order by notice_date desc limit 0,5");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				noticeList = new ArrayList<TeacherNoticeVO>();
				do {
					TeacherNoticeVO notice = new TeacherNoticeVO();
					notice.setNotice_num(rs.getInt("notice_num")); // 눌렀을때 링크..샹..
					notice.setNotice_title(rs.getString("notice_title"));
					notice.setNotice_date(rs.getDate("notice_date"));
					noticeList.add(notice);

				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return noticeList;
	}

	/** parents - food - todaymenu - null check */
	public int parentsTodayMenuCount(String today) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(menu_name) from menu, food where menu.food_num = food.food_num and food_date = ?");
			pstmt.setString(1, today);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return result;
	}

	/** parents - food - todaymenu */
	public List<TeacherFoodVO> parentsTodayMenu(String today) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TeacherFoodVO> todaymenu = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select menu_name from menu, food where menu.food_num = food.food_num and food_date = ?");
			pstmt.setString(1, today);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				todaymenu = new ArrayList<TeacherFoodVO>();
				do {
					TeacherFoodVO tmenu = new TeacherFoodVO();
					tmenu.setMenu_name(rs.getString("menu_name"));
					todaymenu.add(tmenu);

				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return todaymenu;
	}

	/** parents - food - todaymenuimage */
	public String parentsTodayMenuImage(String today) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String todayimage = "없음";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select food_image from food where food_date = ?");
			pstmt.setString(1, today);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				todayimage = rs.getString(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return todayimage;
	}

	/** notice layout */
	public TeacherNoticeVO noticeLayout(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		TeacherNoticeVO noti = null;
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement("update notice set notice_count=notice_count+1 where notice_num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

			pstmt = conn.prepareStatement("select notice_title, notice_content, notice_date, notice_count from notice where notice_num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				noti = new TeacherNoticeVO();
				noti.setNotice_title(rs.getString("notice_title"));
				noti.setNotice_content(rs.getString("notice_content"));
				noti.setNotice_date(rs.getDate("notice_date"));
				noti.setNotice_count(rs.getInt("notice_count"));
			}

			conn.commit();
			conn.setAutoCommit(true);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return noti;
	}

	/** parents main = parentsClassScheduleCount */
	public int parentsClassScheduleCount(String ban, String today) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(schedule_num) from schedule where class_name = ? and schedule_date = ?");
			pstmt.setString(1, ban);
			pstmt.setString(2, today);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return result;
	}

	/** parents main = parentsClassScheduleList */
	public List<ScheduleVO> parentsClassScheduleList(String ban, String today) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ScheduleVO> schedulelist = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select schedule_num, schedule_start_time, schedule_end_time, schedule_title from schedule "
							+ "where class_name = ? and schedule_date = ?");
			pstmt.setString(1, ban);
			pstmt.setString(2, today);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				schedulelist = new ArrayList<ScheduleVO>();
				do {
					ScheduleVO schedule = new ScheduleVO();
					schedule.setSchedule_num(rs.getInt("schedule_num"));
					schedule.setSchedule_start_time(rs.getTime("schedule_start_time"));
					schedule.setSchedule_end_time(rs.getTime("schedule_end_time"));
					schedule.setSchedule_title(rs.getString("schedule_title"));
					schedulelist.add(schedule);

				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return schedulelist;
	}

	/**
	 * parents main = Today Gallery - limit 안정함 아직 - count먼저 select image_name from
	 * image, album, schedule where image.album_num = album.album_num and
	 * album.schedule_num = schedule.schedule_num and album.class_name = 'A' and
	 * schedule_date = '2018-10-31';
	 */
	public int parentstodaygalleryCount(String ban, String today) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(image_name) " + "from image, album, schedule "
					+ "where image.album_num = album.album_num " + "and album.schedule_num = schedule.schedule_num "
					+ "and album.class_name = ? and schedule_date = ?");
			pstmt.setString(1, ban);
			pstmt.setString(2, today);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return result;
	}

	public List<ImageVO> parentstodaygallerylist(String ban, String today) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ImageVO> imagelist = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select image_name " + "from image, album, schedule "
					+ "where image.album_num = album.album_num " + "and album.schedule_num = schedule.schedule_num "
					+ "and album.class_name = ? and schedule_date = ?");
			pstmt.setString(1, ban);
			pstmt.setString(2, today);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				imagelist = new ArrayList<ImageVO>();
				do {
					ImageVO imagename = new ImageVO();
					imagename.setImage_name(rs.getString("image_name"));
					imagelist.add(imagename);

				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return imagelist;
	}

	// main calendar - 월전체 잡아옴
	public int parentscalendarcount(String month) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(calendar_num) from calendar where calendar_start_date like ?");
			pstmt.setString(1, "_____" + month + "%");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return result;
	}

	// main calendar - list
	public List<TeacherCalendarVO> parentscalendarlist(String month) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TeacherCalendarVO> calendarlist = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select calendar_num, calendar_start_date, calendar_end_date, calendar_title "
					+ "from calendar " + "where calendar_start_date like ?");
			pstmt.setString(1, "_____" + month + "%");

			rs = pstmt.executeQuery();
			if (rs.next()) {
				calendarlist = new ArrayList<TeacherCalendarVO>();
				do {
					TeacherCalendarVO cal = new TeacherCalendarVO();
					cal.setCalendar_num(rs.getInt("calendar_num"));
					cal.setCalendar_start_date(rs.getDate("calendar_start_date"));
					cal.setCalendar_end_date(rs.getDate("calendar_end_date"));
					cal.setCalendar_title(rs.getString("calendar_title"));
					calendarlist.add(cal);

				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return calendarlist;
	}

	// main 출석
	public AttendanceVO childtodayattence(String day, int childnum) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		AttendanceVO childinfo = null;
		Date dd = java.sql.Date.valueOf(day);

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select attendance_start_time, attendance_end_time, attendance_absence from attendance where attendance_date = ? and child_num = ?");
			pstmt.setDate(1, dd);
			pstmt.setInt(2, childnum);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				childinfo = new AttendanceVO();
				childinfo.setAttendance_start_time(rs.getTime("attendance_start_time"));
				childinfo.setAttendance_end_time(rs.getTime("attendance_end_time"));
				childinfo.setAttendance_absence(rs.getInt("attendance_absence"));
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return childinfo;
	}

	// 마이페이지
	public List<ParentsVO> getParentsList(String parents_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ParentsVO> parentsList = null;

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select parents_id,parents_pwd,parents_name,parents_phone,parents_post,parents_addr,parents_date,parents_app "
							+ "from parents where parents_id=?");

			pstmt.setString(1, parents_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				parentsList = new ArrayList<ParentsVO>();
				do {
					ParentsVO parents = new ParentsVO();
					parents.setParents_id(rs.getString("parents_id"));
					parents.setParents_pwd(rs.getString("parents_pwd"));
					parents.setParents_name(rs.getString("parents_name"));
					parents.setParents_phone(rs.getString("parents_phone"));
					parents.setParents_post(rs.getString("parents_post"));
					parents.setParents_addr(rs.getString("parents_addr"));
					parents.setParents_date(rs.getTimestamp("parents_date"));
					parents.setParents_app(rs.getBoolean("parents_app"));
					parentsList.add(parents);

				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return parentsList;
	}

	// 아이정보 불러오기
	public ChildVO getChildList(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ChildVO childpage = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select child_name,child_class,child_sex,child_birth,child_post,child_addr,child_pic,child_memo from child, parents where child.parents_id = parents.parents_id and parents.parents_id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				childpage = new ChildVO();
				childpage.setChild_name(rs.getString("child_name"));
				childpage.setChild_class(rs.getString("child_class"));
				childpage.setChild_sex(rs.getString("child_sex"));
				childpage.setChild_birth(rs.getDate("child_birth"));
				childpage.setChild_post(rs.getString("child_post"));
				childpage.setChild_addr(rs.getString("child_addr"));
				childpage.setChild_pic(rs.getString("child_pic"));
				childpage.setChild_memo(rs.getString("child_memo"));
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return childpage;
	}

	// 선생님 정보 불러오기
	public TeacherVO getTeacherList(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		TeacherVO teacherpage = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select teacher_class,teacher_name,teacher_phone,teacher_pic from teacher, child where child.child_class = teacher.teacher_class and teacher.teacher_class = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				teacherpage = new TeacherVO();
				teacherpage.setTeacher_class(rs.getString("teacher_class"));
				teacherpage.setTeacher_name(rs.getString("teacher_name"));
				teacherpage.setTeacher_phone(rs.getString("teacher_phone"));
				teacherpage.setTeacher_pic(rs.getString("teacher_pic"));
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return teacherpage;
	}
}
