<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import = "user.admin.AdminDAO" %>
<%@ page import = "user.admin.AdminNoticeVO" %>

<%!
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<%
	int num = Integer.parseInt(request.getParameter("num"));   
	String pageNum = request.getParameter("pageNum"); 
	
	AdminDAO dao = AdminDAO.getInstance();    
	AdminNoticeVO noticeLayout = dao.noticeLayout(num);   
%>
<!doctype html> 
<html lang="ko">
<title>공지사항 상세페이지</title>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
</head>
<body style="font-size:12px;">
	<div class="container">
	<br><br><br>
		<%=num %>번째 글 <br><br><br><br>
		제목 : <%=noticeLayout.getNotice_title() %> <br><br>
		내용 : <%=noticeLayout.getNotice_content() %> <br><br>
		조회수 : <%=noticeLayout.getNotice_count() %> <br><br>
		공지여부 : <%=noticeLayout.isNotice_fi()%> <br><br>
		등록일 : <%=noticeLayout.getNotice_date() %><br><br>
		
		<a class="btn btn-primary btn-sm" href="admin_notice_list.jsp?pageNum=<%=pageNum%>" role="button">목록으로</a>	
		<a class="btn btn-primary btn-sm" href="admin_notice_update.jsp?num=<%=num %>&pageNum=<%=pageNum%>" role="button">수정하기</a>	
		
	</div>
<script src="/kindergarten/etc/js/parents/parents.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>  
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> <!-- sweetalert -->

</body>
</html>