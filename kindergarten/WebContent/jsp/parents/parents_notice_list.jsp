<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="user.parents.ParentsDAO"%> 
<%@ page import="user.teacher.TeacherNoticeVO"%>
<%@ page import="java.util.Date"%>
<%!
	Date today = new Date();	
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<%
	request.setCharacterEncoding("utf-8"); 
	String pageNum = request.getParameter("pageNum");
	int count = 0; 
	int number = 0;
	String select = "1";
	String word = "";
	
	
	if (pageNum == null) {
		pageNum = "1";
	}

	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	if(request.getParameter("select") != null ){
		select = request.getParameter("select");
	}
	if(request.getParameter("word") != null ){
		word = request.getParameter("word");
	}
	
	String id = null;
	if(session.getAttribute("id")==null){		
		response.sendRedirect("/kindergarten/jsp/first/first_main.jsp");
	}else  if(session.getAttribute("id")!=null){
		id = (String)session.getAttribute("id");
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
	
	<div class="container" style="margin-top: 10%;">
		<div class="pricing-header pb-md-4 mx-auto text-center">
			<h1 class="display-4">공지사항</h1>
			<p class="lead pt-2">유치원의 공지사항을 한눈에 확인 할 수 있는 공간입니다.</p>
		</div>
			<form class="form-inline justify-content-center" action="./parents_notice_list.jsp" method="get" style="margin-bottom:40px;">
				<select name="select" class="form-control" style="width:150px; height: 33px; font-size:12px;">
					<option value="none"  <%if(select.equals("none")) out.println("selected"); %>>전체</option>
					<option value="title"  <%if(select.equals("title")) out.println("selected"); %>>제목</option>
					<option value="content"  <%if(select.equals("content")) out.println("selected"); %>>내용</option>
				</select> 
				<input class="form-control" type="text" name="word" placeholder="검색어를 입력하세요" value = "<%=word%>" style="margin: 0 10px; width:300px; height: 33px; font-size:12px;">
				<button class="btn btn-warning" type="submit">검색</button>
			</form>	
		<%
			List<TeacherNoticeVO> noticeList = null; 
			ParentsDAO dao = ParentsDAO.getInstance();												
			count = dao.parentsNoticeCount(select, word);  
	
			if (count > 0) {																		
				noticeList = dao.parentsNoticeList(select, word, startRow, pageSize);								
			}	
			
			number = count-(currentPage-1)*pageSize;  
			
			int listnum = count; 	
		%>	
		전체 : <%=count %>
	<%
		if (count == 0) {
	%>
	<div class="alert alert-danger" role="alert">저장된 글이 없습니다.</div>
	<%
		} else {
	%>
		<!-- 공지사항 테이블 -->	
		<table class="table table-hover">	
			<colgroup>
				<col width="10%">
				<col width="*">
				<col width="10%">
				<col width="7%">
			</colgroup>
			<thead>
				<tr>
					<th> 번호</th>
					<th> 제목</th>
					<th> 등록일</th>
					<th> 조회수</th>		
				</tr>
			</thead>
			<%
			for (int i = 0 ; i < noticeList.size(); i++) {	
				TeacherNoticeVO notice = noticeList.get(i);	
			%>
			<tr> 
				<td  style="font-size:12px;">		
				<%=listnum-- %>				
				</td> 
				<td  style="font-size:12px;">				
					<a href="parents_notice_layout.jsp?num=<%=notice.getNotice_num()%>&pageNum=<%=currentPage%>"  style="font-size:12px;">
					<%
						if (notice.isNotice_fi() == true) {
					%>	<i class="fas fa-flag"></i>
					<%	}%>
					<%=notice.getNotice_title()%></a> 
					<%
					String d = sdf.format(today);  
					String n = sdf.format(notice.getNotice_date());
					if(d.equals(n)){%>		
					<small class="w3-text-red"><b>new</b></small>
					<%}%>
				</td>			
				<td  style="font-size:12px;">
					<%=sdf.format(notice.getNotice_date()) %>
				</td>
				<td  style="font-size:12px;">		
					<%=notice.getNotice_count()%>						
				</td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
	<!-- end container -->

	<!-- 페이지 네비게이션 -->
	<nav aria-label="Page navigation example">
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
			<li class="page-item disabled"><a class="page-link" href="parents_notice_list.jsp?pageNum=<%=startPage - 10%>" tabindex="-1">이전</a></li>
			<%
				}
						for (int i = startPage; i <= endPage; i++) {
							if (i == currentPage) {
			%>
			<li class="page-item active"><a class="active page-link" href="#"><%=i%></a></li>
			<%
				} else {
			%>
			<li class="page-item"><a class="page-link" href="parents_notice_list.jsp?pageNum=<%=i%>"><%=i%></a></li>
			<%
				}
						}
						if (endPage < pageCount) {
			%>
			<li class="page-item"><a href="parents_notice_list.jsp?pageNum=<%=startPage + 10%>">다음</a></li>
			<%
				}
					}
				}
			%>
		</ul>
	</nav>

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
<%}%>