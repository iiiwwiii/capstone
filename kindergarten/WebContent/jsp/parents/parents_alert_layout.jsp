<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<title>학부모 알림장</title>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> <!-- popup -->
	<link href="/kindergarten/etc/css/parents/parents.css" rel="stylesheet" type="text/css"> <!-- 곰통 -->
	<link href="/kindergarten/etc/css/parents/parents_alert_layout.css" rel="stylesheet" type="text/css">
</head>
<body>
	<nav class="navbar navbar-expand-md fixed-top top-nav bg-light">
		<a class="navbar-brand" href="#"><strong>Kindergarten</strong></a>	
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"><i class="fa fa-bars" aria-hidden="true"></i></span>
		</button>	
		<div class="collapse d-flex justify-content-center navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="parents_main.jsp">메인</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="parents_calendar.jsp">캘린더</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="parents_board.jsp">공지사항</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="parents_album.jsp">앨범</a>
				</li>
				<li class="nav-item active">
					<a class="nav-link" href="parents_alert.jsp">알림장</a>
				</li>			
			</ul>
		</div>	
		<div class="nav-item">
			<img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" onclick="openForm()" class="rounded-circle navprofileimg">
		</div>
	</nav>
	<div class="container-fluid">
		<div class="row">
					
			<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">  
				<div class="container"> 
					<div class="row">  
						<br>
						
	<!-- Page Content -->
    <div class="container">
      <div class="row">
      
        <!-- Post Content Column -->
        <div class="col-lg-12">
        <br>
          <!-- Title -->
          <h1 class="title">제목</h1>

          <hr>

          <!-- Date/Time -->
          <p class="time">날짜 및 시간</p>

          <hr>

          <!-- Preview Image -->
          <img class="img-fluid rounded" src="http://placehold.it/900x300" alt="">
          

          <hr>

          <!-- Post Content -->
          <p class="lead">내용요약</p>

          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Error, nostrum, aliquid, animi, ut quas placeat totam sunt tempora commodi nihil ullam alias modi dicta saepe minima ab quo voluptatem obcaecati?</p>

          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Harum, dolor quis. Sunt, ut, explicabo, aliquam tenetur ratione tempore quidem voluptates cupiditate voluptas illo saepe quaerat numquam recusandae? Qui, necessitatibus, est!</p>

          <hr>

          <!-- Comments Form -->
          <div class="card my-4">
            <h5 class="card-header">댓글</h5>
            <div class="card-body">
              <form>
                <div class="form-group">
                  <textarea class="form-control" rows="3"></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
              </form>
            </div>
          </div>

          <!-- Single Comment -->
          <div class="media mb-4">
            <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="">
            <div class="media-body">
              <h5 class="mt-0">Commenter Name</h5>
              Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.
            </div>
          </div>

          <!-- Comment with nested comments -->
          <div class="media mb-4">
            <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="">
            <div class="media-body">
              <h5 class="mt-0">Commenter Name</h5>
              Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.

              <div class="media mt-4">
                <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="">
                <div class="media-body">
                  <h5 class="mt-0">Commenter Name</h5>
                  Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.
                </div>
              </div>

              <div class="media mt-4">
                <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="">
                <div class="media-body">
                  <h5 class="mt-0">Commenter Name</h5>
                  Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.
                </div>
              </div>

            </div>
          </div>
        </div>
        </div>

      </div>
      <!-- /.row -->

    </div>
    <!-- /.container -->
						
						
					</div><!-- end row -->
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
	   				hong1234<br>
	   				홍길동<br>
	   				010-1234-5678
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
