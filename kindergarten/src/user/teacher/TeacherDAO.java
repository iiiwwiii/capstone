package user.teacher;

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

import notice.NoticeVO;
import user.admin.AdminCalendarVO;
import user.admin.AdminFoodVO;
import user.child.ChildVO;
import user.parents.ParentsVO;

public class TeacherDAO {

	private static TeacherDAO instance = new TeacherDAO();

	public static TeacherDAO getInstance() {
		return instance;
	}

	private TeacherDAO() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/aban");
		return ds.getConnection();
	}

	/** user_parents - listcount */
	public int userParentsListCount(String search) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(parents_id) from parents where parents_id like ?");
			pstmt.setString(1, "%" + search + "%");
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

	/** user_parents - list */
	public List<ParentsVO> userParentsList(String search, int start, int end) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ParentsVO> parentsList = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
							"select distinct p.parents_id, parents_phone, parents_addr, parents_date, parents_app, con_child_name, con_child_class from parents p, parents_confirm c "
							+ "where p.parents_id = c.parents_id and p.parents_id like ? "
							+ "order by parents_app asc, parents_date asc limit ?,?");
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, start - 1);
			pstmt.setInt(3, end);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				parentsList = new ArrayList<ParentsVO>(end);
				do {
					ParentsVO parents = new ParentsVO();
					parents.setParents_id(rs.getString("parents_id"));
					parents.setParents_phone(rs.getString("parents_phone"));
					parents.setParents_addr(rs.getString("parents_addr"));
					parents.setParents_date(rs.getTimestamp("parents_date"));
					parents.setParents_app(rs.getBoolean("parents_app"));
					parents.setCon_child_name(rs.getString("con_child_name"));
					parents.setCon_child_class(rs.getString("con_child_class"));
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

	/** user_parents - accept */
	public void parentsAccept(String parents_id, String childname, String childclass) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement("update parents set parents_app = 1 where parents_id = ?");
			pstmt.setString(1, parents_id);
			pstmt.executeUpdate();

			pstmt = conn.prepareStatement("update child set parents_id = ? where child_name = ? and child_class = ?");
			pstmt.setString(1, parents_id);
			pstmt.setString(2, childname);
			pstmt.setString(3, childclass);
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

	/** user_parents - delete */
	public void parentsDelete(String[] check) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			for (int i = 0; i < check.length; i++) {
				pstmt = conn.prepareStatement("delete from parents where parents_id = ?");
				pstmt.setString(1, check[i]);
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

	/** teacher - class child - listcount */
	public int childListCount() // 페이징, 검색 뺐음, A반 기준 -> 나중에 반 생성 시 변경하기. ★학부모 정보 제외함 (회원가입안할 시 에러)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(child_num) from child where child_class = 'A'");
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

	/**user_parents - list */
	public List<ChildVO> userChildList() // 페이징, 검색 뺐음, A반 기준 -> 나중에 반 생성 시 변경하기 ★학부모 정보 제외함 (회원가입안할 시 에러)
			throws Exception { // child_num은 수정/삭제 용. order by 할 필요 없음 - 의미없는 숫자
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ChildVO> childList = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"select child_num, child_pic, child_class, child_name, child_sex, child_birth, child_post, child_addr, child_memo, child_date "
							+ "from child " + "where child_class='A' " + "order by child_date");

			rs = pstmt.executeQuery();

			if (rs.next()) {
				childList = new ArrayList<ChildVO>();
				do {
					ChildVO child = new ChildVO();
					child.setChild_num(rs.getInt("child_num"));
					child.setChild_pic(rs.getString("child_pic"));
					child.setChild_class(rs.getString("child_class"));
					child.setChild_name(rs.getString("child_name"));
					child.setChild_sex(rs.getString("child_sex"));
					child.setChild_birth(rs.getDate("child_birth"));
					child.setChild_post(rs.getString("child_post"));
					child.setChild_addr(rs.getString("child_addr"));
					child.setChild_memo(rs.getString("child_memo"));
					child.setChild_date(rs.getTimestamp("child_date"));
					childList.add(child);

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
		return childList;
	}

	// click_id에 대한 parent정보 얻기
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

	// main
	public TeacherVO teacherMainInfo(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		TeacherVO info = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select teacher_name, teacher_class, teacher_phone, teacher_pic from teacher where teacher_id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				info = new TeacherVO();
				info.setTeacher_name(rs.getString("teacher_name"));
				info.setTeacher_class(rs.getString("teacher_class"));
				info.setTeacher_phone(rs.getString("teacher_phone"));
				info.setTeacher_pic(rs.getString("teacher_pic"));

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

	// main child count
	public int classChildCount(String ban) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(child_num) from child, parents where child.parents_id = parents.parents_id and child_class = ?");
			pstmt.setString(1, ban);

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

	// main child list
	public List<ChildVO> classChildList(String ban) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ChildVO> childlist = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select child_num, child_name, parents_phone, child_pic "
					+ "from child, parents " + "where child.parents_id = parents.parents_id " + "and child_class = ?");
			pstmt.setString(1, ban);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				childlist = new ArrayList<ChildVO>();
				do {
					ChildVO child = new ChildVO();
					child.setChild_num(rs.getInt("child_num"));
					child.setChild_name(rs.getString("child_name"));
					child.setParents_phone(rs.getString("parents_phone"));
					child.setChild_pic(rs.getString("child_pic"));

					childlist.add(child);

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
		return childlist;
	}

	// 선생님 정보 불러오기
	public TeacherVO getTeacherList(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		TeacherVO teacherpage = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement(
					"select teacher_id,teacher_pwd,teacher_class,teacher_name,teacher_phone,teacher_post,teacher_addr,teacher_pic from teacher where teacher_id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				teacherpage = new TeacherVO();
				teacherpage.setTeacher_id(rs.getString("teacher_id"));
				teacherpage.setTeacher_pwd(rs.getString("teacher_pwd"));
				teacherpage.setTeacher_class(rs.getString("teacher_class"));
				teacherpage.setTeacher_name(rs.getString("teacher_name"));
				teacherpage.setTeacher_phone(rs.getString("teacher_phone"));
				teacherpage.setTeacher_post(rs.getString("teacher_post"));
				teacherpage.setTeacher_addr(rs.getString("teacher_addr"));
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

	// ★ 1011- admin - 공지사항 리스트 카운트
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

	// 공지사항 리스트 뿌리기 (notice_list)
	public List<TeacherNoticeVO> noticeList(int start, int end) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TeacherNoticeVO> noticeList = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select notice_num, notice_title, notice_content, notice_count, notice_fi, notice_date "
							+ "from notice " + "order by notice_fi desc, notice_date desc limit ?,?");
			pstmt.setInt(1, start - 1);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				noticeList = new ArrayList<TeacherNoticeVO>();
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

	// 공지사항 상세페이지 + update
	public TeacherNoticeVO noticeLayout(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		TeacherNoticeVO noticelayout = null;
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
				noticelayout = new TeacherNoticeVO();
				noticelayout.setNotice_num(rs.getInt("notice_num"));
				noticelayout.setNotice_title(rs.getString("notice_title"));
				noticelayout.setNotice_content(rs.getString("notice_content"));
				noticelayout.setNotice_count(rs.getInt("notice_count"));
				noticelayout.setNotice_fi(rs.getBoolean("notice_fi"));
				noticelayout.setNotice_date(rs.getDate("notice_date"));
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

	// notice테이블에 글을 추가(insert문)
	public int insertNotice(TeacherNoticeVO insert, int fi) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		String sql = "";

		try {
			conn = getConnection();

			if (fi == 1) {
				sql = "insert into notice (notice_title, notice_content, notice_fi, notice_date) values(?,?,1,?)";
			}

			else if (fi == 0) {
				sql = "insert into notice (notice_title, notice_content, notice_fi, notice_date) values(?,?,0,?)";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, insert.getNotice_title());
			pstmt.setString(2, insert.getNotice_content());
			pstmt.setDate(3, insert.getNotice_date());

			pstmt.executeUpdate();

		} catch (Exception ex) {
			result = 1;
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

	// 글 수정폼에서 사용할 글의 내용(1개의 글)(select문)
	public TeacherNoticeVO updateGetNotice(int notice_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		TeacherNoticeVO update = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from notice where notice_num = ?");
			pstmt.setInt(1, notice_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				update = new TeacherNoticeVO();
				update.setNotice_num(rs.getInt("notice_num"));
				update.setNotice_title(rs.getString("notice_title"));
				update.setNotice_content(rs.getString("notice_content"));
				update.setNotice_count(rs.getInt("notice_count"));
				update.setNotice_fi(rs.getBoolean("notice_fi"));
				update.setNotice_date(rs.getDate("notice_date"));
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
		return update;
	}

	// 글 수정처리에서 사용(update문)
	public int updateNotice(TeacherNoticeVO update, int fi) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		String sql = "";

		try {
			conn = getConnection();

			if (fi == 1) {
				sql = "update notice set notice_title=?,notice_content=?,notice_fi=1 where notice_num=?";
			}

			else if (fi == 0) {
				sql = "update notice set notice_title=?,notice_content=?,notice_fi=0 where notice_num=?";
			}

			pstmt = conn.prepareStatement(
					"update notice set notice_title=?,notice_content=?,notice_fi=? where notice_num=?");
			pstmt.setString(1, update.getNotice_title());
			pstmt.setString(2, update.getNotice_content());
			pstmt.setBoolean(3, update.isNotice_fi());
			pstmt.setInt(4, update.getNotice_num());
			pstmt.executeUpdate();

		} catch (Exception ex) {
			result = 1;
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

	// 글삭제처리시 사용(delete문)
	public int deleteNotice(int notice_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("delete from notice where notice_num=?");
			pstmt.setInt(1, notice_num);
			pstmt.executeUpdate();

		} catch (Exception ex) {
			result = 1;
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

	// 식단 캘린더 메뉴 개수 구하기
	public int menucount(String dat) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		Date ddate = java.sql.Date.valueOf(dat);

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(menu_name) from food t, menu m where t.food_num = m.food_num and t.food_date = ?");
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
	public List<TeacherFoodVO> calendarmenuList(String dat) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TeacherFoodVO> calendarmenulist = null;

		Date ddate = java.sql.Date.valueOf(dat);

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select t.food_num, t.food_date, m.menu_name, m.menu_num from food t, menu m where t.food_num = m.food_num and t.food_date = ?");
			pstmt.setDate(1, ddate);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				calendarmenulist = new ArrayList<TeacherFoodVO>();
				do {
					TeacherFoodVO food = new TeacherFoodVO();
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
	public TeacherFoodVO foodInfo(String fooddate) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		TeacherFoodVO fo = null;
		Date fffdate = java.sql.Date.valueOf(fooddate);

		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("select food_date, food_num, food_image " + "from food " + "where food_date = ?");
			pstmt.setDate(1, fffdate);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				fo = new TeacherFoodVO();
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
	public List<TeacherFoodVO> foodMenuInfo(String dam) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TeacherFoodVO> menu = null;

		Date dated = java.sql.Date.valueOf(dam);

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select m.menu_name, m.menu_num from food t, menu m where t.food_num = m.food_num and t.food_date = ?");
			pstmt.setDate(1, dated);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				menu = new ArrayList<TeacherFoodVO>();
				do {
					TeacherFoodVO food = new TeacherFoodVO();
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
	
	//식단테이블에 해당일 insert 시 (사진은 default사진) -> 메뉴 테이블에 식단 pk가 메뉴와 같이 insert되어야 함 
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
	public void foodImageUpdate(TeacherFoodVO vo) throws Exception {
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

	// 유치원일정등록 - calendar_list.jsp
	public void calendarInsert(Date calendar_start_date, Date calendar_end_date, String calendar_title)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("insert into calendar(calendar_start_date, calendar_end_date, calendar_title) values(?,?,?)");
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

	// 유치원일정개수카운트 - calendar_list.jsp
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

	// 유치원일정리스트뿌리기 - calendar_list.jsp - 전체 test용
	public List<TeacherCalendarVO> calendarList() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TeacherCalendarVO> calendarList = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select calendar_num, calendar_start_date, calendar_end_date, calendar_title from calendar");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				calendarList = new ArrayList<TeacherCalendarVO>();
				do {
					TeacherCalendarVO calendar = new TeacherCalendarVO();
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

	// 유치원일정뿌리기 - 월별 - ajax -calendar_list_month.jsp
	public List<TeacherCalendarVO> calendarMonthList(String dal) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TeacherCalendarVO> calendarMonthList = null;

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
				calendarMonthList = new ArrayList<TeacherCalendarVO>();
				do {
					TeacherCalendarVO month = new TeacherCalendarVO();
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

	// 유치원일정개수카운트 - calendar_list.jsp calendarMonthCount(month, d);
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
				pstmt = conn.prepareStatement("select count(calendar_title) from calendar where calendar_start_date like ?");
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
