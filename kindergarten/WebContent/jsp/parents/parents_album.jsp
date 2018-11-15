<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="picture.ScheduleDAO" %>
<%@ page import="picture.ScheduleVO" %>
<%@ page import="picture.AlbumVO" %>

<%
	String id = null;

	if(session.getAttribute("id")==null){		
		response.sendRedirect("/kindergarten/jsp/first/first_main.jsp");
		
	}else  if(session.getAttribute("id")!=null){
		id = (String)session.getAttribute("id");
%>

<!doctype html>
<html lang="ko">
<title>학부모 앨범</title>
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
		<div class="pricing-header pb-md-4 mx-auto text-center" style="margin-bottom:20px;">
			<h1 class="display-4">앨범</h1>
			<p class="lead pt-2">아이들의 모습과 하루 일과를 사진으로 볼 수 있는 공간 입니다.</p>
		</div>
		
		<% 	
			ScheduleVO schedule = null;		
			ScheduleDAO dbPro = ScheduleDAO.getInstance();
			
			List<ScheduleVO> scheduleList = dbPro.get_schedule_group_album();
			
			if(scheduleList != null){
				for(int i=0; i<scheduleList.size(); i++){
					schedule = scheduleList.get(i);
		%>
				  <div class="p_hr">
				  	  <h3><%= schedule.getSchedule_date() %></h3>
					  <!-- First Photo Grid-->
					  <div class="w3-row-padding w3-padding-16 w3-center" id="food">
					  
					  <%
					  AlbumVO album = null;
					  List<AlbumVO> albumList = dbPro.get_album_list(schedule.getSchedule_date());
					  //out.println(albumList.size());
					  if(albumList != null){
						  
						  for(int j=0; j<albumList.size(); j++){
							  album = albumList.get(j);
							  %>
							 <div class="w3-quarter click_a">
						        <a href="parents_album_detail.jsp?album_num=<%= album.getAlbum_num()%>"><img src="../../etc/image/teacher/<%= album.getAlbum_title_image() %>" alt="Sandwich" style="width:100%; height:200px;"></a>
						        <h5><%= album.getAlbum_title() %></h5>
						     </div>
							  <%
						  }
					  }
					  %>					
					</div>
		<% 
					}
				}
		%>

			</div><!-- end p_hr -->
	</div><!-- end container -->

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