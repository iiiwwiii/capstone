<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<title>main</title>
<head>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
   <link href="/kindergarten/etc/css/first/first_main.css" rel="stylesheet" type="text/css">
</head>
<body>

<nav class="navbar navbar-expand-md fixed-top top-nav">
      <a class="navbar-brand" href="#"><strong>비트킨더</strong></a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
         <span class="navbar-toggler-icon"><i class="fa fa-bars" aria-hidden="true"></i></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
         <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
               <a class="nav-link" href="#">소개 <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
					<a class="nav-link" href="first_signup.jsp">회원가입 <span class="sr-only">(current)</span></a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="first_login.jsp">로그인</a>
				</li>
         </ul>
      </div>   
</nav>

<!-- Intro Seven -->
<section class="intro carousel slide bg-overlay-light h-auto" id="carouselExampleCaptions">
   <ol class="carousel-indicators">
      <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
   </ol>
   <div class="carousel-inner" role="listbox">
      <div class="carousel-item active">
        <img alt="main0" width="100%" height="100%" src="/kindergarten/etc/image/first/child_1.jpg" >
          <div class="carousel-caption">
            <h2 class="display-4 text-white mb-5 mt-2"><strong>비트킨더</strong></h2>
            <br>
				<h2 class="display-5 text-white mb-5 mt-2">직접 관리하는 우리아이 출결</h2>
				<br><br>
            <a href="first_login.jsp" class="btn btn-primary btn-capsul px-4 py-2">시작하기</a>
         </div>
      </div>
   </div>  
</section>

<!-- Info block 1 -->
<section class="info-section">
   <div class="container">
      <div class="row">
         <div class="col-sm-6"></div>
         <div class="col-sm-6">
            <br>
            <h2 class="h2info">원활한 커뮤니케이션 </h2>
            <br>
            <p>학부모가 원하는 정보를 유치원 홈페이지를 통해 제공합니다.<br>알림장,공지사항,앨범 등의 아이와 관련된 자료를 한 눈에 확인할 수 있습니다. </p>
            <br>           
         </div>     
      </div>
   </div>
</section>

<!-- Info block 1 -->
<section class="info-section bg-primary py-0">
   <div class="container-fluid">
      <div class="row">   
      	<img src="/kindergarten/etc/image/first/child_2.png" class="img-fluid imgsize" alt="main1">   
      </div>
   </div>
</section>

<!-- Info block 2 -->
<section class="info-section">
   <div class="container">
      <div class="row">
         <div class="col-sm-1"></div>
         <div class="col-sm-6">
            <br>
            <h2 class="h2info">아이의 정보를 직접 입력</h2>
            <br>
            <p>우리아이의 한달간 일정을 나타내는 캘린더에<br>학부모가 직접 아이의 일정이나 특이사항을 수정할 수 있습니다.</p>
            <br>
         </div>
      </div>
   </div>
</section>

<!-- Info block 2 -->
<section class="info-section bg-primary py-0">
   <div class="container-fluid">
      <div class="row">   
      	<img src="/kindergarten/etc/image/first/child_4.jpg" class="img-fluid imgsize" alt="main2">   
      </div>
   </div>
</section>

<!-- Info block 3 -->
<section class="info-section">
   <div class="container">
      <div class="row">
         <div class="col-sm-6"></div>
         <div class="col-sm-6">
            <br>
            <h2 class="h2info">출석 자동화</h2>
            <br>
            <p>학부모는 아이가 안전하게 유치원까지 잘 도착했는지<br> 자동화 된 출석시스템을 이용해서 알 수 있습니다.</p>
            <br>
         </div>
      </div>
   </div>
</section>

<!-- Info block 3 -->
<section class="info-section bg-primary py-0">
   <div class="container-fluid">
      <div class="row">   
      	<img src="/kindergarten/etc/image/first/child_3.jpg" class="img-fluid imgsize" alt="main3">  
      </div>
   </div>
</section>

<footer class="footer text-center" style="color:#555; padding:25px; font-weight:300;">
	<p style="margin-bottom:0; font-size:14px; margin: 0 0 10px; font-weight:300;">
		<span style="margin-top:40px;">Copyright 2018. Hanyang Women's University 3-A kindergarten All Rights Reserved.</span>
	</p>	
</footer>


<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>  
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="/kindergarten/etc/js/first/first_main.js"></script>
</body>
</html>
