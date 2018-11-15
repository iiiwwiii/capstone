<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.teacher.TeacherDAO"%>
<%@ page import="user.teacher.TeacherNoticeVO"%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum"); 
	
	TeacherDAO dao = TeacherDAO.getInstance();    
	TeacherNoticeVO update = dao.updateGetNotice(num);   
%>

<!doctype html>
<html lang="ko">
<title>공지사항 수정페이지</title>
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

<div class="container" style="margin-top:7%">
	<div class="pricing-header pb-md-4 mx-auto text-center">
      	<h2 class="display-4"><%=num %>번 글 수정</h2>
    </div>	
		<form class="ui form" method="get" name="noticeform" action="teacher_notice_update_Pro.jsp" onsubmit="return writeSave()">
			<input type="hidden" name="notice_num"  value="<%= num%>">
			<div class="field">
				<label>제목</label> 
				<input type="text" name="notice_title" value="<%=update.getNotice_title() %>">
			</div>
			<div class="field">
				<label>내용</label>
				<textarea class="form-control" name="notice_content" id="exampleFormControlTextarea1" rows="20"><%=update.getNotice_content() %></textarea>
			</div>
			<div class="form-check">
				<input class="form-check-input" type="checkbox" id="defaultCheck1" name="notice_fi"> 
				<label class="form-check-label" for="defaultCheck1"> 공지여부</label>
			</div>		
			<div class="pt-3">
				<button type="submit" class="tiny ui yellow button">수정하기</button>
				<button type="reset" class="tiny ui black basic button">다시작성</button>
			    <button type="button" class="tiny ui black basic button" onclick="document.location.href='teacher_notice_list.jsp?pageNum=<%=pageNum%>'">목록보기</button>
		    </div>
		</form>
</div>

<!--footer-->
<jsp:include page="teacher_footer.inc.jsp" flush="false" />	

<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script> <!-- 반드시 윗줄->nav.js -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="script.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>  
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> <!-- sweetalert -->
<script src="/kindergarten/assets/Semantic-UI-master/dist/semantic.min.js"></script>
</body>
</html>
