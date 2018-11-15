<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.teacher.TeacherDAO" %>
<% request.setCharacterEncoding("utf-8"); %>

<% 
	String parents_id = request.getParameter("parents_id");
	String con_child_name = request.getParameter("con_child_name");
	String con_child_class = request.getParameter("con_child_class");
	
	TeacherDAO dao = TeacherDAO.getInstance();
	dao.parentsAccept(parents_id, con_child_name, con_child_class);	
	
	response.sendRedirect("/kindergarten/jsp/teacher/teacher_user_list.jsp");
%>