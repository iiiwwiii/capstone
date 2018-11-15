package user.admin;

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

import user.parents.ParentsVO;

public class AdminDAO {
	
	private static AdminDAO instance = new AdminDAO();
	
	public static AdminDAO getInstance() {
        return instance;
    }
	
	private AdminDAO() {}
	
	private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/aban");
        return ds.getConnection();
	}
		
	//★ 식단 테스트   - 식단테이블에 해당일 insert 시 (사진은 default사진) -> 메뉴 테이블에 식단 pk가 메뉴와 같이 insert되어야 함 
	public void foodInsert(String[] menu, Date date) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int foodnum = 0;

		try {
			conn = getConnection();
			conn.setAutoCommit(false);

			pstmt = conn.prepareStatement("insert into food(food_date) values(?)"); // 식단 테이블에 식단 해당일만 입력 -> pk는 auto
			pstmt.setDate(1, date);
			pstmt.executeUpdate();

			pstmt = conn.prepareStatement("select last_insert_id()"); // 방금 입력한 해당일에 대한 pk auto 값 select
			rs = pstmt.executeQuery();
			if (rs.next()) {
				foodnum = rs.getInt(1); // 저장 - 아래 menu에 동일한 값 insert 필요
			}

			for (int i = 0; i < menu.length; i++) {
				pstmt = conn.prepareStatement("insert into menu(food_num, menu_name) values(?, ?)");
				pstmt.setInt(1, foodnum);
				pstmt.setString(2, menu[i]);
				pstmt.executeUpdate();
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
	}
	//전에 캘린더 없이 했던 식단 메서드 2개 지움 (날짜select, 메뉴select)
		
	//★ 1011- admin - 공지사항 리스트 카운트
	public int noticeCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(notice_num) from notice");
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
	
	//★ 1011- admin - 공지사항 리스트 뿌리기  (admin_notice_list)
	public List<AdminNoticeVO> noticeList(int start, int end) throws Exception {									
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<AdminNoticeVO> noticeList = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"select notice_num, notice_title, notice_content, notice_count, notice_fi, notice_date "
							+ "from notice " + "order by notice_fi desc, notice_date desc limit ?,?");
			pstmt.setInt(1, start - 1);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				noticeList = new ArrayList<AdminNoticeVO>();
				do {
					AdminNoticeVO notice = new AdminNoticeVO();
					notice.setNotice_num(rs.getInt("notice_num"));
					notice.setNotice_title(rs.getString("notice_title"));
					notice.setNotice_content(rs.getString("notice_content"));
					notice.setNotice_count(rs.getInt("notice_count"));
					notice.setNotice_fi(rs.getBoolean("notice_fi"));
					notice.setNotice_date(rs.getTimestamp("notice_date"));
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
	
	//★ 1011- admin - 공지사항 상세페이지(admin_notice_layout) + update(admin_notice_update)
	public AdminNoticeVO noticeLayout(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		AdminNoticeVO noticelayout = null;
		try {
			conn = getConnection();
			conn.setAutoCommit(false);

			pstmt = conn.prepareStatement("update notice set notice_count=notice_count+1 where notice_num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

			pstmt = conn.prepareStatement("select * from notice where notice_num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				noticelayout = new AdminNoticeVO();
				noticelayout.setNotice_num(rs.getInt("notice_num"));
				noticelayout.setNotice_title(rs.getString("notice_title"));
				noticelayout.setNotice_content(rs.getString("notice_content"));
				noticelayout.setNotice_count(rs.getInt("notice_count"));
				noticelayout.setNotice_fi(rs.getBoolean("notice_fi"));
				noticelayout.setNotice_date(rs.getTimestamp("notice_date"));
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
		return noticelayout;
	}		
		
	//click_id에 대한 parent정보 얻기
	public ParentsVO getMember_Info_one(String click_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ParentsVO info = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from parents where parents_id = ?");
			pstmt.setString(1, click_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				info = new ParentsVO();
				info.setParents_id(rs.getString("parents_id"));
				info.setParents_pwd(rs.getString("parents_pwd"));
				info.setParents_name(rs.getString("parents_name"));
				info.setParents_phone(rs.getString("parents_phone"));
				info.setParents_post(rs.getString("parents_post"));
				info.setParents_addr(rs.getString("parents_addr"));
				info.setParents_date(rs.getTimestamp("parents_date"));
				info.setParents_app(rs.getBoolean("parents_app"));
				info.setCon_child_name(rs.getString("con_child_name"));
				info.setCon_child_class(rs.getString("con_child_class"));
				info.setTeacher_name(rs.getString("teacher_name"));

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
	//식단 캘린더  메뉴 개수 구하기   
	public int menucount(String dat) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		Date ddate = java.sql.Date.valueOf(dat);

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(menu_name) " + "from food t, menu m "
					+ "where t.food_num = m.food_num " + "and t.food_date = ?");
			pstmt.setDate(1, ddate);
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

	// 캘린더에 메뉴 뿌리기 - 자꾸 에러나서 menunum도 같이 찾아줬음
	public List<AdminFoodVO> calendarmenuList(String dat) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<AdminFoodVO> calendarmenulist = null;

		Date ddate = java.sql.Date.valueOf(dat);

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select t.food_num, t.food_date, m.menu_name, m.menu_num "
					+ "from food t, menu m " + "where t.food_num = m.food_num " + "and t.food_date = ?");
			pstmt.setDate(1, ddate);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				calendarmenulist = new ArrayList<AdminFoodVO>();
				do {
					AdminFoodVO food = new AdminFoodVO();
					food.setFood_num(rs.getInt("food_num"));
					food.setFood_date(rs.getDate("food_date"));
					food.setMenu_name(rs.getString("menu_name"));
					food.setMenu_num(rs.getInt("menu_num"));
					calendarmenulist.add(food);

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
		return calendarmenulist;
	}

	// 메뉴 상세 모달 - date정보
	public AdminFoodVO foodInfo(String fooddate) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		AdminFoodVO fo = null;
		Date fffdate = java.sql.Date.valueOf(fooddate);

		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("select food_date, food_num, food_image " + "from food " + "where food_date = ?");
			pstmt.setDate(1, fffdate);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				fo = new AdminFoodVO();
				fo.setFood_date(rs.getDate("food_date"));
				fo.setFood_num(rs.getInt("food_num"));
				fo.setFood_image(rs.getString("food_image"));
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
		return fo;
	}

	// 모달 - 메뉴 for문 돌리기
	public List<AdminFoodVO> foodMenuInfo(String dam) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<AdminFoodVO> menu = null;

		Date dated = java.sql.Date.valueOf(dam);

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select m.menu_name, m.menu_num " + "from food t, menu m "
					+ "where t.food_num = m.food_num " + "and t.food_date = ?");
			pstmt.setDate(1, dated);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				menu = new ArrayList<AdminFoodVO>();
				do {
					AdminFoodVO food = new AdminFoodVO();
					food.setMenu_name(rs.getString("menu_name"));
					food.setMenu_num(rs.getInt("menu_num"));
					menu.add(food);

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
		return menu;
	}

	// 메뉴수정
	public void menuupdate(String[] menunum, String[] menuname) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			for (int i = 0; i < menunum.length; i++) {
				pstmt = conn.prepareStatement("update menu set menu_name = ? where menu_num = ?");
				pstmt.setString(1, menuname[i]);
				pstmt.setString(2, menunum[i]);
				pstmt.executeUpdate();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
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

	// 식단삭제 - 메뉴삭제없음
	public void fooddelete(String foodnum) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("delete from food where food_num = ?");
			pstmt.setString(1, foodnum);
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
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

	// 식단 - 사진변경

	public void foodImageUpdate(AdminFoodVO vo) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("update food set food_image = ? where food_num = ?");
			pstmt.setString(1, vo.getFood_image());
			pstmt.setInt(2, vo.getFood_num());
			pstmt.executeUpdate();

		} catch (Exception ex) {
			ex.printStackTrace();
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

	// 유치원일정등록 - admin_calendar_list.jsp
	public void calendarInsert(Date calendar_start_date, Date calendar_end_date, String calendar_title)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"insert into calendar(calendar_start_date, calendar_end_date, calendar_title) values(?,?,?)");
			pstmt.setDate(1, calendar_start_date);
			pstmt.setDate(2, calendar_end_date);
			pstmt.setString(3, calendar_title);
			pstmt.executeUpdate();

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

	// 유치원일정개수카운트 - admin_calendar_list.jsp
	public int calendarCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(calendar_title) from calendar");
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

	// 유치원일정리스트뿌리기 - admin_calendar_list.jsp - 전체 test용
	public List<AdminCalendarVO> calendarList() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<AdminCalendarVO> calendarList = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"select calendar_num, calendar_start_date, calendar_end_date, calendar_title " + "from calendar");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				calendarList = new ArrayList<AdminCalendarVO>();
				do {
					AdminCalendarVO calendar = new AdminCalendarVO();
					calendar.setCalendar_num(rs.getInt("calendar_num"));
					calendar.setCalendar_start_date(rs.getDate("calendar_start_date"));
					calendar.setCalendar_end_date(rs.getDate("calendar_end_date"));
					calendar.setCalendar_title(rs.getString("calendar_title"));
					calendarList.add(calendar);
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
		return calendarList;
	}

	// 유치원일정뿌리기 - 월별 - ajax - admin_calendar_list_month.jsp
	public List<AdminCalendarVO> calendarMonthList(String dal) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<AdminCalendarVO> calendarMonthList = null;

		try {
			conn = getConnection();

			if (dal.equals("전체리스트")) {
				pstmt = conn
						.prepareStatement("select calendar_num, calendar_start_date, calendar_end_date, calendar_title "
								+ "from calendar order by calendar_start_date desc");
			} else if (!dal.equals("전체리스트")) {
				pstmt = conn
						.prepareStatement("select calendar_num, calendar_start_date, calendar_end_date, calendar_title "
								+ "from calendar "
								+ "where calendar_start_date like ? order by calendar_start_date desc");
				pstmt.setString(1, dal + "%");
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				calendarMonthList = new ArrayList<AdminCalendarVO>();
				do {
					AdminCalendarVO month = new AdminCalendarVO();
					month.setCalendar_num(rs.getInt("calendar_num"));
					month.setCalendar_start_date(rs.getDate("calendar_start_date"));
					month.setCalendar_end_date(rs.getDate("calendar_end_date"));
					month.setCalendar_title(rs.getString("calendar_title"));
					calendarMonthList.add(month);
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
		return calendarMonthList;
	}

	// 유치원일정개수카운트 - admin_calendar_list.jsp calendarMonthCount(month, d);
	public int calendarMonthCount(String month) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		// Date daldate = java.sql.Date.valueOf(month); //2018-08까지 나옴 . 근데 % 붙이면 아래에서
		// pstmt.setDate(1, daldate + "%"); 을 할 수가 없음. date형이라.
		// 내가볼땐 -00이랑 -32 붙여서 date형으로 날리는게 나을듯 ㅠㅠ 엉엉

		// String startdal = daldate + "-00";
		// Date sdal = java.sql.Date.valueOf(startdal);
		// String enddal = daldate + "-31";
		// Date edal = java.sql.Date.valueOf(enddal);

		// select * from calendar where calendar_start_date like '2018-08%' - 이거 나오는데
		// date형으로 못함 샹

		try {
			conn = getConnection();

			if (month.equals("전체리스트")) {
				pstmt = conn.prepareStatement("select count(calendar_title) from calendar");
			} else if ((!month.equals("전체리스트"))) {
				pstmt = conn.prepareStatement(
						"select count(calendar_title) from calendar where calendar_start_date like ?");
				pstmt.setString(1, month + "%");
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
}
