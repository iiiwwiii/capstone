<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.admin.AdminDAO" %>
<% request.setCharacterEncoding("utf-8"); %>

<% 
	String parents_id = request.getParameter("parents_id");
	String con_child_name = request.getParameter("con_child_name");
	String con_child_class = request.getParameter("con_child_class");
	
	AdminDAO dao = AdminDAO.getInstance();
	dao.parentsAccept(parents_id, con_child_name, con_child_class);	
	
	response.sendRedirect("/kindergarten/jsp/admin/user/admin_user_parents.jsp");
%>
