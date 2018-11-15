<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.teacher.TeacherDAO" %>
<%@ page import = "user.teacher.TeacherFoodVO" %>

<%
	String food_num = request.getParameter("food_num");
 
	TeacherDAO dao = TeacherDAO.getInstance();
	dao.fooddelete(food_num);   
	 
	response.sendRedirect("teacher_food_list.jsp");
%>