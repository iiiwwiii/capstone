<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="picture.ScheduleDAO"%>
    
<% request.setCharacterEncoding("utf-8");%> 

<jsp:useBean id="schedule" scope="page" class="picture.ScheduleVO">
   <jsp:setProperty name="schedule" property="class_name"/>
   <jsp:setProperty name="schedule" property="schedule_title"/>
   <jsp:setProperty name="schedule" property="schedule_content"/>
   <jsp:setProperty name="schedule" property="writer"/>
</jsp:useBean>

<% 
   ScheduleDAO dbPro = ScheduleDAO.getInstance();
   
   schedule.setSchedule_date(java.sql.Date.valueOf(request.getParameter("schedule_date")));
   schedule.setSchedule_start_time(java.sql.Time.valueOf(request.getParameter("schedule_start_time")+":00"));
   schedule.setSchedule_end_time(java.sql.Time.valueOf(request.getParameter("schedule_end_time")+":00"));
   
   if(schedule.getClass_name() != null ){
      int result = dbPro.register_schedule(schedule);
      if(result == 1 ){
      %>
         <script>
         
         alert("fail");
         
         </script>
      <%
      response.sendRedirect("teacher_schedule_Form.jsp");
      }else if(result == 0){
         response.sendRedirect("teacher_schedule_Form.jsp");
      }   
   }

%>

