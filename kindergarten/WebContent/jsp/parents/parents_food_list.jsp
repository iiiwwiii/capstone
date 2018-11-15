<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import ="java.text.SimpleDateFormat"%>
<%@page import = "java.util.Calendar"%> <!-- 식단표 캘린더  -->
<%@ page import = "user.admin.AdminDAO" %>
<%@ page import = "user.parents.ParentsDAO" %>
<%@ page import = "user.admin.AdminFoodVO" %>
<%@ page import = "java.util.Date"%>
<%!
	Date today = new Date(); 
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<%

	AdminDAO dao = AdminDAO.getInstance();
	List<AdminFoodVO> menulist = null;
	int menuco = 0;
		
	//여기부터 캘린더 ==================================================================
	Calendar cal = Calendar.getInstance();
	String strYear = request.getParameter("year");	
	String strMonth = request.getParameter("month");
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH);
	int date = cal.get(Calendar.DATE);
	
	if(strYear != null)
	{
		year = Integer.parseInt(strYear);
		month = Integer.parseInt(strMonth); 
	}else{}

	cal.set(year, month, 1); //(년,월,일)
	int startDay = cal.getMinimum(java.util.Calendar.DATE); 
	int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); //마지막 일 
	int start = cal.get(java.util.Calendar.DAY_OF_WEEK); //달의 첫번째 일/요일 인가 봄 
	int newLine = 0;
	
	String id = null;
	if(session.getAttribute("id")==null){		
		response.sendRedirect("/kindergarten/jsp/first/first_main.jsp");
	}else  if(session.getAttribute("id")!=null){
		id = (String)session.getAttribute("id");

%>   
<!doctype html>
<html lang="ko">
<title>학부모 식단</title>
<style>
	td:hover{
		background-color:#F6F6F6;
	}
</style>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> 
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" >
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
<link href="/kindergarten/etc/css/nav/nav.css" rel="stylesheet" type="text/css"> <!-- nav -->
<link href="/kindergarten/etc/css/parents/parents_default.css" rel="stylesheet" type="text/css"> <!-- html, body, footer-->
</head>
<body>

<!-- menu -->
<jsp:include page="parents_menu.inc.jsp" flush="false" />
	
<div class="container" style="margin-top:10%;">
	<div class="pricing-header pb-md-4 mx-auto text-center">
		<h1 class="display-4">식단</h1>
		<p class="lead pt-2">한달 간 유치원에서 제공되는 식단을 한눈에 확인할 수 있는 공간입니다.</p>
	</div>
	
	<div class="row">
		<div class="col-sm-12">
			<br><br> 		
			<!-- 캘린더  -->
			<h3 class="ui center aligned header"><%=year%>년 <%=month + 1%>월</h3>
			<div class="fields">
			<%
				if (month > 0) {
			%>
				<a class="ui left labeled icon button" href="./parents_food_list.jsp?year=<%=year%>&amp;month=<%=month - 1%>">
					<i class="angle left icon"></i> 이전달</a>
			<%} else {}%>
			<%
				if (month < 11) {
			%>
				<a class="ui right labeled right floated icon button" href="./parents_food_list.jsp?year=<%=year%>&amp;month=<%=month + 1%>">
					<i class="angle right icon"></i> 다음달</a>
			<%} else {}%>
			</div>
				<table class="table table-bordered" style="margin-top:2%">
					<colgroup>
						<col width="10%">
						<col width="16%">
						<col width="16%">
						<col width="16%">
						<col width="16%">
						<col width="16%">
						<col width="10%">
					</colgroup>
					<thead>
						<tr class="bg-warning">
							<td>
								<div align="center">
									<font color="red">일</font>
								</div>
							</td>
							<td>
								<div align="center">월</div>
							</td>
							<td>
								<div align="center">화</div>
							</td>
							<td>
								<div align="center">수</div>
							</td>
							<td>
								<div align="center">목</div>
							</td>
							<td>
								<div align="center">금</div>
							</td>
							<td>
								<div align="center">
									<font color="blue">토</font>
								</div>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<%
								for (int index = 1; index < start; index++) {
										out.println("<td> </td>");
										newLine++;
									}
									for (int index = 1; index <= endDay; index++) {
										String color = "";
										if (newLine == 0) {
											color = "red";
										} else if (newLine == 6) {
											color = "blue";
										}

										//db넘길 값 세팅
										String javayear = Integer.toString(year) + "-"; //2018-
										String javamonth = Integer.toString(month + 1).length() == 1
												? "0" + Integer.toString(month + 1) + "-"
												: Integer.toString(month + 1) + "-"; //08-
										String javaday = Integer.toString(index).length() == 1 ? "0" + Integer.toString(index)
												: Integer.toString(index); //01
										String javadate = javayear + javamonth + javaday;
							%>
							<td id="<%=javadate%>" class="f_date" style="valign: top; align: left; font-size: 10px; height: 155px; cursor: pointer;">
								<!--행열고  --> <span style="color:<%=color%>;"><%=index%></span>
								<!-- 일 뿌림  --> 
							<%
 			out.println("<br>");
 			//out.println(iUseDate);  //날짜뿌림 20180808 이렇게 나옴 
 			// out.println("<br>");
 			//out.println(javadate);
 			// List<AdminFoodVO> menulist = dao.calendarmenuList(javadate);

 			menuco = dao.menucount(javadate);

 			if (menuco == 0) {
 				out.println(" ");
 			} else if (menuco != 0) {
 				menulist = dao.calendarmenuList(javadate);
 				for (int ii = 0; ii < menulist.size(); ii++) {
 					AdminFoodVO menu = menulist.get(ii);
 					out.println(menu.getMenu_name());
 					out.println("<br>");
 				}
 			}

 			out.println("</td>");
 			newLine++; //열 개수 세기 

 			if (newLine == 7) //7이면(1줄완료시) tr 행 닫음 
 			{
 				out.println("</tr>");
 				if (index <= endDay) //아직 안끝났으면 다시 행 염 
 				{
 					out.println("<tr>");
 				}
 				newLine = 0; //초기화 - 0에서 7까지 열 세는 용도 
 			}
 		}

 		while (newLine > 0 && newLine < 7) //남은게 0에서 7사이면 - 아직 한 행이 다 안끝났으면 
 		{
 			out.println("<td> </td>");
 			newLine++;
 		}
 %>
							
						</tr>
					</tbody>
				</table>
			</div><!-- end col-sm-8 -->
		
<%
		//오늘 식단 뿌리기 - 사진이랑 정보 따로 가져와야됨 -> 사진은 string 1개, 메뉴들은 List<String> 이면 될듯 
		//식단이 없을 수도 있음. 이런건 체크해주기 -> 사진 가져와서 있으면... 사진은 없을수도 있으니까 메뉴가져와서 0이아니면으로 체크해야겠당
		//String tme = sdf.format(today); 
		//ParentsDAO pdao = ParentsDAO.getInstance();
		//List<AdminFoodVO> todaymenu = null;
		//int result = 0;
		//result = pdao.parentsTodayMenuCount(tme);  
		//if(result!=0){
		//	todaymenu = pdao.parentsTodayMenu(tme); 
		//}
	
		//String todaymenuimage = pdao.parentsTodayMenuImage(tme); 

%>

	</div><!-- end row  -->
	<br><br><br><br><br>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>  

<!-- 식단 상세정보 modal - ajax  -->
	<div id="exampleModalCenter" class="modal fade">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				 <div class="modal-header">
			        <h5 class="modal-title">식단 상세정보</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>			
				<div class="modal-body" id="food_detail">
				</div>
			</div>
		</div>
	</div>
</div> <!-- end container -->

<!--footer-->
<jsp:include page="parents_footer.inc.jsp" flush="false" />
	
<script>	
	//td - modal 
	$('.f_date').click(function(){
		var fooddate = $(this).attr("id");
		//alert(fooddate);
		$.ajax({
			url:"parents_food_list_layout.jsp",
			method:"post",
			data:{fooddate:fooddate},
			success:function(data){
				$('#food_detail').html(data);
				$('#exampleModalCenter').modal("show"); 
			}
		});
	});
</script>

<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script> <!-- 반드시 윗줄->nav.js -->
<script src="https://unpkg.com/popper.js@1.12.6/dist/umd/popper.js"></script>
<script src="https://unpkg.com/bootstrap-material-design@4.1.1/dist/js/bootstrap-material-design.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
</body>
</html>
<%} %>
