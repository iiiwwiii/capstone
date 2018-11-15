<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="user.teacher.TeacherDAO"%>
<%@ page import="user.teacher.TeacherNoticeVO"%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");

	TeacherDAO dao = TeacherDAO.getInstance();
	TeacherNoticeVO noticeLayout = dao.noticeLayout(num);
%>

<!doctype html>
<html lang="ko">
<title>공지사항 상세페이지</title>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
<link href="/kindergarten/etc/css/nav/nav.css" rel="stylesheet" type="text/css"> <!-- nav -->
<link href="/kindergarten/etc/css/parents/parents_default.css" rel="stylesheet" type="text/css"> <!-- html, body, footer-->
</head>
<body>

<!-- menu -->
<jsp:include page="teacher_menu.inc.jsp" flush="false" />

<div class="container" style="margin-top:7%;">
	<div class="pricing-header pb-md-4 mx-auto text-center">
      	<h2 class="display-4">상세페이지</h2>
    </div>
		<table class="ui very basic collapsing celled table" style="width: 70%; margin-left:15%; margin-top:3%">
			<tbody>
				<tr>
					<td style="width: 20%;">
						<h5 class="ui image header">
							<div class="content">글번호</div>
						</h5>
					</td>
					<td><%=num%>번째 글</td>
				</tr>
				<tr>
					<td>
						<h5 class="ui image header">
							<div class="content">제목</div>
						</h5>
					</td>
					<td><%=noticeLayout.getNotice_title()%> </td>
				</tr>
				<tr>
					<td>
						<h5 class="ui image header">
							<div class="content">내용</div>
						</h5>
					</td>
					<td><%=noticeLayout.getNotice_content()%></td>
				</tr>
				<tr>
					<td>
						<h5 class="ui image header">
							<div class="content">조회수</div>
						</h5>
					</td>
					<td><%=noticeLayout.getNotice_count()%></td>
				</tr>
				<tr>
					<td>
						<h5 class="ui image header">
							<div class="content">등록일</div>
						</h5>
					</td>
					<td><%=noticeLayout.getNotice_date()%></td>
				</tr>
			</tbody>
		</table>
		<div class="container pt-3" style="margin-left:13%;">
			<a class="tiny ui yellow button" href="teacher_notice_update.jsp?num=<%=noticeLayout.getNotice_num()%>&pageNum=<%=pageNum%>" role="submit">수정하기</a>
			<a class="tiny ui grey basic button" href="teacher_notice_list.jsp?pageNum=<%=pageNum%>" role="button">목록으로</a>		
			<a class="tiny ui grey basic button" role="button" id="delete_notice" onclick="delete_notice()">삭제하기</a>
		</div>
	</div>
	
<!--footer-->
<jsp:include page="teacher_footer.inc.jsp" flush="false" />	

<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script> <!-- 반드시 윗줄->nav.js -->	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script><!-- sweetalert -->
<script src="/kindergarten/assets/Semantic-UI-master/dist/semantic.min.js"></script>

	<script>
	function delete_notice() {
	    if (confirm("정말 삭제하시겠습니까 ?")) {
	        location.href='teacher_notice_delete_pro.jsp?num=<%=noticeLayout.getNotice_num() %>';
	    }
	}
	</script>
</body>
</html>
