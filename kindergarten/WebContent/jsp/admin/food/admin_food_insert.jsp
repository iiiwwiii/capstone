<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.admin.AdminDAO" %>
<%@page import="java.sql.Date"%>   

<% request.setCharacterEncoding("utf-8");%>

<%
	String foodda = request.getParameter("fooddate");
	Date fooddate = java.sql.Date.valueOf(foodda);
	 
	 
	String[] menuname = request.getParameterValues("menuname");
	 

	AdminDAO dao = AdminDAO.getInstance();
	dao.foodInsert(menuname, fooddate);	

	response.sendRedirect("admin_food_list.jsp");
%>
