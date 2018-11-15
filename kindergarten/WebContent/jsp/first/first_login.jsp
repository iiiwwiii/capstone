<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<title>로그인</title>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> 
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" >
	<link href="/kindergarten/etc/css/nav/nav.css" rel="stylesheet" type="text/css"> <!-- nav -->
	<link href="/kindergarten/etc/css/first/first_signup.css" rel="stylesheet" type="text/css"> 
</head>
<body>

<div class="container" style="width:50%; margin-top:10%">
	<div class="py-5 text-center">
			 <a href="first_main.jsp"><img alt="logo" src="/kindergarten/etc/image/first/2.jpg" style="width:270px; height:120px"></a>
	</div>
	
	<form method="post" action="first_login_pro.jsp">	
		<div class="row justify-content-center">
			<div class="col-sm-6">
				<div class="input-group">                                         
					<div class="input-group-prepend">
						<span class="input-group-text"><i class="fas fa-user"></i> </span>
					</div>
					<input type="text" class="form-control" name="login_id" placeholder="아이디" required="required">
				</div> 
			</div>	
		</div>   
		<div class="row justify-content-center">
			<div class="col-sm-6">
				<div class="input-group">                                         
					<div class="input-group-prepend">
						<span class="input-group-text"><i class="fas fa-unlock-alt"></i> </span>
					</div>
					<input type="password" class="form-control" name="login_pwd" placeholder="비밀번호" required="required"> 
				</div>  
			</div>
		</div> 
		<a href="first_signup.jsp" class="btn btn-link col-lg-3" style="margin-left:20%; margin-top:3%">아직 회원이 아니십니까?</a>
		<div class="row justify-content-center">
			<div style="text-align: center">
				<button type="submit" class="btn btn-warning btn-lg">로그인</button>
			</div>
		</div> 
	</form>	
</div>

<!--footer-->
<jsp:include page="first_footer.inc.jsp" flush="false" />

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>  
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> <!-- sweetalert -->
</body>
</html>