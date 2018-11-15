package notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class NoticeDAO {
	
	private static NoticeDAO instance = new NoticeDAO();
	
	public static NoticeDAO getInstance() {
        return instance;
    }
	
	private NoticeDAO() {}
	
	private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/aban");
        return ds.getConnection();
	}
	
	// 공지사항 리스트 카운트
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

		// 공지사항 메인에 뿌리기
		public List<NoticeVO> noticeList(int start, int end) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<NoticeVO> noticeList = null;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(
						"select notice_num, notice_title, notice_content, notice_count, notice_fi, notice_date "
								+ "from notice order by notice_fi desc, notice_date desc limit ?,?");
				pstmt.setInt(1, start - 1);
				pstmt.setInt(2, end);

				rs = pstmt.executeQuery();

				if (rs.next()) {
					noticeList = new ArrayList<NoticeVO>(end);
					do {
						NoticeVO notice = new NoticeVO();
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
		
		// 공지사항 상세페이지
		public NoticeVO noticeLayout(int num) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			NoticeVO noticelayout = null;
			
			try {
				conn = getConnection();
				conn.setAutoCommit(false);

				pstmt = conn.prepareStatement("select * from notice where notice_num = ?");
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();

				if (rs.next()) {
					noticelayout = new NoticeVO();
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
		
		public ArrayList<NoticeVO> notice(String select, String word, int start, int end) {
	        ArrayList<NoticeVO> noticeList = new ArrayList<NoticeVO>();
	        Connection conn = null;
	        PreparedStatement pstmt = null;
			ResultSet rs = null;
			StringBuffer sql = null;
	        
	        try {
	            conn = getConnection();
	            sql = new StringBuffer();
	 
	            if (select.equals("content")) {
	                sql.append("select notice_num, notice_title, notice_content, notice_count, notice_fi, notice_date from notice where notice_content like ?");
	                sql.append(" order by notice_fi desc, notice_date desc limit ?,?");
	                pstmt = conn.prepareStatement(sql.toString());
	                pstmt.setString(1, "%" + word + "%");
	                pstmt.setInt(2, start - 1);
	                pstmt.setInt(3, end);
	 
	            } else if (select.equals("title")) {
	            	sql.append("select notice_num, notice_title, notice_content, notice_count, notice_fi, notice_date from notice where notice_content like ?");
	                sql.append(" order by notice_fi desc, notice_date desc limit ?,?");
	                pstmt = conn.prepareStatement(sql.toString());
	                pstmt.setString(1, "%" + word + "%");
	                pstmt.setInt(2, start - 1);
	                pstmt.setInt(3, end);
	                
	            } else if (select.equals("none")) { 
	                sql.append("select notice_num, notice_title, notice_content, notice_count, notice_fi, notice_date from notice where notice_content like ? or notice_title like ?");
	                sql.append(" order by notice_fi desc, notice_date desc limit ?,?");
	                pstmt = conn.prepareStatement(sql.toString());
	                pstmt.setString(1, "%" + word + "%");
	                pstmt.setString(2, "%" + word + "%");
	                pstmt.setInt(3, start - 1);
	                pstmt.setInt(4, end);
	                
	            }
	 
	            rs = pstmt.executeQuery(); // SELECT
	 
	            while (rs.next() == true) {
	                NoticeVO notice = new NoticeVO();
	                notice.setNotice_num(rs.getInt("notice_num"));
					notice.setNotice_title(rs.getString("notice_title"));
					notice.setNotice_content(rs.getString("notice_content"));
					notice.setNotice_count(rs.getInt("notice_count"));
					notice.setNotice_fi(rs.getBoolean("notice_fi"));
					notice.setNotice_date(rs.getDate("notice_date"));
					noticeList.add(notice);
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
	        return noticeList;
	    }

}
