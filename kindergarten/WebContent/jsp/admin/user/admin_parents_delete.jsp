<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.admin.AdminDAO" %>
<% request.setCharacterEncoding("utf-8"); %>

<%  
	String[] check = request.getParameterValues("check");

	AdminDAO dao = AdminDAO.getInstance();
	dao.parentsDelete(check);	

	response.sendRedirect("/kindergarten/jsp/admin/admin_user_parents.jsp");
	
%>
