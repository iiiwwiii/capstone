<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.teacher.TeacherDAO"%>
<%@ page import = "java.sql.Timestamp" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");

	TeacherDAO dao = TeacherDAO.getInstance();
	int result = dao.deleteNotice(num); 
	
	if(result == 1){
		%>
		<script>
			alert(<%=result%>);
		</script>
		<%
	}else if (result == 0){
	    response.sendRedirect("teacher_notice_list.jsp");
	}
%>