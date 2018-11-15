<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.teacher.TeacherDAO"%>
<%@ page import="java.sql.Date"%>

<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="insert" scope="page" class="user.teacher.TeacherNoticeVO">
   <jsp:setProperty name="insert" property="*"/>
</jsp:useBean>
  
<%
	int fi = 0;
	int result = 0;
	String notice_fi = ""; 
	long notice_date= System.currentTimeMillis();
	insert.setNotice_date(new Date(notice_date));
	
	String notice_title = request.getParameter("notice_title");
	String notice_content = request.getParameter("notice_content");
	if(request.getParameter("notice_fi")!=null){
		 notice_fi = request.getParameter("notice_fi"); //null
	}
	
	if(notice_fi.equals("on")) {
		fi = 1;
	} 

	TeacherDAO dao = TeacherDAO.getInstance();
	result = dao.insertNotice(insert, fi);
	 
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
