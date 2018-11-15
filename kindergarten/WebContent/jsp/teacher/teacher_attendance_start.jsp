<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8");%>

<%
	int childnum = Integer.parseInt(request.getParameter("child_num"));
	String day = request.getParameter("date");
	String starttime = request.getParameter("attendance_start_time");
	String endtime = request.getParameter("attendance_end_time");
	
	
	//out.println(childnum);
	//out.println(day); 
	//out.println(starttime); 
	//out.println(endtime); 


%>