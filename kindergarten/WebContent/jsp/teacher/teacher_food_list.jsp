<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import ="java.text.SimpleDateFormat"%>
<%@page import = "java.util.Calendar"%> <!-- 식단표 캘린더  -->
<%@ page import = "user.teacher.TeacherDAO" %>
<%@ page import = "user.teacher.TeacherFoodVO" %>
<%@page import="java.sql.Date"%>

<%
	TeacherDAO dao = TeacherDAO.getInstance();
	List<TeacherFoodVO> menulist = null;
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

%>   

<!doctype html>
<html lang="ko">
<title>선생님 식단 관리</title>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> <!-- popup -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
<link href="/kindergarten/etc/css/nav/nav.css" rel="stylesheet" type="text/css"> <!-- nav -->
<link href="/kindergarten/etc/css/parents/parents_default.css" rel="stylesheet" type="text/css"> <!-- html, body, footer-->
</head>
<body style="font-size:12px;">

<!-- menu -->
<jsp:include page="teacher_menu.inc.jsp" flush="false" />

<div class="container" style="margin-top:7%;">
	<div class="pricing-header pb-md-4 mx-auto text-center">
      	<h1 class="display-4">식단 관리</h1>
      	<p class="lead mt-3">식단을 관리하는 공간이며 최대 6개까지 등록 가능합니다.</p>
    </div>		
	<form method="post" class="ui form" action="teacher_food_insert.jsp">
		<div class="field">
			<label>식단일</label>
    		<input type="date" name="fooddate" class="form-control">
		</div>	
		<div id="menuplusp" class="field">
			<label>메뉴</label>
    		<input type="text" name="menuname" class="form-control">
		</div>
		<div class="two ui buttons">
			<button type="button" class="ui grey basic button" onclick="menuplus()">메뉴추가</button>
			<button type="submit" class="ui yellow basic button">식단등록</button>
		</div>		
	</form>
	<br><br><br>
	<h3 class="ui center aligned header"><%=year%>년 <%=month+1%>월</h3>
	<div class="ui buttons">
		<a class="ui labeled icon button" href="./teacher_food_list.jsp?year=<%=year-1%>&amp;month=<%=month%>">
			<i class="calendar outline icon"></i> 이전해</a>
<%if(month > 0 ){ %>
		<a class="ui button" href="./teacher_food_list.jsp?year=<%=year%>&amp;month=<%=month-1%>">
			<i class="angle left icon"></i>이전달</a>
	</div>
<%} else {%>
    <b>첫번째 달</b>	
<%}if(month < 11 ){ %>
	<div class="ui right floated buttons">
	  <a class="ui button" href="./teacher_food_list.jsp?year=<%=year%>&amp;month=<%=month+1%>">
	  	다음달<i class="angle right icon"></i></a>
<%}else{%>
	<b>마지막 달</b>
<%}%>
	<a class="ui right labeled icon button" href="./teacher_food_list.jsp?year=<%=year+1%>&amp;month=<%=month%>">
	    <i class="calendar outline icon"></i>다음해</a>
	</div>
	<br><br>					
	<!-- 캘린더  -->			
	<table class="table table-bordered">
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
				<tr>
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
							String javamonth = Integer.toString(month + 1).length() == 1 ? "0" + Integer.toString(month + 1) + "-"
									: Integer.toString(month + 1) + "-"; //08-
							String javaday = Integer.toString(index).length() == 1 ? "0" + Integer.toString(index)
									: Integer.toString(index); //01
							String javadate = javayear + javamonth + javaday;

							String backColor = "#F6F6F6"; //날짜있는 칸 백그라운드
					%>
					<td id="<%=javadate %>" class="f_date" style="valign:top; align:left; height:160px; cursor:pointer; background-color:<%=backColor%>;">
						<!--행열고  --> <span style="color:<%=color%>;"><%=index %></span> <!-- 일 뿌림  -->
						<%
				       out.println("<br><br>");
				       //out.println(iUseDate);  //날짜뿌림 20180808 이렇게 나옴 
				      // out.println("<br>");
				       
				       //out.println(javadate);
				   
				      // List<AdminFoodVO> menulist = dao.calendarmenuList(javadate);
				     
				      menuco = dao.menucount(javadate);
				     // out.println(menuco); //이상없음)

					if(menuco == 0){
						out.println(" ");
					}else if(menuco !=0){
						menulist = dao.calendarmenuList(javadate);
						for(int ii=0; ii<menulist.size(); ii++){
							TeacherFoodVO menu = menulist.get(ii);	 
							out.println(menu.getMenu_name());
							out.println("<br>");
						}
					}
			  	    	
			       out.println("</td>");
			       newLine++;					//열 개수 세기 
			       
			       if(newLine == 7)					//7이면(1줄완료시) tr 행 닫음 
			       {
				         out.println("</tr>");
				         if(index <= endDay)		//아직 안끝났으면 다시 행 염 
				         {
				           out.println("<tr>");
				         }
				         newLine=0;					//초기화 - 0에서 7까지 열 세는 용도 
				       }
				}
		
				while(newLine > 0 && newLine < 7)		//남은게 0에서 7사이면 - 아직 한 행이 다 안끝났으면 
				{
				  out.println("<td> </td>");
				  newLine++;
				}
%>				
				</tr>
			</tbody>
		</table>	
	<br><br><br><br><br>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>  

	<!-- 식단 상세정보 modal - ajax  -->
	<div id="dataModal" class="modal fade">
		<div class="modal-dialog">
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
	
</div>
<!--footer-->
<jsp:include page="teacher_footer.inc.jsp" flush="false" />	

<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script> <!-- 반드시 윗줄->nav.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> <!-- sweetalert -->

<script>
	//수정 - 안씀(ajax에서 처리)
	$('.menuupdate').click(function(){
		var fo = $(this).attr("id");
		alert(fo);
	});
	
	//td - modal 
	$('.f_date').click(function(){
		var fooddate = $(this).attr("id");
		//alert(fooddate);
		$.ajax({
			url:"teacher_food_list_layout.jsp",
			method:"post",
			data:{fooddate:fooddate},
			success:function(data){
				$('#food_detail').html(data);
				$('#dataModal').modal("show"); 
			}
		});
	});
	
	//메뉴 행 추가 및 최대 개수 설정 (테이블행높이지정고려)
	var r = 0;  
	function menuplus(){
		if(r<=4){
			document.getElementById("menuplusp").innerHTML += "<div id='menuplusp' class='field'><label>메뉴</label><input type='text' name='menuname' class='form-control'></div>";
			r++; 
		}else{	
			alert('최대 메뉴 개수 초과');
		}
	}

</script>

</body>
</html>