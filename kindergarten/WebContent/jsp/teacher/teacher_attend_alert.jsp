<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="attend.AttendanceDAO"%>
<%@ page import="picture.ScheduleDAO"%>
<%@ page import="attend.AttendanceVO"%>
<%@ page import="attend.To_teacherVO"%>
<%@ page import="attend.AlertVO"%>
<%@ page import="picture.ScheduleVO"%>
<%@ page import="user.child.ChildVO"%>

<%
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat ssf = new SimpleDateFormat("yyyy년 MM월 dd일");
	String today = null;
	Calendar cal = Calendar.getInstance();

	if (request.getParameter("today") != null && request.getParameter("move") != null) { //2018-11-08형식으로 옴
		cal.setTime(java.sql.Date.valueOf(request.getParameter("today")));
		if (request.getParameter("move").equals("front")) {
			cal.add(Calendar.DATE, 1);
		} else if (request.getParameter("move").equals("back")) {
			cal.add(Calendar.DATE, -1);
		}
		today = df.format(cal.getTime());

	} else {
		today = df.format(cal.getTime());
	}

	String id = null;
	if (session.getAttribute("id") == null) {
		response.sendRedirect("/kindergarten/jsp/first/first_main.jsp");
	} else if (session.getAttribute("id") != null) {
		id = (String) session.getAttribute("id");

		AttendanceDAO dbPro = AttendanceDAO.getInstance();
		List<ChildVO> childList = null;
		ChildVO child = null;
		List<AttendanceVO> attendList = null;
		AttendanceVO attend = null;
%>

<!DOCTYPE html>
<html>
<title>선생님 출석부/알림장</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
<link href="/kindergarten/etc/css/nav/nav.css" rel="stylesheet" type="text/css"><!-- nav -->
<body>

<!-- menu -->
<jsp:include page="teacher_menu.inc.jsp" flush="false" />

<div class="container" style="margin-top:10%;">
	<div class="pricing-header pb-md-4 mx-auto text-center">
      	<h1 class="display-4">출석부/알림장</h1>
      	<p class="lead mt-3">아이들의 출석을 관리하고 반체와 개인별로 알림장을 작성할 수 있는 공간입니다.</p>
    </div>
		<!-- 전체 알림장 -->
		<div class="container" style="padding-top: 3%">
				<h1 class="ui center aligned header"><%=today%></h1>
				<a class="ui left floated button" onclick="back_today()"><i class="angle left icon"></i>이전날 </a> 
				<a class="ui right floated button" onclick="next_today()">다음날<i class="angle right icon"></i></a>
				<button data-toggle="collapse" href="#collapsealert_all" role="button" type="button" class="ui olive basic button" style="margin-left:33%;">전체 알림장 열기</button>

				<div class="card card_1 collapse" id="collapsealert_all">
					<div class="card-body" id="div_all">
						<%
							String all_alert = dbPro.get_all_alert(id, java.sql.Date.valueOf(today));
								if (all_alert != null) {
						%>
						<div class="form-group">
							<textarea class="form-control" id="al_content" rows="8" readonly><%=all_alert%></textarea>
						</div>
						<div class="text-right">
							<button type="button" class="ui olive button" onclick="update_alert_all('<%=all_alert%>')">수정</button>
							<button type="button" class="ui button" onclick="delete_alert_all()">삭제</button>
						</div>
						<%
							} else {
						%>
						<div class="form-group">
							<textarea class="form-control" id="al_content" placeholder="전체 알림장을 등록해주세요" rows="8"></textarea>
						</div>
						<div class="text-right">
							<button type="button" class="ui yellow right floated button" onclick="insert_alert_all()">등록</button>
						</div>
						<%
							}
						%>
					</div>
					<!-- card-body end -->
				</div>
				<!-- card_1 end -->
		</div>
		<br>
		<!-- 전체 알림장 끝-->

		<%
			//선생님 세션 넣으면 됨
				childList = dbPro.get_Child("teacher");
				SimpleDateFormat sf = new SimpleDateFormat("hh:mm");
				if (childList != null) {
					for (int i = 0; i < childList.size(); i++) {
						child = childList.get(i);
		%>
		<div class="container" style="margin-top:3%">
			<div class="accordion" id="accordionExample">
				<div class="card">
					<div class="card-header" id="headingOne">
						<h5 class="mb-0">
							<a class="collapsed" data-toggle="collapse" href="#<%=child.getChild_num()%>" aria-expanded="false" aria-controls="collapseOne"> 
							&nbsp;▼&nbsp;<%=child.getChild_name()%>가정으로
							</a>
						</h5>
					</div>
					
					<div id="<%=child.getChild_num()%>" class="collapse" role="tabpanel" aria-labelledby="headingOne" data-parent="#accordionExample">
						<div class="card-body">
							<%
								AlertVO alert = dbPro.get_alert_one(child.getParents_id(), java.sql.Date.valueOf(today));
											if (alert != null) {
							%>
							<div class="row">
								<div class="col-sm-3">
									<select class="custom-select custom-select-sm mb-3" id="alert_health<%=child.getChild_num()%>">
										<option selected>건강상태</option>
										<option value="health_good">건강상태 좋음</option>
										<option value="health_cautious">건강상태 주의</option>
										<option value="health_bad">건강상태 나쁨</option>
									</select> 
									<select class="custom-select custom-select-sm mb-3" id="alert_tem<%=child.getChild_num()%>">
										<option selected>체온상태</option>
										<option value="tem_normal">체온 정상</option>
										<option value="tem_high">체온 높음</option>
										<option value="tem_low">체온 낮음</option>
									</select> 
									<select class="custom-select custom-select-sm mb-3" id="alert_poo<%=child.getChild_num()%>">
										<option selected>배변상태</option>
										<option value="poo_ok">배변활동 정상</option>
										<option value="poo_not_ok">배변활동 비정상</option>
									</select> 
									<select class="custom-select custom-select-sm mb-3" id="alert_sleep<%=child.getChild_num()%>">
										<option selected>수면여부</option>
										<option value="sleep_enough">수면시간 충분</option>
										<option value="sleep_not_enough">수면시간 불충분</option>
									</select> 
									<select class="custom-select custom-select-sm mb-3" id="alert_food<%=child.getChild_num()%>">
										<option selected>식사여부</option>
										<option value="food_yes">식사함</option>
										<option value="food_no">식사안함</option>
									</select><br><br>
								</div>
								<!-- col-sm-3 end -->
								<div class="col-sm-9">
									<textarea style="width: 100%; height:200px;" id="one_content<%=child.getChild_num()%>" readonly><%=alert.getAlert_content()%></textarea>
									<br>
									<button class="ui olive right floated button" onclick="update_alert_one('<%=child.getChild_name()%>','<%=child.getParents_id()%>',<%=child.getChild_num()%>)">수정</button>
								</div>
							</div>
							<%
								} else {
							%>
							<div class="row">
								<div class="col-sm-3">
									<select class="custom-select custom-select-sm mb-3"
										id="alert_health<%=child.getChild_num()%>">
										<option selected>건강상태</option>
										<option value="health_good">건강상태 좋음</option>
										<option value="health_cautious">건강상태 주의</option>
										<option value="health_bad">건강상태 나쁨</option>
									</select> <select class="custom-select custom-select-sm mb-3"
										id="alert_tem<%=child.getChild_num()%>">
										<option selected>체온상태</option>
										<option value="tem_normal">체온 정상</option>
										<option value="tem_high">체온 높음</option>
										<option value="tem_low">체온 낮음</option>
									</select> <select class="custom-select custom-select-sm mb-3"
										id="alert_poo<%=child.getChild_num()%>">
										<option selected>배변상태</option>
										<option value="poo_ok">배변활동 정상</option>
										<option value="poo_not_ok">배변활동 비정상</option>
									</select> <select class="custom-select custom-select-sm mb-3"
										id="alert_sleep<%=child.getChild_num()%>">
										<option selected>수면여부</option>
										<option value="sleep_enough">수면시간 충분</option>
										<option value="sleep_not_enough">수면시간 불충분</option>
									</select> <select class="custom-select custom-select-sm mb-3"
										id="alert_food<%=child.getChild_num()%>">
										<option selected>식사여부</option>
										<option value="food_yes">식사함</option>
										<option value="food_no">식사안함</option>
									</select><br> <br>
								</div>
								<!-- col-sm-3 end -->
								<div class="col-sm-9">
									<textarea style="width: 100%; height: 200px;" id="one_content<%=child.getChild_num()%>"></textarea>
									<br>
									<button class="ui yellow right floated button" onclick="insert_alert_one('<%=child.getChild_name()%>','<%=child.getParents_id()%>',<%=child.getChild_num()%>)">등록</button>
								</div>
							</div>
							<%
								}
							%>
						</div>
					</div>
				</div>
				<!-- card end -->
			</div><!-- accordion end -->
		
				<table class="ui table table-borderless" style="width: 100%">
					<tr>
						<td class="main_alert" style="height: auto; table-layout: fixed;">
							<img class="img_kids" style="height: 150px; width: 150px;" src="/kindergarten/etc/image/child/<%=child.getChild_pic()%>">
						</td>
						<td class="main_alert" style="height: auto; width: 70%; table-layout: fixed;">
							<h5 class="name_alert"><%=child.getChild_name()%></h5> <h5><%=child.getParents_phone()%></h5><br>
						</td>
						<td class="main_alert" style="width: 15%">
								<table>
									<colgroup>
										<col width="40%">
										<col width="60%">
									</colgroup>
									<!-- attendance -->
									<%
										attend = dbPro.get_attendance_by_Child(child.getChild_num(), java.sql.Date.valueOf(today));
													if (attend != null) {
	
														if (attend.getAttendance_absence() == 0) {//결석 안했을 때
															String start_time = sf.format(attend.getAttendance_start_time());
									%>
									<tr id="start<%=child.getChild_num()%>">
										<td class='text-center' scope='col'>
											<button type='button' class='btn btn-warning'>
												등원<i class='fas fa-chevron-circle-down'></i>
											</button> <br> <small><%=start_time%></small>
										</td>
									</tr>
									<tr id="end<%=child.getChild_num()%>">
										<%
											if (attend.getAttendance_end_time() != null) {
																	String end_time = sf.format(attend.getAttendance_end_time());
										%>
										<td class='text-center' scope='col'>
											<button type='button' class='btn btn-warning'>
												하원<i class='fas fa-chevron-circle-down'></i>
											</button> <br> <small><%=end_time%></small>
										</td>
										<%
											} else {
										%>
										<td class="text-center" style="padding-left: 10px;">
											<button type="button" class="btn btn-light"
												onclick="insert_end_val('<%=child.getChild_name()%>', <%=child.getChild_num()%>)">하원</button>
										</td>
										<%
											}
										%>
									</tr>
									<tr id="absence<%=child.getChild_num()%>">
										<td class="text-center" style="padding-left: 8px;">
											<button type="button" class="btn btn-light"
												onclick="insert_absence('<%=child.getChild_name()%>', <%=child.getChild_num()%>)">결석등록</button>
										</td>
									</tr>
									<%
										} else if (attend.getAttendance_absence() == 1) { //결석상태일때
									%>
									<tr id="start<%=child.getChild_num()%>">
										<td class='text-center' style='padding-left: 10px;'>
											<button type='button' class='btn btn-light' readonly>등원x</button>
										</td>
									</tr>
									<tr id="end<%=child.getChild_num()%>">
										<td class='text-center' style='padding-left: 10px;'>
											<button type='button' class='btn btn-light' readonly>하원x</button>
										</td>
									</tr>
									<tr id="absence<%=child.getChild_num()%>">
										<td class='text-center' style='padding-left: 8px;'>
											<button type='button' class='btn btn-warning'
												onclick='delete_absence(<%=child.getChild_num()%>)'>
												결석 <i class='fas fa-chevron-circle-down'></i>
											</button>
										</td>
									</tr>
									<%
										}
													} else {
									%>
									<tr id="start<%=child.getChild_num()%>">
										<td class="text-center" style="padding-left: 10px;"><button
												type="button" class="btn btn-light"
												onclick="insert_start_val('<%=child.getChild_name()%>', <%=child.getChild_num()%>)">등원</button></td>
									</tr>
									<tr id="end<%=child.getChild_num()%>">
										<td class="text-center" style="padding-left: 10px;"><button
												type="button" class="btn btn-light"
												onclick="insert_end_val('<%=child.getChild_name()%>', <%=child.getChild_num()%>)">하원</button></td>
									</tr>
									<tr id="absence<%=child.getChild_num()%>">
										<td class="text-center" style="padding-left: 8px;"><button
												type="button" class="btn btn-light"
												onclick="insert_absence('<%=child.getChild_name()%>', <%=child.getChild_num()%>)">결석등록</button></td>
									</tr>
									<%
										}
									%>
								</table>
							</td>
						<tr>
							<td></td>
							<td colspan="2" class="main_alert" style="height: auto;">
								<h5 class="content_alert"><%=child.getChild_memo()%></h5>
								<pre></pre>
							</td>
						</tr>					
				</table><!-- table end -->
		</div>

		<%
			}
				}
		%>
	</div><!-- container -->

<!--footer-->
<jsp:include page="teacher_footer.inc.jsp" flush="false" />	

<!-- 여기부터 아래3개 datepicker(하단에 원래있던 jquery관련js지움) -->
<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script><!-- 반드시 윗줄->nav.js -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script src="https://unpkg.com/popper.js@1.12.6/dist/umd/popper.js"></script>
<script src="https://unpkg.com/bootstrap-material-design@4.1.1/dist/js/bootstrap-material-design.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js'></script>
<script>
		function insert_start_val(st,num){
			var real = confirm(st + "를 등원 처리 하시겠습니까?");
			if(real){
				to_ajax1(num);
			}
		}
		
		function to_ajax1(num){
		    var formdata = {
		    		child_num : num,
		    		start_or_end: 'start',
		    		today: '<%=today%>'
		    }
		    
		    $.ajax({     
		    	url:"teacher_attendance_check.jsp",
		        type:'get',
		        data: formdata,
		        dataType:'JSON',
		        success:function(data){
		        		var time = data.start_time.split(":");
						$("#start"+data.child_num).html("<td class='text-center' scope='col'><button type='button' class='btn btn-warning'>등원<i class='fas fa-chevron-circle-down'></i></button><br><small>"+time[0]+":"+time[1]+"</small></td>");
		          //$("#input_start").attr("value", data.start_time);
		        }
		    });
		    
		    
		}
   </script>

	<script>
		function insert_end_val(st,num){
			var real = confirm(st + "를 하원 처리 하시겠습니까?");
			if(real){
				to_ajax2(num);
			}
		}
		
		function to_ajax2(num){
		    var formdata = {
		    		child_num : num,
		    		start_or_end: 'end',
		    		today: '<%=today%>'
		    }
		    
		    $.ajax({
		    	url:"teacher_attendance_check.jsp",
		        type:'get',
		        data: formdata,
		        dataType:'JSON',
		        success:function(data){
		        	var time = data.end_time.split(":");
		        	$("#end"+data.child_num).html("<td class='text-center' scope='col'><button type='button' class='btn btn-warning'>하원<i class='fas fa-chevron-circle-down'></i></button><br><small>"+time[0]+":"+time[1]+"</small></td>");
		        	
		        	//$("tr #end"+this.child_num).html("<td class='text-center' scope='col'><small>"+time[0]+":"+time[1]+"</small></td><td scope='col'><button type='button'>하원</button></td>");
		        	//alert(data.end_time);
		        	//$.each(data, function(){
		        		//alert(data.end_time);
		        		//var time = this.end_time.split(":");
						//$("tr #end"+this.child_num).html("<td class='text-center' scope='col'><small>"+time[0]+":"+time[1]+"</small></td><td scope='col'><button type='button'>하원</button></td>");
					//});
		        }
		    });
		}
   </script>

	<script>
		function insert_absence(st,num){
			var real = confirm(st + "를 결석 처리 하시겠습니까?");
			if(real){
				to_ajax3(num);
			}
		}
		
		function to_ajax3(num){
		    var formdata = {
		    		child_num : num,
		    		start_or_end: 'absence',
		    		today: '<%=today%>'
		    }
		    
		    $.ajax({
		    	url:"teacher_attendance_check.jsp",
		        type:'get',
		        data: formdata,
		        dataType:'JSON',
		        success:function(data){
		      		if(data.result == '0'){
		      			$("#start"+data.child_num).html("<td class='text-center' style='padding-left:10px;'><button type='button' class='btn btn-light' readonly>등원x</button></td>");
		      			$("#end"+data.child_num).html("<td class='text-center' style='padding-left:10px;'><button type='button' class='btn btn-light' readonly>하원x</button></td>");
			        	$("#absence"+data.child_num).html("<td class='text-center' style='padding-left:8px;''><button type='button' class='btn btn-warning' onclick='delete_absence("+data.child_num+")'>결석 <i class='fas fa-chevron-circle-down'></i></button></td>");
		      		}else{
		      			alert("오류, 다시시도해주세요.");
		      		}
		        }
		    });  
		}
		
		function delete_absence(num){
			var real = confirm("결석을 취소하시겠습니까?");
			if(real){
				to_ajax4(num);
			}
		}
		
		function to_ajax4(num){
		    var formdata = {
		    		child_num : num,
		    		start_or_end: 'absence_del',
		    		today: '<%=today%>'
		    }
		    
		    $.ajax({
		    	url:"teacher_attendance_check.jsp",
		        type:'get',
		        data: formdata,
		        dataType:'JSON',
		        success:function(data){
		      			$("#start"+data.child_num).html("<td class='text-center' style='padding-left:10px;'><button type'button' class='btn btn-light' onclick='insert_start_val(\"" + data.child_name + "\",\"" + data.child_num + "\")'>등원</button></td>");
		      			$("#end"+data.child_num).html("<td class='text-center' style='padding-left:10px;'><button type'button' class='btn btn-light' onclick='insert_end_val(\"" + data.child_name + "\",\"" + data.child_num + "\")'>하원</button></td>");
			        	$("#absence"+data.child_num).html("<td class='text-center' style='padding-left:8px;'><button type='button' class='btn btn-light' onclick='insert_absence(\"" + data.child_name + "\",\"" + data.child_num + "\")'>결석등록</button></td>");
		        }
		    }); 
		}
		
		
		function insert_alert_all(){
			var real = confirm("전체알림장을 작성하시겠습니까?");
			if(real){
				//to_ajax5();
			//alert($("#al_content").val()+"sfs");
			//var content = $("#al_content").val();
				 var formdata = {
				    		teacher_id : '<%=id%>',
				    		all_content : $("#al_content").val(),
				    		all_or_one : 'all',
				    		crud : 'insert',
				    		today : '<%=today%>'
				    }
				 
				 $.ajax({
				    	url:"teacher_alert_pro1.jsp",
				        type:'get',
				        data: formdata,
				        dataType:'JSON',
				        success:function(data){
					           //alert(data.all_content);
				        	$("#div_all").html("<div class='form-group'><textarea class='form-control' id='al_content' rows='8' readonly>"+data.all_content+"</textarea></div><div class='text-right'><button type='button' class='btn btn-warning' onclick='update_alert_all(\""+data.all_content+"\")'>수정</button><button type='button' class='btn btn-light' onclick='delete_alert_all()'>삭제</button></div>");	
					    }
				    }); 
			}
		}
		
		function update_alert_all(str){
			//alert(str);
			$("#div_all").html("<div class='form-group'><textarea class='form-control' id='al_content' rows='8'>"+str+"</textarea></div><div class='text-right'><button type='button' class='btn btn-warning' onclick='to_ajax7()'>수정 등록</button><button type='button' class='btn btn-light' onclick='clear_alert_all()'>취소</button></div>");	
		}
		
		function to_ajax7(){
			//alert($("#all_content").val()+"sfs");
			//var content = $("#al_content").val();
			 var formdata = {
			    		teacher_id : '<%=id%>',
			    		all_content : $("#al_content").val(),
			    		all_or_one : 'all',
			    		crud: 'update',
			    		today : '<%=today%>'
			    }
			 
			 $.ajax({
			    	url:"teacher_alert_pro1.jsp",
			        type:'get',
			        data: formdata,
			        dataType:'JSON',
			        success:function(data){
				           //alert(data.a_content);
				           
			        	$("#div_all").html("<div class='form-group'><textarea class='form-control' id='al_content' rows='8' readonly>"+data.all_content+"</textarea></div><div class='text-right'><button type='button' class='btn btn-warning' onclick='update_alert_all(\""+data.all_content+"\")'>수정</button><button type='button' class='btn btn-light' onclick='delete_alert_all()'>삭제</button></div>");	
			    		
				    }
			    }); 
		}
	
		function delete_alert_all(){
			var real = confirm("전체알림장을 삭제하시겠습니까?");
			if(real){
				 var formdata = {
				    		teacher_id : '<%=id%>',
				    		today : '<%=today%>',
				    		all_or_one : 'all',
				    		crud: 'delete'
				    }
				 
				 $.ajax({
				    	url:"teacher_alert_pro1.jsp",
				        type:'get',
				        data: formdata,
				        dataType:'JSON',
				        success:function(data){
					           //alert(data.delete_result);
				        	$("#div_all").html("<div class='form-group'><textarea class='form-control' id='al_content' rows='8'></textarea></div><div class='text-right'><button type='button' class='btn btn-warning' onclick='insert_alert_all()'>등록</button></div>");	
				    		
					    }
				    }); 
			}
		}
		
		function insert_alert_one(st,parents,num){
			var real = confirm(st+"부모님에게 알림장을 작성하시겠습니까?");
			if(real){
				to_ajax6(parents,num);
			}
		}
		
		function to_ajax6(parents,num){
			 var formdata = {
			    		teacher_id : "<%=id%>",
			    		alert_content : $("#one_content"+num).val(),	
			    		alert_date : "<%=today%>",
			    		alert_health: $("#alert_health"+num).val(),	
			    		alert_tem: $("#alert_tem"+num).val(),	
			    		alert_poo: $("#alert_poo"+num).val(),	
			    		alert_sleep: $("#alert_sleep"+num).val(),	
			    		alert_food:$("#alert_food"+num).val(),	
			    		parents_id: parents,
			    		all_or_one : 'one'
			 }
			 
			 $.ajax({
			    	url:"teacher_alert_pro1.jsp",
			        type:'get',
			        data: formdata,
			        success:function(data){
				           //alert($("#one_content").val());
			        	//$("#div_all").html("<div class='form-group'><textarea class='form-control' id='al_content' rows='8' readonly>"+$("#all_content").val()+"</textarea></div><div class='text-right'><button type='button' class='btn btn-primary' onclick='update_alert_all("+$("#all_content").val()+")'>수정</button><button type='button' class='btn btn-light' onclick='delete_alert_all()'>삭제</button></div>");	
			    		alert("ok");
				        }
			    }); 
		}		
   </script>

	<script>
   function next_today(){
	   location.href='teacher_attend_alert.jsp?today=<%=today%>&move=front';
   }
   
   function back_today(){
	   location.href='teacher_attend_alert.jsp?today=<%=today%>&move=back';
   }
   </script>


</body>
</html>

<%}%>