<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.admin.AdminCalendarVO" %>
<%@ page import = "user.admin.AdminDAO" %>
<%@ page import = "java.util.List" %>
<%@page import = "java.util.Calendar"%> <!-- month -->
<%
	request.setCharacterEncoding("utf-8"); 

	List<AdminCalendarVO> calendarList = null;  
	AdminDAO dao = AdminDAO.getInstance();												
	int count = dao.calendarCount(); //일정 몇개냐 ~ 
 
	if (count > 0) {																		
		calendarList = dao.calendarList();	//전체가져와라 ~ ==> 일단 전체 가져와서 뿌리고 나중에 달마다 뿌리기 							
	}	 
	
	//month
	Calendar cal = Calendar.getInstance();
	int month = cal.get(Calendar.MONTH)+1; //현재 2018-10-19 기준 9라고 나와서 +1함 
	
	String ss;

%>   
<!doctype html>
<html lang="ko">
<title>유치원 일정 리스트</title>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> <!-- popup -->
</head>
<body style="font-size:12px;">
<div class="container">
	
	<div style="border: 1px solid #444; margin-top:60px; padding:20px;">
		<h4>유치원 일정 등록 폼</h4>		
		
		<form method="post" action="admin_calendar_insert.jsp">
			<div class="row">
				<div class="col-sm-3">
					<input type="date" name="calendar_start_date" class="form-control calendar_start_date">
				</div>
				<div class="col-sm-3">
					<input type="date" name="calendar_end_date" class="form-control calendar_end_date">
				</div>
				<div class="col-sm-1">
					<input type="checkbox" class="calendardaycheck">당일 
				</div>
				<div class="col-sm-3">
					<input type="text" name="calendar_title" class="form-control" placeholder="일정명">
				</div>
				<div class="col-sm-2">
					<button type="submit" class="btn btn-sm btn-primary">등록</button>
				</div>	
			</div>	
		</form>	
	</div>
	
	
	<div style="border: 1px solid #444; margin-top:20px; padding:20px;">
		<h4>유치원 월별 일정 리스트</h4>	
			
		<nav class="nav nav-pills flex-column flex-sm-row"> <!-- class에 active 하면 파란색배경 -->	
			<a class="flex-sm-fill text-sm-center nav-link month_w" id="전체리스트" href="#">전체</a>
			<% for(int i=1; i<=12; i++){%>
				<a class="flex-sm-fill text-sm-center nav-link month_w" id="<%=i %>" href="#"><%=i %>월</a> 
			<%}%>		
		</nav>
		
		<div class="monthcalendarlist" id="monthcalendarlist">
		
		</div>
		
		
		<br>
	</div>

	
</div><!-- div container -->
<script src="/kindergarten/etc/js/parents/parents.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>  
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> <!-- sweetalert -->
<script>

//시작=끝 : 당일
	$(".calendardaycheck").click(function(){
		var date = $(".calendar_start_date").val();
		//alert(date);
		$(".calendar_end_date").val(date);
	});


//월 클릭 시 값
	$('.month_w').click(function(){
		var monthid = $(this).attr("id");
		$(this).addClass('active');
		$(this).siblings().removeClass('active');
		
		//alert(monthid); //잘 나옴 1월이면 1, 12월이면 12 -> 넘어가서 1부터9까지 앞에 0붙이는 작업 해야됨
		
		$.ajax({
			url:"admin_calendar_list_month.jsp",
			method:"post",
			data:{monthid:monthid},
			success:function(data){
				$('#monthcalendarlist').html(data);
			}
		});
	});
	



</script>
</body>
</html>