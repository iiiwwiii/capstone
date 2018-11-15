<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="user.teacher.TeacherDAO"%>
<%@ page import="user.teacher.TeacherVO"%>

<%!	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<%
	request.setCharacterEncoding("utf-8");
	TeacherDAO dao = TeacherDAO.getInstance();
	TeacherVO TeacherList = null;
	
	//parents session 
	String id = null;
	if(session.getAttribute("id")==null){		
		response.sendRedirect("/kindergarten/jsp/first/first_main.jsp");
	}else  if(session.getAttribute("id")!=null){
		id = (String)session.getAttribute("id");
%>

<!doctype html>
<html lang="ko">
<title>선생님 마이페이지</title>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
<link href="/kindergarten/etc/css/parents/parents.css" rel="stylesheet" type="text/css">
<link href="/kindergarten/etc/css/nav/nav.css" rel="stylesheet" type="text/css"> <!-- nav -->
<link href="/kindergarten/etc/css/parents/parents_default.css" rel="stylesheet" type="text/css"> <!-- html, body, footer-->
</head>
<body>

<!-- menu -->
<jsp:include page="teacher_menu.inc.jsp" flush="false" />

<%
	TeacherList = dao.getTeacherList("teacher");
%>	
<div class="pricing-header pb-md-4 mx-auto pt-2 text-center" style="margin-top:7%">
	<h2 class="display-4"><%=TeacherList.getTeacher_name()%>선생님</h2>
</div>
	<div class="container col-lg-6 col-offset-2 mt-5">
		<form class="ui equal width form" style="margin-top: 5%; margin-bottom: 5%">
			<div class="field">
				<label>아이디</label> <input type="text" name="teacher_id" value="<%=TeacherList.getTeacher_id()%>">
			</div>
			<div class="field">
				<label>비밀번호</label> <input type="text" name="teacher_pwd" value="<%=TeacherList.getTeacher_pwd()%>">
			</div>
			<div class="field">
				<label>반</label> <input type="text" name="teacher_class" value="<%=TeacherList.getTeacher_class()%>">
			</div>
			<div class="field">
				<label>이름</label> <input type="text" name="teacher_name" value="<%=TeacherList.getTeacher_name()%>">
			</div>
			<div class="field">
				<label>전화번호</label> <input type="text" name="teacher_phone" value="<%=TeacherList.getTeacher_phone()%>">
			</div>
			<div class="field">
				<div class="field">
					<label>우편번호</label> <input type="text" name="teacher_post" value="<%=TeacherList.getTeacher_post()%>">
				</div>
				<div class="field">
					<label>주소</label> <input type="text" name="teacher_addr" value="<%=TeacherList.getTeacher_addr()%>">
				</div>
			</div>
			<div class="field">
				<label>사진</label> <input type="image" name="teacher_pic" value="<%=TeacherList.getTeacher_pic()%>">
			</div>
			<button class="tiny ui yellow button" type="submit">수정</button>
		</form>
	</div>
	
<!--footer js링크들은 나중에-->
<jsp:include page="teacher_footer.inc.jsp" flush="false" />	
	
<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script> <!-- 반드시 윗줄->nav.js -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/kindergarten/etc/js/parents/parents.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>
</body>
</html>
<%}%>