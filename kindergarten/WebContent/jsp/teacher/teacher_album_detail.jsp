<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="picture.ScheduleDAO"%>
<%@ page import="picture.ImageVO"%>
<%@ page import="picture.AlbumVO"%>

<% 
int album_num = 0;
if(request.getParameter("album_num") != null){
	album_num = Integer.parseInt(request.getParameter("album_num"));
}
%>

<!doctype html>
<html lang="ko">
<title>선생님 앨범 상세페이지</title>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
<link href="/kindergarten/etc/css/nav/nav.css" rel="stylesheet" type="text/css"> <!-- nav -->
<link href="/kindergarten/etc/css/parents/parents_default.css" rel="stylesheet" type="text/css"> <!-- html, body, footer-->

<style>
	 .p_hr{
	 
	 padding:30px 0 50px 0;border-bottom:2px solid #f8f8f8;
	 
	 }
	 
	  .modal-backdrop {
	    z-index: 100000 !important;
	  }
	
	  .modal {
	    z-index: 100001 !important;
	  }
	  
	  .size{
	  	width:auto; height:250px;;
	  }
</style>
</head>
<body>

<!-- menu -->
<jsp:include page="teacher_menu.inc.jsp" flush="false" />

<div class="w3-overlay w3-animate-opacity" onclick="w3_close()" style="cursor: pointer" title="close side menu" id="myOverlay"></div>
	<div class="container" style="margin-top:10%;">
		<!-- 설명div -->
		<div class="pricing-header pb-md-4 mx-auto text-center">
			<%
				AlbumVO album = null;
				ScheduleDAO dbPro = ScheduleDAO.getInstance();
				List<AlbumVO> albumList = dbPro.get_album_input_y(album_num);
				//out.println(albumList.size());
				if (albumList != null) {

					for (int j = 0; j < albumList.size(); j++) {
						album = albumList.get(j);
			%>
			<h1 class="display-4"><%=album.getAlbum_title()%></h1>
			<p class="lead mt-3"><%=album.getAlbum_content()%></p>
		</div>
		<%
			}
			}
		%>
	
		<div class="d-flex justify-content-center btn-lg" style="margin-bottom: 3%;">
			<button type="button" class="btn btn-warning text-center" onclick="location.href='teacher_album_detail_update.jsp?album_num=<%=album_num%>'">앨범 수정</button>
		</div>

		<div class="container">
		<%
			if (request.getParameter("album_num") != null) {
				List<ImageVO> imageList = dbPro.get_album_detail(Integer.parseInt(request.getParameter("album_num")));
	
				if (imageList != null) {
					for (int i = 0; i < imageList.size(); i++) {
						ImageVO image = imageList.get(i);
		%>
		<div class="w3-quarter click_a">
			<img class="p-3 size" src="../../etc/image/teacher/<%=image.getImage_name()%>" style="width:100%; height:250px;" onclick="onClick(this)" alt="Canoeing again">
		</div>
		<%
			}
				}
			}
		%>
		</div>
	</div>	

	<!-- Modal -->
	<div id="modal01" class="w3-modal w3-black" onclick="this.style.display='none'">
		<span class="w3-button w3-black w3-xlarge w3-display-topright" onclick="nav_on()">×</span>
		<div class="w3-modal-content w3-animate-zoom w3-center w3-transparent">

			<!-- carousel -->
			<div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
				<div class="carousel-inner">
					<div class="carousel-item active">

						<a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev"> 
							<span class="carousel-control-prev-icon" aria-hidden="true"></span> 
							<span class="sr-only">Previous</span>
						</a>

						<div class="bg-white">
							<div class="row">
								<div class="col-md-7" style="padding: 0 -10px 0 -10px">
									<img id="img01" class="" style="width: 100%; height: 450px;">
								</div>
								<div class="col-md-5 text-dark">
									<!-- 댓글, 좋아요 -->
									<div>
										<h4>햇님반</h4>
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>

				<a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next"> 
					<span class="carousel-control-next-icon" aria-hidden="true"></span> 
					<span class="sr-only">Next</span>
				</a>
			</div>
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

<script>	
// Modal Image Gallery
	function onClick(element) {
	  document.getElementById("img01").src = element.src;
	  document.getElementById("modal01").style.display = "block";
	}
</script>
	
</body>
</html>
