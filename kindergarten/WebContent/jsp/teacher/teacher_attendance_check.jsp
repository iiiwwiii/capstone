<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="attend.AttendanceDAO"%>
<%@ page import="attend.AttendanceVO"%>

 
<%
   int result_start = 2;
   int result_end = 2;
   int result_absence = 2;
   int result_absence_del = 2;
   List<AttendanceVO> attendanceList = null;
   AttendanceVO attend = null;
   //sSystem.out.println("sdfsd");
   
   AttendanceDAO dbPro = AttendanceDAO.getInstance();
   if(request.getParameter("child_num") != null && request.getParameter("today") != null){
      System.out.println(request.getParameter("today"));
      int child_num = Integer.parseInt(request.getParameter("child_num"));
      String today = request.getParameter("today");
      Calendar cal = Calendar.getInstance();
      //String date = cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH)+1) + "-" +cal.get(Calendar.DAY_OF_MONTH);
      String time = cal.get(Calendar.HOUR) + ":" + cal.get(Calendar.MINUTE) + ":00";
      if(request.getParameter("start_or_end").equals("start") || request.getParameter("start_or_end").equals("end")){
         
         if(request.getParameter("start_or_end").equals("start")){
            result_start = dbPro.insert_attendance_start(child_num, java.sql.Date.valueOf(today), java.sql.Time.valueOf(time));
            System.out.println(request.getParameter("today"));
         }else if (request.getParameter("start_or_end").equals("end")){
            result_end = dbPro.insert_attendance_end(child_num, java.sql.Date.valueOf(today), java.sql.Time.valueOf(time));
               
            //System.out.println(result_end);
         }
         
         if(result_start == 0 || result_end == 0){
            attend = dbPro.get_attendance_by_Child(child_num, java.sql.Date.valueOf(today));
               if(attend != null){
                   %>
                   {
                      "child_num" : "<%= attend.getChild_num() %>",
                      "start_time" : "<%= attend.getAttendance_start_time() %>",
                      "end_time" : "<%= attend.getAttendance_end_time() %>",
                      "attendance_date" : "<%= attend.getAttendance_date() %>",
                      "absence" : "<%= attend.getAttendance_absence() %>"
                   }
                   <%
               }
         }
         
      }else if (request.getParameter("start_or_end").equals("absence")){
         result_absence = dbPro.check_absence(child_num, java.sql.Date.valueOf(today));
         if(result_absence == 0){
            %>
            {
               "result": "<%= result_absence%>",
               "child_num": "<%= child_num %>",
               "child_name": ""
            }
            <%
         }
         //System.out.println(result_absence);
      }else if (request.getParameter("start_or_end").equals("absence_del")){
         result_absence_del = dbPro.delete_absence(child_num, java.sql.Date.valueOf(today));
         if(result_absence_del == 0){
            String child_name = dbPro.get_child_name(child_num);
            %>
            {
               "result_absence_del" : "<%= result_absence_del %>",
               "child_num" : "<%= child_num %>",
               "child_name" : "<%= child_name %>"
            }
            <%
         }else{
            %>
            {
               "result_absence_del" : "실패",
               "child_num" : "null",
               "child_name" : "null"
            }
            <%
         }
      
         //System.out.println(result_absence);
      }

      
   }
%>