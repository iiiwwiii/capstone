<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.parents.ParentsDAO" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="parentssignup" class="user.parents.ParentsVO"/>
<jsp:setProperty property="*" name="parentssignup"/>

<% 
	parentssignup.setParents_date(new Timestamp(System.currentTimeMillis()));
	String parents_id = request.getParameter("parents_id");
	String parents_pwd = request.getParameter("parents_pwd");
	String parents_name = request.getParameter("parents_name");
	String parents_phone = request.getParameter("parents_phone");
	String parents_post = request.getParameter("parents_post");
	String parents_addr = request.getParameter("parents_addr");
	
	String con_child_name = request.getParameter("con_child_name");
	String con_child_class = request.getParameter("con_child_class");

	ParentsDAO parentsdao = ParentsDAO.getInstance();
	parentsdao.parentsSignUp(parentssignup);		
	
	response.sendRedirect("/kindergarten/jsp/first/first_main.jsp");
	
%>
