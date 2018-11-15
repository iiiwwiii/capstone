<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.admin.AdminDAO" %>
<%@ page import = "user.admin.AdminCalendarVO" %>
<%@page import="java.sql.Date"%> 

<% request.setCharacterEncoding("utf-8");%>

<%
	String start = request.getParameter("calendar_start_date");
	Date calendar_start_date = java.sql.Date.valueOf(start);
	String end = request.getParameter("calendar_end_date");
	Date calendar_end_date = java.sql.Date.valueOf(end); 
	String calendar_title = request.getParameter("calendar_title");
	 
	AdminDAO dao = AdminDAO.getInstance();
	dao.calendarInsert(calendar_start_date, calendar_end_date, calendar_title);	

	response.sendRedirect("admin_calendar_list.jsp");
%>

