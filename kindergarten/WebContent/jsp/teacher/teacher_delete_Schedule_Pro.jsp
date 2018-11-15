<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="picture.ScheduleDAO"%>
    
<% request.setCharacterEncoding("utf-8");%> 

<% 
   if(request.getParameter("oneSchedule") != null){
      ScheduleDAO dbPro = ScheduleDAO.getInstance();
      
      int result = dbPro.delete_Schedule(Integer.parseInt(request.getParameter("oneSchedule")));
      
      if(result == 0){
         response.sendRedirect("teacher_schedule_Form.jsp");
      }
   }
%>


