<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.teacher.TeacherDAO" %>
<%@ page import = "user.teacher.TeacherFoodVO" %>
<%@ page import = "java.util.List" %>

<!doctype html>
<html lang="ko">
<title>식단 상세페이지</title>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> <!-- popup -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
</head>
<body style="font-size:11px;">    
<%
	String fooddate = request.getParameter("fooddate"); //넘어온거 잡음
	
	TeacherDAO dao = TeacherDAO.getInstance();
	TeacherFoodVO foodinfo = dao.foodInfo(fooddate);
%>	
	<form name="foodform" class="ui form" enctype="multipart/form-data"  method="post">
		<table class="table">
			<colgroup>   			
				<col width="20%">
				<col width="30%">		
				<col width="20%">
				<col width="30%">
			</colgroup>
		<tr class="bg-primary" style="color:white;">
			<td>foodnum</td>
			<td><%=foodinfo.getFood_num() %></td>
			<td>fooddate</td>
			<td><%=foodinfo.getFood_date() %></td>
		</tr>
		<tr> <!-- img 들어갈 곳 -->
			<td colspan="4" style="text-align:center"> 
				<img src="/kindergarten/etc/image/teacher/<%= foodinfo.getFood_image()%>" alt="foodimage" style="width:300px; height:180px;">
				<input type="file" class="form-control-file" name="foodimage">
			</td>
		</tr>	
		<tr>
		<% 	
			List<TeacherFoodVO> menulist = dao.foodMenuInfo(fooddate); 
			
			 for(int i=0; i<menulist.size(); i++){
				 TeacherFoodVO menu = menulist.get(i);	 
		%>
		
			<td><strong>번호</strong><input type="hidden" name="menunum" value="<%=menu.getMenu_num()%>"></td>
			<td><%=menu.getMenu_num() %></td> 
			<td><strong>메뉴</strong></td> 
			<td><input type="text" name="menuname" value="<%=menu.getMenu_name() %>"></td>
		</tr>
		
		<%}//end for menulist%>
		
	</table>
	<hr>
	<input type="hidden" name="food_num" value="<%=foodinfo.getFood_num() %>"><!-- 삭제시 사용. foodtest t 삭제 시 foodmenu t 도 삭제됨 (제약조건 추가) -->
	<div style="text-align:right;">
		<button type="button" onclick="imageupdate(this.form)" class="ui green basic button">사진등록</button>
		<button type="button" onclick="menuupdate(this.form)" class="ui blue basic button">메뉴수정</button>
		<button type="button" onclick="menudelete(this.form)" class="ui red basic button">삭제</button>
	</div>
</form>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> <!-- sweetalert -->
<script>
function menuupdate(foodform){
	foodform.action ="teacher_food_update.jsp";
	document.foodform.encoding = "application/x-www-form-urlencoded"; //enc-type 핸들링 
	swal({
		  text: "수정되었습니다.",
	})
	.then((value) => {     
		
		foodform.submit(); 
	});
}
function menudelete(foodform){
	foodform.action = "teacher_food_delete.jsp";
	document.foodform.encoding = "application/x-www-form-urlencoded";
	swal({
		  text: "삭제되었습니다.",
	})
	.then((value) => {  
		
		foodform.submit(); 
	});
}
function imageupdate(foodform){
	foodform.action = "teacher_food_image_update.jsp";
	document.foodform.encoding = "multipart/form-data";
	swal({
		  text: "사진이 등록되었습니다.",
	})
	.then((value) => {     
		
		foodform.submit(); 
	});
}
</script>
</body>
</html>