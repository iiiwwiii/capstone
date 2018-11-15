<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.teacher.TeacherDAO"%>
<%@ page import="user.teacher.TeacherNoticeVO"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	request.setCharacterEncoding("utf-8");
	String title = "공지사항 등록";

	int num = 0;
	String pageNum = request.getParameter("pageNum");

	try {
		if (request.getParameter("num") != null) {
			num = Integer.parseInt(request.getParameter("num"));
		}
%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
<link href="/kindergarten/etc/css/nav/nav.css" rel="stylesheet" type="text/css"> <!-- nav -->
<link href="/kindergarten/etc/css/parents/parents_default.css" rel="stylesheet" type="text/css"> <!-- html, body, footer-->
<link href="/kindergarten/etc/css/parents/parents.css" rel="stylesheet" type="text/css">
</head>
<body>
	
<!-- menu -->
<jsp:include page="teacher_menu.inc.jsp" flush="false" />
	
<div class="container" style="margin-top:7%;">
	<div class="pricing-header pb-md-4 mx-auto text-center">
      	<h2 class="display-4">공지사항 등록</h2>
    </div>
		<form class="ui form" method="post" name="noticeform" action="teacher_notice_insert_Pro.jsp" onsubmit="return writeSave(this)">
			<div class="field">
				<label>제목</label> 
				<input type="text" name="notice_title" placeholder="제목을 입력해 주세요.">
			</div>
			<div class="field">
				<label>내용</label>
				<textarea class="form-control" name="notice_content" id="exampleFormControlTextarea1" rows="20"></textarea>
			</div>
			<div class="form-check">
				<input class="form-check-input" type="checkbox" id="defaultCheck1" name="notice_fi"> 
				<label class="form-check-label" for="defaultCheck1"> 상단 고정 </label>
			</div>		
		<div class="container pt-3">
			<button type="submit" class="ui yellow button">등록하기</button>
			<button type="reset" class="ui black basic button">다시작성</button>
			<button type="button" class="ui black basic button" onclick="document.location.href='teacher_notice_list.jsp'">목록보기</button>
		</div>
		</form>
</div>
	<%
		} catch (Exception e) {}
	%>
	
<!--footer-->
<jsp:include page="teacher_footer.inc.jsp" flush="false" />	

<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script> <!-- 반드시 윗줄->nav.js -->	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="script.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="/kindergarten/assets/Semantic-UI-master/dist/semantic.min.js"></script>

</body>
</html>
