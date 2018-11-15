package attend;

import java.io.*;
import javax.servlet.http.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import user.child.ChildVO;

import java.sql.Date;

public class AttendanceDAO {

   private static AttendanceDAO instance = new AttendanceDAO();

   public static AttendanceDAO getInstance() {
      return instance;
   }

   private AttendanceDAO() {
   }

   private Connection getConnection() throws Exception {
      Context initCtx = new InitialContext();
      Context envCtx = (Context) initCtx.lookup("java:comp/env");
      DataSource ds = (DataSource) envCtx.lookup("jdbc/aban");
      return ds.getConnection();
   }
   

   //insert_attendance_start()
   //占쏙옙占쏙옙占싣곤옙占쏙옙占쏙옙占� attendance占쏙옙占싱븝옙占쏙옙 child_num, attendance_date, attendance_start_time, attendance_absence == false占싱니깍옙 0占쏙옙占쏙옙 insert
   public int insert_attendance_start(int child_num, Date attendance_date, Time attendance_start_time) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      int result = 0;
      
      //HttpServletResponse response = getOutputStream();
      //PrintWriter out = response.getWriter();
      SimpleDateFormat sf = new SimpleDateFormat("hh:mm");
      
      
      try {
         conn = getConnection();
         pstmt = conn.prepareStatement("select * from attendance where child_num = ? and attendance_date = ?");
         pstmt.setInt(1, child_num);
         pstmt.setDate(2, attendance_date);
         rs = pstmt.executeQuery();
         
         if(!rs.next()) {
            pstmt = conn.prepareStatement("insert into attendance (child_num, attendance_date, attendance_start_time, attendance_absence) values (?,?,?,?)");
            pstmt.setInt(1, child_num);
            pstmt.setDate(2, attendance_date);
            pstmt.setTime(3, attendance_start_time);
            pstmt.setInt(4, 0);
            pstmt.executeUpdate();
         }else {
            return 1;
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
      }
      return result;
   }
   //insert_attendance_end()
      //占싹울옙占쏙옙튼占쏙옙 占쏙옙占쏙옙占쏙옙 child_num占쏙옙 占쏙옙占쏙옙 update占쏙옙占쏙옙.
      public int insert_attendance_end(int child_num, Date attendance_date,Time attendance_end_time) {
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         int result = 0;
         
         
         try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement("select * from attendance where child_num = ? and attendance_date = ?");
            pstmt.setInt(1, child_num);
            pstmt.setDate(2, attendance_date);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
               pstmt = conn.prepareStatement("update attendance set attendance_end_time = ? where child_num = ? and attendance_date = ?");
               pstmt.setTime(1, attendance_end_time);
               pstmt.setInt(2, child_num);
               pstmt.setDate(3, attendance_date);
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
         }
         return result;
      }
   //check_absence()
      public int check_absence(int child_num, Date date) {
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         int result = 0;

         try {
            conn = getConnection();
            pstmt = conn.prepareStatement("select * from attendance where child_num = ? and attendance_date = ?");
            pstmt.setInt(1, child_num);
            pstmt.setDate(2, date);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
               pstmt = conn.prepareStatement("update attendance set attendance_absence = ? where child_num = ? and attendance_date = ?");
               pstmt.setInt(1, 1);
               pstmt.setInt(2, child_num);
               pstmt.setDate(3, date);
            }else {
               pstmt = conn.prepareStatement("insert into attendance (child_num, attendance_date, attendance_absence) values (?,?,1)");
               pstmt.setInt(1, child_num);
               pstmt.setDate(2, date);
            }
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
      
      
        //delete_absence()
            public int delete_absence(int child_num, Date today) {
               Connection conn = null;
               PreparedStatement pstmt = null;
               ResultSet rs = null;
               int result = 0;

               try {
                  conn = getConnection();
                  pstmt = conn.prepareStatement("select * from attendance where child_num = ? and attendance_date = ?");
                  pstmt.setInt(1, child_num);
                  pstmt.setDate(2, today);
                  rs = pstmt.executeQuery();
                  
                  if(rs.next()) {
                     pstmt = conn.prepareStatement("delete from attendance where child_num = ? and attendance_date = ?");
                     pstmt.setInt(1, child_num);
                     pstmt.setDate(2, today);
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
               }
               return result;
            }
            
             //insert_alert()
               //
                              
            
               
               
   
   ////////get start /////////
   //get_Child(String teacher)

       public List<ChildVO> get_Child(String teacher_id)
                 throws Exception {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null, rs1 = null;
            List<ChildVO> childList=null;

            try {
                conn = getConnection();
                
               pstmt = conn.prepareStatement("select teacher_class from teacher where teacher_id = ?");
               pstmt.setString(1, teacher_id);
               rs = pstmt.executeQuery();
               
               if(rs.next()) {
                   pstmt = conn.prepareStatement("select child.*, parents_phone from child, parents where child.parents_id = parents.parents_id and child_class = ? order by child_num");
                    pstmt.setString(1, rs.getString("teacher_class"));
                    rs1 = pstmt.executeQuery();
                    
                    if(rs1.next()) {
                       childList = new ArrayList<ChildVO>();   
                        do{          
                           ChildVO child = new ChildVO();   
                           child.setChild_num(rs1.getInt("child.child_num"));
                           child.setParents_id(rs1.getString("child.parents_id"));                   
                           child.setChild_class(rs1.getString("child.child_class"));
                           child.setChild_name(rs1.getString("child.child_name"));
                           child.setChild_sex(rs1.getString("child.child_sex"));
                           child.setChild_birth(rs1.getDate("child.child_birth"));
                           child.setChild_post(rs1.getString("child.child_post"));
                           child.setChild_addr(rs1.getString("child.child_addr"));
                           child.setChild_pic(rs1.getString("child.child_pic"));
                           child.setChild_memo(rs1.getString("child.child_memo"));
                           child.setChild_date(rs1.getTimestamp("child.child_date"));
                           child.setParents_name("");
                           child.setParents_phone(rs1.getString("parents_phone"));
                           childList.add(child);         
                         
                     }while(rs1.next());
                    }
               }
                
               

                if (rs.next()) {
                   
                         
             }
            } catch(Exception ex) {
                ex.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch(SQLException ex) {}
                if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
                if (conn != null) try { conn.close(); } catch(SQLException ex) {}
            }
          return childList;
        }
       
       public AttendanceVO get_attendance_by_Child(int child_num, Date today)
                throws Exception {
           Connection conn = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;
           AttendanceVO attend = null;

           try {
               conn = getConnection();
               
              pstmt = conn.prepareStatement("select * from attendance where child_num = ? and attendance_date = ?");
               pstmt.setInt(1, child_num);
               pstmt.setDate(2, today);
               rs = pstmt.executeQuery();
               
               if(rs.next()) {          
                        attend = new AttendanceVO();   
                        attend.setChild_num(rs.getInt("child_num"));                   
                        attend.setAttendance_date(rs.getDate("attendance_date"));
                        attend.setAttendance_start_time(rs.getTime("attendance_start_time"));
                        attend.setAttendance_end_time(rs.getTime("attendance_end_time"));
                        attend.setAttendance_absence(rs.getInt("attendance_absence"));
                        attend.setTo_teacher(rs.getString("to_teacher"));   
                    }
               
           } catch(Exception ex) {
               ex.printStackTrace();
           } finally {
               if (rs != null) try { rs.close(); } catch(SQLException ex) {}
               if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
               if (conn != null) try { conn.close(); } catch(SQLException ex) {}
           }
         return attend;
       }   
       
       public int insert_to_teacher(To_teacherVO to_teacher) {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs1 = null, rs2 = null;
          int result = 0;

          
          try {
             conn = getConnection();
             //;
             pstmt = conn.prepareStatement("select child_class from child where parents_id = ?");
             pstmt.setString(1, to_teacher.getParents_id());
          
             rs1 = pstmt.executeQuery();
             
             if(rs1.next()) {

                pstmt = conn.prepareStatement("select teacher_class, teacher_id from teacher where teacher_class= ?");
                 pstmt.setString(1, rs1.getString("child_class"));
                 rs2 = pstmt.executeQuery();
                 
                 if(rs2.next()) {
                    pstmt = conn.prepareStatement("insert into to_teacher (class_name, parents_id, teacher_id, absence, start_date, end_date, to_content) "
                          + "values (?,?,?,?,?,?,?)");
                     pstmt.setString(1, rs2.getString("teacher_class"));
                     pstmt.setString(2, to_teacher.getParents_id());
                     pstmt.setString(3, rs2.getString("teacher_id"));
                     pstmt.setInt(4, to_teacher.getAbsence());
                     pstmt.setDate(5, to_teacher.getStart_date());
                     pstmt.setDate(6, to_teacher.getEnd_date());
                     pstmt.setString(7, to_teacher.getTo_content());
                     
                     pstmt.executeUpdate();
                 }
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
             if (rs1 != null) try { rs1.close(); } catch(SQLException ex) {}
             if (rs2 != null) try { rs2.close(); } catch(SQLException ex) {}
          }
          return result;
       }
       
       
       public List<To_teacherVO> get_to_teacher(String parents_id)
                throws Exception {
           Connection conn = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;
           List<To_teacherVO> to_teacherList = null;

           try {
               conn = getConnection();
               
             pstmt = conn.prepareStatement("select * from to_teacher where parents_id= ?");
            pstmt.setString(1, parents_id);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
               to_teacherList = new ArrayList<To_teacherVO>();
               do{
                  To_teacherVO to_teacher_out = new To_teacherVO();
                  to_teacher_out.setTo_num(rs.getInt("to_num"));
                  to_teacher_out.setClass_name(rs.getString("class_name"));
                  to_teacher_out.setParents_id(rs.getString("parents_id"));
                  to_teacher_out.setTeacher_id(rs.getString("teacher_id"));
                  to_teacher_out.setAbsence(rs.getInt("absence"));
                  to_teacher_out.setStart_date(rs.getDate("start_date"));
                  to_teacher_out.setEnd_date(rs.getDate("end_date"));
                  to_teacher_out.setTo_content(rs.getString("to_content"));
                  
                  to_teacherList.add(to_teacher_out);
               }while(rs.next());
            }
               
           } catch(Exception ex) {
               ex.printStackTrace();
           } finally {
               if (rs != null) try { rs.close(); } catch(SQLException ex) {}
               if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
               if (conn != null) try { conn.close(); } catch(SQLException ex) {}
           }
         return to_teacherList;
       }   
       
       
       public To_teacherVO get_to_teacher_in_teacher(String parents_id, Date today)
               throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          To_teacherVO to_teacher_out = null;

          try {
              conn = getConnection();
              
            pstmt = conn.prepareStatement("select * from to_teacher where parents_id= ? and start_date = ?");
           pstmt.setString(1, parents_id);
           rs = pstmt.executeQuery();
           
           if(rs.next()) {
                 to_teacher_out = new To_teacherVO();
                 to_teacher_out.setTo_num(rs.getInt("to_num"));
                 to_teacher_out.setClass_name(rs.getString("class_name"));
                 to_teacher_out.setParents_id(rs.getString("parents_id"));
                 to_teacher_out.setTeacher_id(rs.getString("teacher_id"));
                 to_teacher_out.setAbsence(rs.getInt("absence"));
                 to_teacher_out.setStart_date(rs.getDate("start_date"));
                 to_teacher_out.setEnd_date(rs.getDate("end_date"));
                 to_teacher_out.setTo_content(rs.getString("to_content"));

           }
              
          } catch(Exception ex) {
              ex.printStackTrace();
          } finally {
              if (rs != null) try { rs.close(); } catch(SQLException ex) {}
              if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
              if (conn != null) try { conn.close(); } catch(SQLException ex) {}
          }
        return to_teacher_out;
      }   

   
       public String get_all_alert(String teacher_id, Date a_date)
                throws Exception {
           Connection conn = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;
           String out = null;

           try {
               conn = getConnection();
               
             pstmt = conn.prepareStatement("select a_content from alert_all where teacher_id= ? and a_date = ?");
            pstmt.setString(1, teacher_id);
            pstmt.setDate(2, a_date);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
               out =  rs.getString("a_content");
            }
               
           } catch(Exception ex) {
                 out = "error";
               ex.printStackTrace();
           } finally {
               if (rs != null) try { rs.close(); } catch(SQLException ex) {}
               if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
               if (conn != null) try { conn.close(); } catch(SQLException ex) {}
           }
         return out;
       }   
       
       public int insert_alert_all(String teacher_id, String alert_all_content, Date alert_date) {
         Connection conn = null;
         PreparedStatement pstmt = null;
         int result = 0;
         
         
         try {
            conn = getConnection();

               pstmt = conn.prepareStatement("insert into alert_all values (?,?,?)");
               pstmt.setDate(1, alert_date);
               pstmt.setString(2, teacher_id);
               pstmt.setString(3, alert_all_content);
               
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

       
       public int update_alert_all(String teacher_id, String alert_all_content, Date alert_date) {
         Connection conn = null;
         PreparedStatement pstmt = null;
         int result = 0;
         
         
         try {
            conn = getConnection();

               pstmt = conn.prepareStatement("update alert_all set a_content = ? where teacher_id = ? and a_date=?");
               pstmt.setString(1, alert_all_content);
               pstmt.setString(2, teacher_id);
               pstmt.setDate(3, alert_date);
               
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
       
      public int delete_alert_all(String teacher_id, Date alert_date) {
         Connection conn = null;
         PreparedStatement pstmt = null;
         int result = 0;
         
         
         try {
            conn = getConnection();

               pstmt = conn.prepareStatement("delete from alert_all where teacher_id = ? and a_date=?");
               pstmt.setString(1, teacher_id);
               pstmt.setDate(2, alert_date);
               
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
      
      
      //alert_one CRUD
      public int insert_alert_one(AlertVO alert, Date today) {
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         int result = 0;
         
         
         try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement("select * from alert where parents_id = ? and alert_date = ?");
            pstmt.setString(1, alert.getParents_id());
            pstmt.setDate(2, today);
             rs = pstmt.executeQuery();
             
             if(!rs.next()) {
                pstmt = conn.prepareStatement("insert into alert (teacher_id, alert_content, alert_health, alert_tem, alert_poo, alert_sleep, alert_food, parents_id, alert_date) " 
                      + "values (?,?,?,?,?,?,?,?,?)");
               pstmt.setString(1, alert.getTeacher_id());
               pstmt.setString(2, alert.getAlert_content());
               pstmt.setString(3, alert.getAlert_health());
               pstmt.setString(4, alert.getAlert_tem());
               pstmt.setString(5, alert.getAlert_poo());
               pstmt.setString(6, alert.getAlert_sleep());
               pstmt.setString(7, alert.getAlert_food());
               pstmt.setString(8, alert.getParents_id());
               pstmt.setDate(9, today);
               pstmt.executeUpdate();
             }else {
                return 1;
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
         }
         return result;
      }
      
      
      public int update_alert_one(AlertVO alert, Date today) {
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         int result = 0;
         
         
         try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement("select * from alert where parents_id = ? and alert_date = ?");
            pstmt.setString(1, alert.getParents_id());
            pstmt.setDate(2, today);
             rs = pstmt.executeQuery();
             
             if(rs.next()) {
                pstmt = conn.prepareStatement("update alert set alert_content = ?, alert_health = ?, alert_tem = ?, alert_poo = ?, alert_sleep = ?, alert_food = ? " 
                      + "where parents_id = ? and alert_date = ? and teacher_id = ?");
               pstmt.setString(1, alert.getAlert_content());
               pstmt.setString(2, alert.getAlert_tem());
               pstmt.setString(3, alert.getAlert_poo());
               pstmt.setString(4, alert.getAlert_sleep());
               pstmt.setString(5, alert.getAlert_food());
               pstmt.setString(6, alert.getAlert_sleep());
               pstmt.setString(7, alert.getParents_id());
               pstmt.setDate(8, today);
               pstmt.setString(9, alert.getParents_id());
               pstmt.executeUpdate();
               
             }else {
                return 1;
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
         }
         return result;
      }
      
      public int delete_alert_one(AlertVO alert, Date today) {
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         int result = 0;
         
         
         try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement("select * from alert where parents_id = ? and alert_date = ?");
            pstmt.setString(1, alert.getParents_id());
            pstmt.setDate(2, today);
             rs = pstmt.executeQuery();
             
             if(rs.next()) {
                pstmt = conn.prepareStatement("delete from alert where parents_id = ? and alert_date = ? and teacher_id = ?");
               pstmt.setString(1, alert.getParents_id());
               pstmt.setDate(2, today);
               pstmt.setString(3, alert.getParents_id());
               pstmt.executeUpdate();
               
             }else {
                return 1;
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
         }
         return result;
      }
      
      
      public AlertVO get_alert_one(String parents_id, Date today) {
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         AlertVO alert = null;
         
         
         try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement("select * from alert where parents_id = ? and alert_date = ?");
            pstmt.setString(1, parents_id);
            pstmt.setDate(2, today);
             rs = pstmt.executeQuery();
             
             if(rs.next()) {
                alert = new AlertVO();
                alert.setTeacher_id(rs.getString("teacher_id"));
                alert.setAlert_content(rs.getString("alert_content"));
                alert.setAlert_health(rs.getString("alert_health"));
                alert.setAlert_tem(rs.getString("alert_tem"));
                alert.setAlert_poo(rs.getString("alert_poo"));
                alert.setAlert_sleep(rs.getString("alert_sleep"));
                alert.setAlert_food(rs.getString("alert_food"));
                alert.setParents_id(rs.getString("parents_id"));
                alert.setAlert_date(rs.getDate("alert_date"));
               
             }


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
         return alert;
      }
      
      
      public String get_child_name(int child_num)
                throws Exception {
           Connection conn = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;
           String child_name = null;

           try {
               conn = getConnection();
               
              pstmt = conn.prepareStatement("select child_name from child where child_num = ?");
               pstmt.setInt(1, child_num);
               rs = pstmt.executeQuery();
               
               if(rs.next()) {
                   child_name = rs.getString("child_name");
               }

           } catch(Exception ex) {
              child_name = "no..";
               ex.printStackTrace();
           } finally {
               if (rs != null) try { rs.close(); } catch(SQLException ex) {}
               if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
               if (conn != null) try { conn.close(); } catch(SQLException ex) {}
           }
         return child_name;
       }

      
   
}