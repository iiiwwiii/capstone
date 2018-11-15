<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<title>관리자 메인</title>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> <!-- popup -->
	<link href="/kindergarten/etc/css/parents/parents.css" rel="stylesheet" type="text/css"><!-- 공통 -->
</head>
<body>
	<nav class="navbar navbar-expand-md fixed-top top-nav bg-light">
		<a class="navbar-brand" href="#"><strong>Kindergarten</strong></a>	
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"><i class="fa fa-bars" aria-hidden="true"></i></span>
		</button>	
		<div class="collapse d-flex justify-content-center navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav">
				<li class="nav-item active">
					<a class="nav-link" href="admin_main.jsp">메인</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">캘린더</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="admin_user_parents.jsp">회원관리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">공지사항</a>
				</li>
			</ul>
		</div>	
		<div class="nav-item">
			<img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" onclick="openForm()" class="rounded-circle navprofileimg">
		</div>
	</nav>
	<div class="container-fluid">
		<div class="row">			
				<!-- 관리자 왼쪽 프로필 필요없음 -->	
			<main role="main" class="col-md-12 ml-sm-auto col-lg-12">  
				<div class="container">			
    				admin main 
    			</div> <!-- end container -->
			</main>
		</div>  <!-- row --> 
	</div>  <!-- container-fluid -->


<!-- profile popup -->
	<div class="form-popup" id="myForm">
		<p onclick="closeForm()" class="w3-button w3-xlarge w3-hover-gray w3-display-topright" title="Close Modal">&times;</p><br>
		<div class="row">
			<div class="col-md-4">
				<img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" class="w3-circle popupprofileimg">
	   		</div>
	   		<div class="col-md-8">
	   			<div class="popupprofileinfo">
	   				admin
	   			</div>
	   		</div>
   		</div>
   		<hr>
   		<div class="popupprofilebtn">
   			<a href="parents_mypage.jsp" class="btn btn-secondary btn-sm">마이페이지</a>
   			<button type="button" class="btn btn-secondary btn-sm">로그아웃</button>
   		</div>
	</div> 
<!-- end popup -->

<script src="/kindergarten/etc/js/parents/parents.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>  
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>

</body>
</html>
