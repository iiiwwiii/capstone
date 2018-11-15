package picture;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Date;


public class ScheduleDAO {

	private static ScheduleDAO instance = new ScheduleDAO();

	public static ScheduleDAO getInstance() {
		return instance;
	}

	private ScheduleDAO() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/aban");
		return ds.getConnection();
	}
	
	//insert (teacher)
	//if (success) -> result == 0;
	//     else    -> result == 1; 
	public int register_schedule(ScheduleVO schedule) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("insert into schedule (class_name, schedule_date, schedule_start_time, schedule_end_time, schedule_title, schedule_content, writer)" + 
											" values (A,?,?,?,?,?,?)");
			pstmt.setString(1, schedule.getClass_name());
			pstmt.setDate(2, schedule.getSchedule_date());
			pstmt.setTime(3, schedule.getSchedule_start_time());
			pstmt.setTime(4, schedule.getSchedule_end_time());
			pstmt.setString(5, schedule.getSchedule_title());
			pstmt.setString(6, schedule.getSchedule_content());
			pstmt.setString(7, schedule.getWriter());
			pstmt.executeUpdate();
			
			
			pstmt = conn.prepareStatement("select max(schedule_num) from schedule");
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
            	pstmt = conn.prepareStatement("insert into album (schedule_num, album_title, class_name) values (?,?,A)");
            	pstmt.setInt(1, rs.getInt("max(schedule_num)"));
            	pstmt.setString(2, schedule.getSchedule_title());
            	pstmt.setString(3, schedule.getClass_name());
            	pstmt.executeUpdate();
            }
			

		} catch (Exception e) {
			result = 1;
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
			if (rs != null) 
				try { 
					rs.close(); 
				} catch(SQLException ex) {
					
				}
		}
		return result;
	}
			
	//select (parents_main.jsp or teacher_main.jsp ->> today)
	public List<ScheduleVO> get_TodaySchedule(Date date)
             throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ScheduleVO> scheduleList=null;

        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement("select * from schedule where schedule_date = ?");
            pstmt.setDate(1, date);
            rs = pstmt.executeQuery();

            if (rs.next()) {
            	scheduleList = new ArrayList<ScheduleVO>();	
                do{			 
                	ScheduleVO schedule= new ScheduleVO();	
                	schedule.setSchedule_num(rs.getInt("schedule_num"));
                	schedule.setSchedule_date(rs.getDate("schedule_date"));
                	schedule.setClass_name(rs.getString("class_name"));	                	
                	schedule.setSchedule_start_time(rs.getTime("schedule_start_time"));
                	schedule.setSchedule_end_time(rs.getTime("schedule_end_time"));
                	schedule.setSchedule_title(rs.getString("schedule_title"));	
                	schedule.setSchedule_content(rs.getString("schedule_content"));	
                	schedule.setWriter(rs.getString("writer"));
                	scheduleList.add(schedule);			
                 
			    }while(rs.next());		
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return scheduleList;
    }
	
	//select (parents_main.jsp or teacher_main.jsp ->> today)
		public List<ScheduleVO> get_schedule_group()
	             throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        List<ScheduleVO> scheduleList=null;

	        try {
	            conn = getConnection();
	            
	            pstmt = conn.prepareStatement("select * from schedule group by schedule_date order by schedule_date desc;");
	            //pstmt.setDate(1, java.sql.Date.valueOf(today));
	            rs = pstmt.executeQuery();

	            if (rs.next()) {
	            	scheduleList = new ArrayList<ScheduleVO>();	
	                do{			 
	                	ScheduleVO schedule= new ScheduleVO();	
	                	schedule.setSchedule_num(rs.getInt("schedule_num"));
	                	schedule.setClass_name(rs.getString("class_name"));	                
	                	schedule.setSchedule_date(rs.getDate("schedule_date"));
	                	schedule.setSchedule_start_time(rs.getTime("schedule_start_time"));
	                	schedule.setSchedule_end_time(rs.getTime("schedule_end_time"));
	                	schedule.setSchedule_title(rs.getString("schedule_title"));		
	                	schedule.setSchedule_content(rs.getString("schedule_content"));	
	                	schedule.setWriter(rs.getString("writer"));
	                	scheduleList.add(schedule);			
	                 
				    }while(rs.next());		
				}
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return scheduleList;
	    }		
		
		
		//select (parents_main.jsp or teacher_main.jsp ->> today)
		public List<ScheduleVO> get_schedule_group_album() throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ScheduleVO> scheduleList = null;
	
			try {
				conn = getConnection();
	
				pstmt = conn.prepareStatement(
						"select * from schedule where schedule_num in (select schedule_num from album where album_content is not null) "
								+ "group by schedule_date desc");
				// pstmt.setDate(1, java.sql.Date.valueOf(today));
				rs = pstmt.executeQuery();
	
				if (rs.next()) {
					scheduleList = new ArrayList<ScheduleVO>();
					do {
						ScheduleVO schedule = new ScheduleVO();
						schedule.setSchedule_num(rs.getInt("schedule_num"));
						schedule.setClass_name(rs.getString("class_name"));
						schedule.setSchedule_date(rs.getDate("schedule_date"));
						schedule.setSchedule_start_time(rs.getTime("schedule_start_time"));
						schedule.setSchedule_end_time(rs.getTime("schedule_end_time"));
						schedule.setSchedule_title(rs.getString("schedule_title"));
						schedule.setSchedule_content(rs.getString("schedule_content"));
						schedule.setWriter(rs.getString("writer"));
						scheduleList.add(schedule);
	
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
			return scheduleList;
		}		
		
		public List<ScheduleVO> get_schedule_in_modal(String search) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null, rs1 = null;
			List<ScheduleVO> scheduleList = null;
			String sql = null;
	
			try {
				conn = getConnection();
	
				if (search.equals("")) {
					pstmt = conn.prepareStatement("select * from schedule order by schedule_date desc");
				}else {}
	
				if (search.length() == 10 && search.substring(4, 5).equals("-") && search.substring(7, 8).equals("-")) {
					pstmt = conn.prepareStatement("select * from schedule where schedule_date = ? order by schedule_date desc");
					pstmt.setDate(1, java.sql.Date.valueOf(search));
				} else {
					pstmt = conn.prepareStatement("select * from schedule where schedule_title like ? order by schedule_date desc");
					pstmt.setString(1, "%" + search + "%");
				}
				
				rs = pstmt.executeQuery();
	
				if (rs.next()) {
					scheduleList = new ArrayList<ScheduleVO>();
					do {
						pstmt = conn.prepareStatement("select album_num from album where schedule_num = ?");
						pstmt.setInt(1, rs.getInt("schedule_num"));
						rs1 = pstmt.executeQuery();
						if (rs1.next()) {
							ScheduleVO schedule = new ScheduleVO();
							schedule.setSchedule_num(rs1.getInt("album_num"));
							schedule.setClass_name(rs.getString("class_name"));
							schedule.setSchedule_date(rs.getDate("schedule_date"));
							schedule.setSchedule_start_time(rs.getTime("schedule_start_time"));
							schedule.setSchedule_end_time(rs.getTime("schedule_end_time"));
							schedule.setSchedule_title(rs.getString("schedule_title"));
							schedule.setSchedule_content(rs.getString("schedule_content"));
							schedule.setWriter(rs.getString("writer"));
							scheduleList.add(schedule);
						}
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
			return scheduleList;
		}		
		
		//select (parents_main.jsp or teacher_main.jsp ->> today)
		public List<ScheduleVO> get_AllSchedule() throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        List<ScheduleVO> scheduleList=null;

	        try {
	            conn = getConnection();
	            
	            pstmt = conn.prepareStatement("select * from schedule");
	            //pstmt.setDate(1, java.sql.Date.valueOf(today));
	            rs = pstmt.executeQuery();

	            if (rs.next()) {
	            	scheduleList = new ArrayList<ScheduleVO>();	
	                do{			 
	                	ScheduleVO schedule= new ScheduleVO();	
	                	schedule.setSchedule_num(rs.getInt("schedule_num"));
	                	schedule.setClass_name(rs.getString("class_name"));	                
	                	schedule.setSchedule_date(rs.getDate("schedule_date"));
	                	schedule.setSchedule_start_time(rs.getTime("schedule_start_time"));
	                	schedule.setSchedule_end_time(rs.getTime("schedule_end_time"));
	                	schedule.setSchedule_title(rs.getString("schedule_title"));		
	                	schedule.setSchedule_content(rs.getString("schedule_content"));	
	                	schedule.setWriter(rs.getString("writer"));
	                	scheduleList.add(schedule);			
	                 
				    }while(rs.next());		
				}
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return scheduleList;
	    }		
		
		//�ٹ� ������ �ҷ����� input -> (album_num), output -> (ImageVO Arraylist)
		//select (parents_main.jsp or teacher_main.jsp ->> today)
		public List<ImageVO> get_album_detail(int album_num) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ImageVO> imageList = null;
	
			try {
				conn = getConnection();
	
				pstmt = conn.prepareStatement("select image_num, album_num, image_name from image where album_num = ?");
				pstmt.setInt(1, album_num);
				rs = pstmt.executeQuery();
	
				if (rs.next()) {
					imageList = new ArrayList<ImageVO>();
					do {
						ImageVO image = new ImageVO();
						image.setImage_num(rs.getInt("image_num"));
						image.setAlbum_num(rs.getInt("album_num"));
						image.setImage_name(rs.getString("image_name"));
						imageList.add(image);
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
			return imageList;
		}	
				
		//select (parents_main.jsp or teacher_main.jsp ->> today)
		public List<AlbumVO> get_album_input_y(int album_num) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<AlbumVO> albumList = null;
	
			try {
				conn = getConnection();
	
				pstmt = conn
						.prepareStatement("select album_num, album_title, album_content from album where album_num = ?");
				pstmt.setInt(1, album_num);
				rs = pstmt.executeQuery();
	
				if (rs.next()) {
					albumList = new ArrayList<AlbumVO>();
					do {
						AlbumVO album = new AlbumVO();
						album.setAlbum_num(rs.getInt("album_num"));
						album.setAlbum_title(rs.getString("album_title"));
						album.setAlbum_content(rs.getString("album_content"));
						albumList.add(album);
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
			return albumList;
		}
		
		//update table schedule (teacher_schedule.jsp)
		//if (success) -> result == 0;
		//     else    -> result == 1; 
		public int update_Schedule(ScheduleVO schedule) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result = 0;
	
			try {
				conn = getConnection();
				conn.setAutoCommit(false);
				pstmt = conn.prepareStatement("update schedule set class_name =? , schedule_date = ? , schedule_start_time = ?, schedule_end_time = ?, "
											+"schedule_title = ? , schedule_content = ?, writer=? where schedule_num = ?");
				pstmt.setString(1, schedule.getClass_name());
				pstmt.setDate(2, schedule.getSchedule_date());
				pstmt.setTime(3, schedule.getSchedule_start_time());
				pstmt.setTime(4, schedule.getSchedule_end_time());
				pstmt.setString(5, schedule.getSchedule_title());
				pstmt.setString(6, schedule.getSchedule_content());
				pstmt.setString(7, schedule.getWriter());
				pstmt.setInt(8, schedule.getSchedule_num());
				pstmt.executeUpdate();
	
			} catch (Exception e) {
				result = 1;
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
			return result;
		}	
	
		//delete (teacher_*.jsp -> <used method when schedule is deleted>)
		//if (success) -> result == 0;
		//     else    -> result == 1; 
		public int delete_Schedule(int schedule_num) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result = 0;
	
			try {
				conn = getConnection();
				
				pstmt = conn.prepareStatement("delete from schedule where schedule_num = ?");
				pstmt.setInt(1, schedule_num);
				pstmt.executeUpdate();
				
				pstmt = conn.prepareStatement("delete from album where schedule_num = ?");
				pstmt.setInt(1, schedule_num);
				pstmt.executeUpdate();
				
				pstmt = conn.prepareStatement("delete from image where album_num in (select album_num from album where schedule_num = ?)");
				pstmt.setInt(1, schedule_num);
				pstmt.executeUpdate();
	
			} catch (Exception e) {
				result = 1;
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
			return result;
		}
	
		public int add_picture(int album_num, String album_content, String file_name) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result = 0;
			
			try {
				conn = getConnection();
				//album�� album_title�ִ´�
				pstmt = conn.prepareStatement("update album set album_content = ? where album_num=?");
				pstmt.setString(1, album_content);
				pstmt.setInt(2, album_num);
				pstmt.executeUpdate();
				
				pstmt = conn.prepareStatement("insert into image (album_num, image_name) values (?,?)");
				pstmt.setInt(1, album_num);
				pstmt.setString(2, file_name);
				pstmt.executeUpdate();
				
	
			} catch (Exception e) {
				result = 1;
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
			return result;
		}
	
		//��¥����Ʈ �ҷ�����
		 //select distinct schedule_date from schedule order by schedule_date desc
		//select album_num, album_title, album_content from album where schedule_num in (select schedule_num from schedule where schedule_date = '2018-11-14');
		
		//rand�Լ��� �Ἥ ��ǥ������ �������� �ҷ��� �� �ִ�. teacher_album.jsp���� �ٹ��� �ѷ��ִµ� �ʿ��� �޼���
		//select image_name from image where image_num in (select distinct round(10*rand(image_num)) from image) limit 1 -> ��ǥ�����ҷ����� ����
	
		public List<AlbumVO> get_album_list(Date schedule_date) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<AlbumVO> albumList = null;
	
		try {
			conn = getConnection();

			//
			pstmt = conn.prepareStatement(
					"select a.album_num, album_title, album_content, image_name from album a, image i "
							+ "where a.album_num = i.album_num and schedule_num in (select schedule_num from schedule where schedule_date = ?) group by a.album_num");
			pstmt.setDate(1, schedule_date);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				albumList = new ArrayList<AlbumVO>();
				do {
					AlbumVO album = new AlbumVO();
					album.setAlbum_num(rs.getInt("album_num"));
					album.setAlbum_title(rs.getString("album_title"));
					album.setAlbum_content(rs.getString("album_content"));
					album.setAlbum_title_image(rs.getString("image_name"));
					albumList.add(album);
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
		return albumList;
	}

}
