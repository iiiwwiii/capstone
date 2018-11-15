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
				<col width="80%">		
			</colgroup>
		<tr class="bg-warning" style="color:white;">
			<td>등록일</td>
			<td><%=foodinfo.getFood_date() %></td>
		</tr>
		<tr> <!-- img 들어갈 곳 -->
		<td>이미지</td>
			<td> 
				<img src="/kindergarten/etc/image/admin/<%= foodinfo.getFood_image()%>" alt="foodimage" style="width:100%; height:200px;">			
			</td>
		</tr>
	
			<tr>
			<td>메뉴</td>
				<td>
		<% 	
			List<AdminFoodVO> menulist = dao.foodMenuInfo(fooddate); 
			
			 for(int i=0; i<menulist.size(); i++){
				 AdminFoodVO menu = menulist.get(i);	 
		%>			
					<%=menu.getMenu_name() %> <br>	
		<%}//end for menulist%>
		</td>
			</tr>
		</table>
	<hr>

</form>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> <!-- sweetalert -->

</body>
</html>