<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.admin.AdminDAO" %>
<%@ page import = "user.admin.AdminNoticeVO" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));   
	String pageNum = request.getParameter("pageNum"); 
	
	AdminDAO dao = AdminDAO.getInstance();    
	AdminNoticeVO noticeLayout = dao.noticeLayout(num);   
%>

<!doctype html>
<html lang="ko">
<title>공지사항 수정페이지</title>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
</head>
<body style="font-size:12px;">
<div class="container">
	<br><br><br>
		<%=num %>번째 글 수정 폼 <br><br><br><br>
		
		<form method="post" action="admin_notice_update_pro.jsp">
			제목 : <input type="text" class="form-control" name="notice_title" value="<%=noticeLayout.getNotice_title() %>" style="font-size:12px;"> <br><br>
			내용 : <textarea name="notice_content" class="form-control" rows="5" style="font-size:12px;"><%=noticeLayout.getNotice_content() %></textarea> <br><br>
			공지여부 : 
			<%if(noticeLayout.isNotice_fi()==true) {%>
			<input type="checkbox" name="notice_fi" checked>
			<%}else{%>
			<input type="checkbox" name="notice_fi">
			<%} %>
			<%=noticeLayout.isNotice_fi()%> <br><br>
			
			<button type="submit" class="btn btn-primary btn-sm">수정하기</button>
		</form>
	</div>

<script src="/kindergarten/etc/js/parents/parents.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>  
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> <!-- sweetalert -->
</body>
</html>