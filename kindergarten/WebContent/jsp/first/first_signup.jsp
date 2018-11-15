<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<title>회원가입</title>
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

	<div class="container" style="width:60%; margin-top:5%;">	
		<div class="py-5 text-center">
			<a href="first_main.jsp"><img alt="logo" src="/kindergarten/etc/image/first/2.jpg" style="width:270px; height:120px"></a>
		</div>
	
		<form method="post" action="first_signup_pro.jsp" name="signrupform">
	         <div style="margin-top:20px;">
				원아인증&nbsp;&nbsp;<span style="font-size:11px;">인증 완료 시 회원가입 신청이 가능합니다.</span>
			</div>
			<hr><br>
			<div class="row justify-content-center">
				<div class="col-lg-1" style="font-size:12px;">이름</div>
				<div class="col-lg-5 col-offset-3">
					<input type="text" name="con_child_name" class="form-control inputstyle con_child_name">
				</div>    
				<div class="col-lg-1"></div>  
			</div> 
	               
			<div class="row justify-content-center">      
				<div class="col-lg-1" style="font-size:12px;">반</div>
	 			<div class="col-lg-5 col-offset-3">                
					<select class="form-control inputstyle con_child_class" name="con_child_class">
						<option value="A">A</option>
						<option value="B">B</option>
					</select>
				</div>   
				<div class="col-lg-1"></div>     
			</div>
			            
			<div style="text-align:center; margin-top:50px; margin-bottom: 50px;">
				<button type="button" class="btn btn-sm inputstyle childcheckbtn" style="background-color:#FFC107; padding: 0 60px;">인증하기</button>   
			</div>
	                     
			<div id="parent_form" class="justify-content-center" style="display:none;">
				회원정보
				<hr><br>
	
				<div class="row justify-content-center">
					<div class="col-lg-1" style="font-size:12px;">아이디</div>
					<div class="col-lg-5 col-offset-3">                
						<input type="text" name="parents_id" placeholder="아이디" class="form-control inputstyle idcheckinput" required="required">
					</div>	
					<div class="col-lg-1">                
						<button type="button" class="btn btn-sm inputstyle idcheckbtn" id="button-addon2" style="background-color:#FFC107;">중복확인</button>
					</div>	            
				</div>
		        
				<div class="row justify-content-center">
					<div class="col-lg-1" style="font-size:12px;">비밀번호</div>
					<div class="col-lg-5 col-offset-3">                
						<input type="password" name="parents_pwd" placeholder="비밀번호" class="form-control inputstyle" required="required">
					</div>	            
					<div class="col-lg-1"></div>
				</div>
		            
				<div class="row justify-content-center">
					<div class="col-lg-1" style="font-size:12px;">이름</div>
					<div class="col-lg-5 col-offset-3">                
						<input type="text" name="parents_name" placeholder="이름" class="form-control inputstyle" required="required">
					</div>	    
					<div class="col-lg-1"></div>        
				</div>
		            
				<div class="row justify-content-center">
					<div class="col-lg-1" style="font-size:12px;">전화번호</div>
					<div class="col-lg-5 col-offset-3">                
						<input type="text" name="parents_phone" class="form-control inputstyle" placeholder="010-0000-0000" required="required">
					</div>	            
					<div class="col-lg-1"></div>
				</div>
		            
				<div class="row justify-content-center">
					<div class="col-lg-1" style="font-size:12px;">주소</div>
					<div class="col-lg-5 col-offset-3">                
						<input type="text" class="form-control inputstyle" name="parents_post" id="parents_post" readonly="readonly" placeholder="우편번호">
					</div>	
					<div class="col-lg-1">                
						<button type="button" class="btn btn-sm inputstyle" name="postcodeBtn" id="postcodeBtn" style="background-color:#FFC107;">우편번호</button>
					</div>	            
				</div>
		            
				<div class="row justify-content-center">
					<div class="col-lg-1" style="font-size:12px;"></div>
					<div class="col-lg-5 col-offset-3">                
						<input type="text" class="form-control inputstyle" name="parents_addr" id="parents_addr" placeholder="주소">
					</div>	            
					<div class="col-lg-1"></div>
				</div>
				<br>
		         
				<div class="row justify-content-center">
					<button type="button" onclick="signup(this.form);" class="btn btn-sm inputstyle signupbtn" style="background-color:#FFC107; padding: 0 60px;">가입하기</button>
				</div>
			</div>   
		</form>
	</div>
      
	<!--footer-->  
	<jsp:include page="first_footer.inc.jsp" flush="false" />

   	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script> <!-- 위로올림. jquery, ajax 쓰려고  -->
   	
   	<script>
   //회원가입 시 아이디 중복체크 필수 
   var idck = 0;
   //회원가입 시 아이인증체크 필수 
   var chch = 0; 
   
   //아이인증체크
   $(".childcheckbtn").click(function(){
      var con_child_name = $(".con_child_name").val();
      var con_child_class = $(".con_child_class").val();
      
      if(con_child_name == ''){
         swal("아이이름을 입력해주세요.");
         return false; 
      }
      
      $.ajax({
         type: "POST",
         url: "childcheck.jsp",
         data:{con_child_name : con_child_name, con_child_class : con_child_class},
         success: function(result){
            if(result ==0){
               swal("인증 성공");
               chch = 1;
               $("#parent_form").show();
               
            }else{
               swal("인증 실패");
               chch = 0; 
               $("#parent_form").hide();
               
            }                     
         }
      });
   }); 
   
   //아이디중복체크
   $(".idcheckbtn").click(function(){
      var inputId = $(".idcheckinput").val();
      if(inputId == ''){
         swal("아이디를 입력하세요.");
         return false; 
      }
      $.ajax({
         type: "POST",
         url: "idcheck.jsp",
         data: {inputId: inputId},
         success: function(result){ 
            if(result ==1){
               swal("사용할 수 있는 아이디입니다.");
               idch = 1; 
            }else{ 
               swal("사용중인 아이디입니다.");
               idch = 0;
            }         
         }
      });      
   });
   
   
   //회원가입
   function signup(signrupform){
      if(!signrupform.parents_id.value){
         swal("아이디를 입력하세요");
         signrupform.parents_id.focus();
         return false;
      }
      if(!signrupform.parents_pwd.value){
         swal("비밀번호를 입력하세요");
         signrupform.parents_pwd.focus();
         return false;
      }
      if(!signrupform.parents_name.value){
         swal("이름을 입력하세요");
         signrupform.parents_name.focus();
         return false;
      }
      if(!signrupform.parents_phone.value){
         swal("전화번호를 입력하세요");
         signrupform.parents_phone.focus();
         return false;
      }
      if(!signrupform.parents_addr.value){
         swal("주소를 입력하세요");
         signrupform.parents_addr.focus();
         return false;
      }
      if(idch == 1 && chch == 1){
         swal({
              title: "회원가입 성공",
              text: "관리자 승인 시 로그인이 가능합니다.",
              icon: "success"
         })
         .then((value) => {     
            signrupform.submit(); 
         });
      }else if(idch == 0){
         swal("아이디 중복체크를 해주세요.");
      }else if(chch == 0){
         swal("아이 인증을 해주세요.");
      }
   };
	</script>
	
   <script src="/kindergarten/etc/js/first/first_signup.js"></script> <!-- 주소 -->
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
   <script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>
   <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
   <script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
   <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script><!-- sweetalert -->
</body>
</html>