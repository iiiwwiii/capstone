<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="user.parents.ParentsDAO"%> 
<%@ page import="user.teacher.TeacherNoticeVO"%>
<%@ page import = "java.util.Date"  %>
<%!
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<%
String id = null;
if(session.getAttribute("id")!=null){
	id = (String)session.getAttribute("id");
} else if(session.getAttribute("id")==null){		 
	response.sendRedirect("/kindergarten/jsp/first/first_main.jsp");  //이거 url접근 시 에러남. 여기 인클루드해서. 이거 나중에 좀 처리해줘야될듯 -> null아니면 아래 다묶는다거나 해서 
}   
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	ParentsDAO pdao = ParentsDAO.getInstance();
	TeacherNoticeVO nvo = pdao.noticeLayout(num);
%> 
<!doctype html> 
<html lang="ko">
<title>학부모 공지사항</title>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> 
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" >
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
	<link href="/kindergarten/etc/css/nav/nav.css" rel="stylesheet" type="text/css"> <!-- nav -->
	<link href="/kindergarten/etc/css/parents/parents_default.css" rel="stylesheet" type="text/css"> <!-- html, body, footer-->
</head>

<body>
<!-- menu -->
<jsp:include page="parents_menu.inc.jsp" flush="false" />

	<!--main-->
	<div class="container" style="margin-top: 10%;">
		<div class="pricing-header pb-md-4 mx-auto text-center" style="margin-bottom: 20px;">
			<h1 class="display-4">공지사항</h1>
		</div>
		<div class="alert alert-secondary" role="alert">
			<h3 style="font-weight: bold;"><%=nvo.getNotice_title()%></h3>
			<span style="margin-right: 10%; margin-top: 2%; font-size: 12px;">등록일<%=sdf.format(nvo.getNotice_date())%></span> 
			<span style="margin-right: 10%; margin-top: 2%; font-size: 12px;">조회수: <%=nvo.getNotice_count()%></span>
		</div>
		<div style="font-size: 12px; margin-top: 2%; padding: 0 2%; border: 1px solid #f0f0f0; height: 300px;">
			<br>
			<%=nvo.getNotice_content()%>
		</div>

		<a class="ui right floated yellow button" href="parents_notice_list.jsp" role="button" style="margin-top:3%">목록으로</a>
	</div>

	<!--footer-->
<jsp:include page="parents_footer.inc.jsp" flush="false" />

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script> <!-- 반드시 윗줄->nav.js -->
<script src="https://unpkg.com/popper.js@1.12.6/dist/umd/popper.js"></script>
<script src="https://unpkg.com/bootstrap-material-design@4.1.1/dist/js/bootstrap-material-design.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
</body>
</html>
