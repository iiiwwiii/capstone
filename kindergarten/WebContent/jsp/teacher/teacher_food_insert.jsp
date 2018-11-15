<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.teacher.TeacherDAO" %>
<%@page import="java.sql.Date"%>   

<% request.setCharacterEncoding("utf-8");%>

<%
	String foodda = request.getParameter("fooddate");
	Date fooddate = java.sql.Date.valueOf(foodda);
	 
	String[] menuname = request.getParameterValues("menuname");

	TeacherDAO dao = TeacherDAO.getInstance();
	dao.foodInsert(menuname, fooddate);	

	response.sendRedirect("teacher_food_list.jsp");
%>
