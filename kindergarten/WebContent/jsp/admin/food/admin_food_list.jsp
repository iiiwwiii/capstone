<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import ="java.text.SimpleDateFormat"%>
<%@page import = "java.util.Calendar"%> <!-- 식단표 캘린더  -->
<%@ page import = "user.admin.AdminDAO" %>
<%@ page import = "user.admin.AdminFoodVO" %>
<%@page import="java.sql.Date"%>

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

%>   

<!doctype html>
<html lang="ko">
<title>식단 TEST</title>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> <!-- popup -->
</head>
<body style="font-size:11px;">
<div class="container">
	<br>
	<h4>* 식단 등록 및 리스트 </h4>
	<br>
	
	<span style="color:red; font-weight:bold; font-size:12px;">식단 등록 (메뉴 최대 6개)</span><br><br>
		
	<form method="post" action="admin_food_insert.jsp">
		<div class="row">
			<div class="col-sm-2">식단일 : </div> 
			<div class="col-sm-3"><input type="date" name="fooddate" class="form-control" style="height:28px; font-size:11px; margin-bottom:20px;"></div>
		</div>	
		<div id="menuplusp">
			<div class="row">
				<div class="col-sm-2">메뉴 :  </div> 
				<div class="col-sm-3"><input type="text" name="menuname" class="form-control"></div>
			</div>	
		</div> 
		<br>
		<button type="button" class="btn btn-primary btn-sm" onclick="menuplus()">메뉴추가</button>
		<button type="submit" class="btn btn-danger btn-sm">식단등록</button>
	</form>
	<br><br><br>
	
	<!-- 캘린더  -->	
			<input type="button" onclick="javascript:location.href='./admin_food_list.jsp'" value="today" class="btn btn-success btn-sm"/>
				<a href="./admin_food_list.jsp?year=<%=year-1%>&amp;month=<%=month%>">
					<b>이전해</b>
				</a>
               				<%if(month > 0 ){ %>
					<a href="./admin_food_list.jsp?year=<%=year%>&amp;month=<%=month-1%>">
						<b>이전달</b>
					</a>
				<%} else {%>
                     <b>이전달(1월)</b>	
                 <%} %>
                      			
				 <span style="font-size:20px;"><%=year%>년 <%=month+1%>월</span>

                   <%if(month < 11 ){ %>
					<a href="./admin_food_list.jsp?year=<%=year%>&amp;month=<%=month+1%>">
                          	<b>다음달</b>
					</a>
				<%}else{%>
				 	<b>다음달(12월)</b>
				 <%} %>
				<a href="./admin_food_list.jsp?year=<%=year+1%>&amp;month=<%=month%>">
					<b>다음해</b>
               				</a>
					<br><br>
								
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
			       					<div align="center"><font color="red">일</font></div>
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
			       					<div align="center"><font color="blue">토</font></div>
			       				</td>
							</tr>
						</thead>
						<tbody>
							<tr>
	
<%
				for(int index = 1; index < start ; index++ )		
				{
				  out.println("<td> </td>");
				  newLine++;
				}
				for(int index = 1; index <= endDay; index++)
				{
	       			String color = "";
	       			if(newLine == 0){
	       				color = "red";
	       			}else if(newLine == 6){
	       				color = "blue";
					}

			        
			        //db넘길 값 세팅
			        String javayear = Integer.toString(year)+"-"; //2018-
			        String javamonth = Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1)+"-" : Integer.toString(month+1)+"-"; //08-
			        String javaday = Integer.toString(index).length() == 1 ? "0"+ Integer.toString(index) : Integer.toString(index); //01
			        String javadate = javayear + javamonth + javaday;
			        
			        
	       			String backColor = "#F6F6F6"; //날짜있는 칸 백그라운드

			    	%>
					<td id="<%=javadate %>" class="f_date" style="valign:top; align:left;  height:160px; cursor:pointer; background-color:<%=backColor%>;"> <!--행열고  --> 		  
			
				       <span style="color:<%=color%>;"><%=index %></span> <!-- 일 뿌림  -->
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
							AdminFoodVO menu = menulist.get(ii);	 
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



</div> <!-- end container -->
<script src="/kindergarten/etc/js/parents/parents.js"></script>
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
			url:"admin_food_list_layout.jsp",
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
			document.getElementById("menuplusp").innerHTML += "<div class='row'><div class='col-sm-2'>메뉴 : </div><div class='col-sm-3'><input type='text' name='menuname' class='form-control'></div></div>";
			r++; 
		}else{	
			alert('최대 메뉴 개수 초과');
		}
	}

</script>

</body>
</html>

