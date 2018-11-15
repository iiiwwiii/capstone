<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.parents.ParentsDAO" %>
<%@ page import = "java.sql.Timestamp" %>

<%
	request.setCharacterEncoding("utf-8");
%>

<% 	
	String login_id = request.getParameter("login_id");
	String login_pwd = request.getParameter("login_pwd");
	
	ParentsDAO dao = ParentsDAO.getInstance();
	int result = dao.userLogin(login_id, login_pwd);	
	
	if(result==1){ //admin
		session.setAttribute("id",login_id);
		response.sendRedirect("/kindergarten/jsp/admin/admin_main.jsp");
		
	}else if(result==2){ //teacher
		session.setAttribute("id",login_id);
		response.sendRedirect("/kindergarten/jsp/teacher/teacher_main.jsp");
		
	}else if(result==3){ //parents
		session.setAttribute("id",login_id);
		response.sendRedirect("/kindergarten/jsp/parents/parents_main.jsp");
		
	}else if(result==0){  //x
%>
		<script>
			alert("아이디나 비밀번호가 틀렸습니다.");
			history.go(-1);
		</script>
<%
	}
%>

