<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.teacher.TeacherDAO" %>
<% request.setCharacterEncoding("utf-8"); %>

<%  
	String[] check = request.getParameterValues("check");

	TeacherDAO dao = TeacherDAO.getInstance();
	dao.parentsDelete(check);	

	response.sendRedirect("/kindergarten/jsp/teacher/teacher_user_list.jsp");
	
%>