<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="user.teacher.TeacherDAO"%>
<%@ page import="user.teacher.TeacherNoticeVO"%>

<%!	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<%
	request.setCharacterEncoding("utf-8");
	String pageNum = request.getParameter("pageNum");
	int count = 0;
	int number = 0;

	if (pageNum == null) {
		pageNum = "1";
	}

	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;

	List<TeacherNoticeVO> noticeList = null;
	TeacherDAO dao = TeacherDAO.getInstance();
	count = dao.noticeCount();

	if (count > 0) {
		noticeList = dao.noticeList(startRow, pageSize);
	}
	number = count - (currentPage - 1) * pageSize;
	
	String id = null;
	if(session.getAttribute("id")==null){		
		response.sendRedirect("/kindergarten/jsp/first/first_main.jsp");
	}else  if(session.getAttribute("id")!=null){
		id = (String)session.getAttribute("id");
%>

<!doctype html>
<html lang="ko">
<title>공지사항 리스트</title>
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

<div class="col-lg-8" style="margin-left: 17%; margin-top:7%;">
	<div class="pricing-header pb-md-4 mx-auto text-center">
      	<h1 class="display-4">공지사항 리스트</h1>
      	<p class="lead mt-3">공지사항  : <%= count%> 개 </p>
    </div> 
	<a class="tiny ui yellow button" role="button" href="teacher_notice_insert.jsp">공지사항 등록</a>

		<%
			if (count == 0) {
		%>
			<div class="alert alert-primary" role="alert">공지사항이 없습니다.</div>
		<%
			} else {
		%>

		<table class="ui selectable celled table">
			<thead>
				<tr>
					<th scope="col" width="60%">제목</th>
					<th scope="col" width="20%">조회수</th>
					<th scope="col" width="20%">작성일</th>
				</tr>
			</thead>
			<tbody>
				<%
					for (int i = 0; i < noticeList.size(); i++) {
						TeacherNoticeVO notice = noticeList.get(i);
				%>
				<tr>
					<td><a href="teacher_notice_layout.jsp?num=<%=notice.getNotice_num()%>&pageNum=<%=currentPage%>">
						<% if (notice.isNotice_fi() == true) {%><i class="fas fa-flag"></i> <% } %> <%=notice.getNotice_title()%></a></td>
					<td><%=notice.getNotice_count()%></td>
					<td><%=notice.getNotice_date()%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<%
			}
		%>
</div>

	<!-- 페이징 접어둠 -->
	<nav aria-label="Page navigation example" style="margin-top:3%;">
		<ul class="pagination justify-content-center">
		<%
			if (count > 0) {
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				int startPage = 1;
				if (currentPage % 10 != 0)
					startPage = (int) (currentPage / 10) * 10 + 1;
				else
					startPage = ((int) (currentPage / 10) - 1) * 10 + 1;
				int pageBlock = 10;
				int endPage = startPage + pageBlock - 1;
				if (endPage > pageCount)
					endPage = pageCount;

				if (startPage > 10) {
		%>
		<li class="page-item disabled">
		<a class="page-link" href="teacher_notice_list.jsp?pageNum=<%=startPage - 10%>" tabindex="-1">이전</a></li>
		<%
			}
				for (int i = startPage; i <= endPage; i++) {
					if (i == currentPage) {
		%>
		<li class="page-item"><a class="active page-link" href="#"><%=i%></a></li>
		<%
			} else {
		%>
		<li class="page-item"><a class="page-link" href="teacher_notice_list.jsp?pageNum=<%=i%>"><%=i%></a></li>
		<%
			}}if (endPage < pageCount) {
		%>
		<li class="page-item"><a href="teacher_notice_list.jsp?pageNum=<%=startPage + 10%>">다음</a></li>
		<%}}%>
		</ul>
	</nav>
	
<!--footer-->
<jsp:include page="teacher_footer.inc.jsp" flush="false" />	

<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script> <!-- 반드시 윗줄->nav.js -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script><!-- sweetalert -->
<script src="/kindergarten/assets/Semantic-UI-master/dist/semantic.min.js"></script>
</body>
</html>
<%} %>
