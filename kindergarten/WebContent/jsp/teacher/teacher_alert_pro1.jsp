<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="attend.AttendanceDAO"%>
<%@ page import="attend.AlertVO"%>


<jsp:useBean id="alert" scope="page" class="attend.AlertVO">
   <jsp:setProperty name="alert" property="teacher_id"/>
   <jsp:setProperty name="alert" property="alert_content"/>
   <jsp:setProperty name="alert" property="alert_health"/>
   <jsp:setProperty name="alert" property="alert_tem"/>
   <jsp:setProperty name="alert" property="alert_poo"/>
   <jsp:setProperty name="alert" property="alert_sleep"/>
   <jsp:setProperty name="alert" property="alert_food"/>
   <jsp:setProperty name="alert" property="parents_id"/>
</jsp:useBean>    

<%
   Calendar cal = Calendar.getInstance();
   String date = cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH)+1) + "-" +cal.get(Calendar.DAY_OF_MONTH);
   String time = cal.get(Calendar.HOUR) + ":" + cal.get(Calendar.MINUTE) + ":00";
   
   AttendanceDAO dbPro = AttendanceDAO.getInstance();
   //System.out.println(request.getParameter("all_or_one"));
   if(request.getParameter("today") != null){
      String today = request.getParameter("today");
      
      if(request.getParameter("teacher_id") != null && request.getParameter("all_or_one").equals("all")){
         String teacher_id = request.getParameter("teacher_id");
         //System.out.println(request.getParameter("all_content"));
         if(request.getParameter("all_content") != null){
            String all_content = request.getParameter("all_content");
            
            if(request.getParameter("crud").equals("insert")){
               int result = dbPro.insert_alert_all(teacher_id, all_content, java.sql.Date.valueOf(today));
               //System.out.println(result);
            }else if(request.getParameter("crud").equals("update")){
               int result = dbPro.update_alert_all(teacher_id, all_content, java.sql.Date.valueOf(today));
               //System.out.println(result);
            }
            %>
            {
               "teacher_id": "<%= teacher_id %>",
               "all_content" : "<%= all_content%>"
            }
            <%   

         }else if(request.getParameter("crud").equals("delete")){
            //System.out.println(request.getParameter("crud"));
            int result = dbPro.delete_alert_all(teacher_id, java.sql.Date.valueOf(today));
            String delete_result = null;
            if(result == 0){
               delete_result = "삭제성공";
            }else{
               delete_result = "삭제실패";
            }
            %>
            {
               "delete_result" : "<%= delete_result %>"
            }
            <%
         }
      }

   }
      if(alert != null && request.getParameter("all_or_one").equals("one") && request.getParameter("alert_date") != null){
            //String one_content = request.getParameter("one_content");
            
            //int child_num = Integer.parseInt(request.getParameter("child_num"));
            //String alert_all_content = request.getParameter("alert_all_content");
            //String parents_id = request.getParameter("parents_id");
            //alert.setAlert_date(java.sql.Date.valueOf(date));
            //alert.setAlert_content(one_content);
            
            int result = dbPro.insert_alert_one(alert, java.sql.Date.valueOf(request.getParameter("alert_date")));
            //System.out.println(result);
            //System.out.println(alert.getAlert_content());
         
      }
%>


