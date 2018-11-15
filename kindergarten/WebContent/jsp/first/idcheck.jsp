<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.parents.ParentsDAO" %>

<% request.setCharacterEncoding("utf-8"); %>

<% 
	String inputId = request.getParameter("inputId");

	ParentsDAO parentsdao = ParentsDAO.getInstance();
	int result = parentsdao.idCheck(inputId);		
	out.print(result);
%>