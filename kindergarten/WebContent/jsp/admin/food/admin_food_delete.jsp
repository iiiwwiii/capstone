<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.admin.AdminDAO" %>
<%@ page import = "user.admin.AdminFoodVO" %>
<%

	String food_num = request.getParameter("food_num");
 
	AdminDAO dao = AdminDAO.getInstance();
	dao.fooddelete(food_num);   
	 
	response.sendRedirect("admin_food_list.jsp");
	

%>