<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.teacher.TeacherCalendarVO" %>
<%@ page import = "user.teacher.TeacherDAO" %>
<%@page import="java.sql.Date"%> 

<% request.setCharacterEncoding("utf-8");%>

<%
	String start = request.getParameter("calendar_start_date");
	Date calendar_start_date = java.sql.Date.valueOf(start);
	String end = request.getParameter("calendar_end_date");
	Date calendar_end_date = java.sql.Date.valueOf(end); 
	String calendar_title = request.getParameter("calendar_title");
	 
	TeacherDAO dao = TeacherDAO.getInstance();
	dao.calendarInsert(calendar_start_date, calendar_end_date, calendar_title);	

	response.sendRedirect("teacher_calendar_list.jsp");
%>

