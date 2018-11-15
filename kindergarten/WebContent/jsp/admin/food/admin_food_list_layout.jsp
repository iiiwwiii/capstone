<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.admin.AdminDAO" %>
<%@ page import = "user.admin.AdminFoodVO" %>
<%@ page import = "java.util.List" %>

<!doctype html>
<html lang="ko">
<title>ajaxmodal</title>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> <!-- popup -->
</head>
<body style="font-size:11px;">    
<%
	String fooddate = request.getParameter("fooddate"); //넘어온거 잡음
	
	AdminDAO dao = AdminDAO.getInstance();
	AdminFoodVO foodinfo = dao.foodInfo(fooddate);
%>	
	<form name="foodform" enctype="multipart/form-data"  method="post">
		<table class="table">
			<colgroup>   			
				<col width="20%">
				<col width="30%">		
				<col width="20%">
				<col width="30%">
			</colgroup>
		<tr class="bg-primary" style="color:white;">
			<td>foodnum</td><td><%=foodinfo.getFood_num() %></td>
			<td>fooddate</td>
			<td><%=foodinfo.getFood_date() %></td>
		</tr>
		<tr> <!-- img 들어갈 곳 -->
			<td colspan="4" style="text-align:center"> 
				<img src="/kindergarten/etc/image/admin/<%= foodinfo.getFood_image()%>" alt="foodimage" style="width:300px; height:180px;">
				<input type="file" class="form-control-file" name="foodimage">
			</td>
		</tr>
	
			<tr>
		<% 	
			List<AdminFoodVO> menulist = dao.foodMenuInfo(fooddate); 
			
			 for(int i=0; i<menulist.size(); i++){
				 AdminFoodVO menu = menulist.get(i);	 
		%>
		
				<td>menunum<input type="hidden" name="menunum" value="<%=menu.getMenu_num()%>"></td> <!-- 수정시 사용 -->
				<td><%=menu.getMenu_num() %></td> 
				<td>menuname</td> 
				<td>
					<input type="text" name="menuname" value="<%=menu.getMenu_name() %>"><!-- 수정시 사용 -->
				</td>
			</tr>
		
		<%}//end for menulist%>
		
		</table>
	<hr>
	<input type="hidden" name="food_num" value="<%=foodinfo.getFood_num() %>"><!-- 삭제시 사용. foodtest t 삭제 시 foodmenu t 도 삭제됨 (제약조건 추가) -->
	<div style="text-align:right;">
		<button type="button" onclick="imageupdate(this.form)" class="btn btn-success btn-sm">사진등록</button>
		<button type="button" onclick="menuupdate(this.form)" class="btn btn-primary btn-sm">메뉴수정</button>
		<button type="button" onclick="menudelete(this.form)" class="btn btn-danger btn-sm">삭제</button>
	</div>
</form>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> <!-- sweetalert -->
<script>
function menuupdate(foodform){
	foodform.action ="admin_food_update.jsp";
	document.foodform.encoding = "application/x-www-form-urlencoded"; //enc-type 핸들링 
	swal({
		  text: "수정되었습니다.",
	})
	.then((value) => {     
		
		foodform.submit(); 
	});
}
function menudelete(foodform){
	foodform.action = "admin_food_delete.jsp";
	document.foodform.encoding = "application/x-www-form-urlencoded";
	swal({
		  text: "삭제되었습니다.",
	})
	.then((value) => {  
		
		foodform.submit(); 
	});
}
function imageupdate(foodform){
	foodform.action = "admin_food_image_update.jsp";
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