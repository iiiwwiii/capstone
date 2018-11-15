<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.child.ChildDAO" %>

<% request.setCharacterEncoding("utf-8"); %>

<% 
	String child_name = request.getParameter("con_child_name");
	String child_class = request.getParameter("con_child_class");

	ChildDAO childdao = ChildDAO.getInstance();
	int result = childdao.childCheck(child_name, child_class);		
	out.print(result); 
%>