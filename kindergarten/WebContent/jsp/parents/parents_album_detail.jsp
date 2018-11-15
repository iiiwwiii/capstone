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
<!-- 공통 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
<jsp:include page="parents_menu.inc.jsp" flush="false" />
			
<div class="w3-overlay w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>
	<div class="container" style="margin-top:10%;">
	
		<!-- 설명div -->
		<div style="margin-top:5%;  margin-bottom:7%;">
			<div class="text-center" style="padding-top:5px;">
			<% 
			 	AlbumVO album = null;
				ScheduleDAO dbPro = ScheduleDAO.getInstance();
			 	List<AlbumVO> albumList = dbPro.get_album_input_y(album_num);
			  	//out.println(albumList.size());
			  	if(albumList != null){
			  		for(int j=0; j<albumList.size(); j++){
			  			album = albumList.get(j);			
			%>
				<span style="font-size:20px;"><%= album.getAlbum_title() %></span><br><br><br><br>
				<small><%= album.getAlbum_content() %></small>				
			<% 
				  }}
			%>	
			</div>
		</div>
		
		<div class="row">
			<% 
				if(request.getParameter("album_num") != null){
					List<ImageVO> imageList = dbPro.get_album_detail(Integer.parseInt(request.getParameter("album_num")));
					
					if(imageList != null){
						  for(int i=0; i<imageList.size(); i++){
							  ImageVO image = imageList.get(i);
			%>
							<div class="col-sm-3 click_a">
								<img class="p-3 size" src="../../etc/image/teacher/<%= image.getImage_name() %>" style="width:100%" onclick="onClick(this)" alt="Canoeing again">
							</div>	
			<%
				}}}
			%>
		</div>
	 </div>	<!-- end container -->

<!--footer-->
<jsp:include page="parents_footer.inc.jsp" flush="false" />


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
			      	<div class="col-md-7" style="padding:0 -10px 0 -10px">
			      		<img id="img01" class="" style="width:100%; height:450px;">
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

	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script> <!-- 반드시 윗줄->nav.js -->
	<script src="https://unpkg.com/popper.js@1.12.6/dist/umd/popper.js"></script>
	<script src="https://unpkg.com/bootstrap-material-design@4.1.1/dist/js/bootstrap-material-design.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
	<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script>
	
	// Modal Image Gallery
	function onClick(element) {
	  document.getElementById("img01").src = element.src;
	  document.getElementById("modal01").style.display = "block";
	}
	</script>
	
</body>
</html>
