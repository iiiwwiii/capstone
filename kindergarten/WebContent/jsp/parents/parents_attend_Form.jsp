<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="user.parents.ParentsDAO"%> 
<%@ page import="user.child.ChildVO"%> 
<%@ page import="attend.AttendanceDAO"%>
<%@ page import="java.util.Date"%>

<jsp:useBean id="to_teacher" scope="page" class="attend.To_teacherVO">
   <jsp:setProperty name="to_teacher" property="*"/>
</jsp:useBean>

<%
	String id = null;
	if(session.getAttribute("id")==null ||session.getAttribute("id").equals("teacher")){      
	   response.sendRedirect("/kindergarten/jsp/first/first_main.jsp");
	}else  if(session.getAttribute("id")!=null){
	   id = (String)session.getAttribute("id");
%>


<!doctype html>
<html lang="ko">
<title>학부모 출석부</title>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> 
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" >
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
<link href="/kindergarten/etc/css/nav/nav.css" rel="stylesheet" type="text/css"> <!-- nav -->
<link href="/kindergarten/etc/css/parents/parents_default.css" rel="stylesheet" type="text/css"> <!-- html, body, footer-->
<title>학부모 출석부 관리</title>
</head>
<body>
<!-- menu -->
<jsp:include page="parents_menu.inc.jsp" flush="false" />

	<div class="container" style="margin-top: 7%;">
		<div class="pricing-header pb-md-4 mx-auto text-center" style="margin-bottom: 20px;">
			<h1 class="display-4">출석부</h1>
			<p class="lead pt-2">우리 아이의 출석을 관리하거나 담당 선생님께 전달하고 싶은 사항을 등록하는 공간입니다.</p>
		</div>
		<div class="ui form">
			<div class="field">
				<label>사유</label>
				<textarea rows="10" name="to_content" id="to_content"></textarea>
				<input type="hidden" name="parents_id" value="<%=id%>"> 
				<input type="hidden" name="absence" value="1">
			</div>
			<div class="two fields">
				<div class="field">
					<label>시작 날짜</label> 
					<input placeholder="yyyy-mm-dd" type="date" name="start_date" id="start_date">
				</div>
				<div class="field">
					<label>종료 날짜</label> 
					<input placeholder="yyyy-mm-dd" type="date" name="end_date" id="end_date">
				</div>
			</div>
			<div class="three ui buttons">
				<button class="ui button" onclick="absence()">결석합니다</button>
				<button class="ui button" type="button" onclick="re()">요청합니다</button>
				<button class="ui button" type="button" onclick="late()">지각입니다</button>
			</div>
		</div>

		<table class="table">
			<colgroup>
				<col width="20%">
				<col width="*">
				<col width="15%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">날짜</th>
					<th scope="col">내용</th>
					<th scope="col">결석/지각/요청</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td id="date_1"></td>
					<td id="to_content"></td>
					<td id="absence"></td>
				</tr>
			</tbody>
		</table>
	</div>

<jsp:include page="parents_footer.inc.jsp" flush="false" />

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script> <!-- 반드시 윗줄->nav.js -->
<script src="https://unpkg.com/popper.js@1.12.6/dist/umd/popper.js"></script>
<script src="https://unpkg.com/bootstrap-material-design@4.1.1/dist/js/bootstrap-material-design.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js'></script>

<script type="text/javascript">   
   
   function absence(){
      var real = confirm("결석 제출하시겠습니까 ?");
      if(real){
         ajax1();
      }
   }
   
   function ajax1(){
      $.ajax({
          type : "get",
         url : "parents_attend_Pro.jsp",
         dataType : 'JSON',
         data : {
            parents_id : '<%= id%>',
            absence   : 1,
            start_date : $("#start_date").val(),
            end_date : $("#end_date").val(),
            to_content : $("#to_content").val()
         },
         success : function(data) { 
            $.each(data, function(){
               if(this.absence == '1'){
                  var absence = '결석';
               }else if(this.absence == '2'){
                  var absence = '요청';
               }else if(this.absence == '3'){
                  var absence = '지각';
               }
               //alert(absence);
               $("table tbody").append("<tr><td id='date_1'>"+this.start_date + " - " + this.end_date+"</td><td>"+this.to_content+"</td><td>"+absence+"</td></tr>");
            });
         },
         error: function(error){
            alert("에러");
         }
       });
   }
   
   function re(){
	      var real = confirm("요청사항을 제출하시겠습니까 ?");
	      if(real){
	         ajax2();
	      }
	   }
	   
	   function ajax2(){
	      $.ajax({
	          type : "get",
	         url : "parents_attend_Pro.jsp",
	         dataType : 'JSON',
	         data : {
	            parents_id : '<%= id%>',
	            absence   : 2,
	            start_date : $("#start_date").val(),
	            end_date : $("#end_date").val(),
	            to_content : $("#to_content").val()
	         },
	         success : function(data) { 
	            $.each(data, function(){
	            	if(this.absence == '1'){
	                    var absence = '결석';
	                 }else if(this.absence == '2'){
	                    var absence = '요청';
	                 }else if(this.absence == '3'){
	                    var absence = '지각';
	                 }
	               $("table tbody").append("<tr><td id='date_1'>"+this.start_date + " - " + this.end_date+"</td><td>"+this.to_content+"</td><td>"+absence+"</td></tr>");
	            });
	         },
	         error: function(error){
	            alert("에러");
	         }
	       });
	   }
	   
	   function late(){
		      var real = confirm("지각 등록하시겠습니까 ?");
		      if(real){
		         ajax3();
		      }
		   }
		   
		   function ajax3(){
		      $.ajax({
		          type : "get",
		         url : "parents_attend_Pro.jsp",
		         dataType : 'JSON',
		         data : {
		            parents_id : '<%= id%>',
		            absence   : 3,
		            start_date : $("#start_date").val(),
		            end_date : $("#end_date").val(),
		            to_content : $("#to_content").val()
		         },
		         success : function(data) { 
		            $.each(data, function(){
		            	if(this.absence == '1'){
		                    var absence = '결석';
		                 }else if(this.absence == '2'){
		                    var absence = '요청';
		                 }else if(this.absence == '3'){
		                    var absence = '지각';
		                 }
		               $("table tbody").append("<tr><td id='date_1'>"+this.start_date + " - " + this.end_date+"</td><td>"+this.to_content+"</td><td>"+absence+"</td></tr>");
		            });
		         },
		         error: function(error){
		            alert("에러");
		         }
		       });
		   }
</script>
<%}%>
</body>
</html>