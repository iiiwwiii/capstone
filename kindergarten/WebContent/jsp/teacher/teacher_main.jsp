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
<%@ page import ="user.teacher.TeacherDAO" %>
<%@ page import ="user.teacher.TeacherVO" %>

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
		List<TeacherVO> TeacherList = null;
		TeacherDAO dao = TeacherDAO.getInstance();	
		ChildVO child = null;
		List<AttendanceVO> attendList = null;
		AttendanceVO attend = null;
%>

<!DOCTYPE html>
<html>
<title>선생님 메인</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
<link href="/kindergarten/etc/css/nav/nav.css" rel="stylesheet" type="text/css"> <!-- nav -->
<body>

<!-- menu -->
<jsp:include page="teacher_menu.inc.jsp" flush="false" />

	<div class="container" style="margin-top:7%;">
		<header class="container" style="padding-bottom:2%">
			<div class="row"><h3 class="ui header"><i class="user circle outline icon"></i><%=id%>님 </h3>오늘은 <%= today %> 입니다</div>
			 
		</header>
		
		<div class="ui three column grid">
			<div class="equal height column">
				<div class="ui fluid card">
					<div class="content">
						<div class="center aligned header"><i class="far fa-bell"></i> From 학부모</div>
						<div class="center aligned description pt-4">
							<h2 class="ui header"><sup class="w3-text-orange">new</sup>3개</h2>
						</div>
					</div>
				</div>
			</div>
			
			<div class="equal height column">
				<div class="ui fluid card">
					<div class="content">
						<div class="center aligned header">오늘의 출석</div>
						<div class="center aligned description pt-4">
							<h2 class="ui header">24명 /25명</h2>
						</div>
					</div>
				</div>
			</div>
			
			<div class="equal height column">
				<div class="ui fluid card">
					<div class="content" onclick="location.href='teacher_user_list.jsp'">
						<div class="center aligned header">미인증 회원</div>
						<div class="center aligned description pt-4">
							<h2 class="ui header"><sup class="w3-text-orange">new</sup>3명</h2>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="ui grid">
			<div class="five wide column">
				<h3 class="ui header w3-bottombar w3-border-orange" style="margin-bottom: 10px; padding-bottom: 10px;">오늘 일정</h3>
				<%
					ScheduleDAO s_dbPro = ScheduleDAO.getInstance();
						ScheduleVO schedule = null;
						java.text.SimpleDateFormat t_format = new java.text.SimpleDateFormat("kk:mm");
						List<ScheduleVO> scheduleList = s_dbPro.get_TodaySchedule(java.sql.Date.valueOf(today));

						if (scheduleList != null) {
							for (int i = 0; i < scheduleList.size(); i++) {
								schedule = scheduleList.get(i);
								String start = t_format.format(schedule.getSchedule_start_time());
								String end = t_format.format(schedule.getSchedule_end_time());
				%>
				<div class="row">
					<div class="col-sm-5"><%=start%>-<%=end%></div>
					<div class="col-sm-7"><%=schedule.getSchedule_title()%></div>
				</div>
				<%
					}
						} else {
				%>
				<p>일정이 없습니다.</p>
				<%
					}
				%>

			</div>
			
			<div class="eleven wide column" onclick="location.href='teacher_from_parents.jsp'">
				<h3 class="ui header">From 학부모</h3>
				<table class="ui selectable celled table">
					<colgroup>
						<col width="15%">
						<col width="20%">
						<col width="*">
					</colgroup>
					<tr class="text-center">
						<td>구분</td>
						<td>원아이름</td>
						<td>사유</td>
					</tr>
					
					<% 
					List<To_teacherVO> to_teacherList = dbPro.get_to_teacher_by_teacher(id);
					String absence = null;
					To_teacherVO to_teacher = null;
					if(to_teacherList != null){
						if(to_teacherList.size() > 3){
							for(int i=0; i<3; i++){
								to_teacher = to_teacherList.get(i);
								if(to_teacher.getAbsence() == 1){
									absence = "결석";
								}else if(to_teacher.getAbsence() == 2){
									absence = "요청";
								}else if(to_teacher.getAbsence() == 3){
									absence = "지각";
								}
								
						%>	
						<tr class="text-center">
							<td><i><%= absence%></i></td>
							<td><%= to_teacher.getParents_id()%></td>
							<td><i><%= to_teacher.getTo_content()%></i></td>
						</tr>
						<% 
							}
						%>
						<%
						}else{
							for(int i=0; i<to_teacherList.size(); i++){
								to_teacher = to_teacherList.get(i);
								if(to_teacher.getAbsence() == 1){
									absence = "결석";
								}else if(to_teacher.getAbsence() == 2){
									absence = "요청";
								}else if(to_teacher.getAbsence() == 3){
									absence = "지각";
								}
								
						%>	
						<tr class="text-center">
							<td><i><%= absence%></i></td>
							<td><%= to_teacher.getParents_id()%></td>
							<td><i><%= to_teacher.getTo_content()%></i></td>
						</tr>
						<% 
							}
						}

					}else{
					%>
					<tr>
						<td class="text-center">내용이 없습니다.</td>
					</tr>
					<%
					}
					%>

					<tr>
						<td colspan="4" class="text-right">
							<i class="fas fa-caret-right"></i><a>더보기</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<hr>
		
		<div class="container">
			<h5>전체 알림장</h5>
			<div id="div_all">
				<div class="form-group">
					<textarea class="form-control" id="al_content" rows="6"></textarea>
				</div>
				<button type="button" class="ui blue basic right floated button" onclick="insert_alert_all()">등록</button>
			</div>

		</div>
	</div>

<!--footer-->
<jsp:include page="teacher_footer.inc.jsp" flush="false" />	

	<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script><!-- 반드시 윗줄->nav.js -->
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
	<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>	
	<script src="https://unpkg.com/popper.js@1.12.6/dist/umd/popper.js"></script>
	<script src="https://unpkg.com/bootstrap-material-design@4.1.1/dist/js/bootstrap-material-design.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
	<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js'></script>
	
	<script>
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
			        	$("#div_all").html("<div class='form-group'><textarea class='form-control' id='al_content' rows='6' readonly>"
						+data.all_content+
						"</textarea></div><button type='button' class='ui blue basic right floated button' onclick='update_alert_all("+date.all_content+")'>수정</button>");
				    }
			    }); 
		}
	}
	
	function update_alert_all(str){
		//alert(str);
    	$("#div_all").html("<div class='form-group'><textarea class='form-control' id='al_content' rows='6'>"
				+str+
				"</textarea></div><button type='button' class='ui blue basic right floated button' onclick='to_ajax7()'>수정등록</button>");
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
			           
		        	$("#div_all").html("<div class='form-group'><textarea class='form-control' id='al_content' rows='6' readonly>"
							+data.all_content+
							"</textarea></div><button type='button' class='ui blue basic right floated button' onclick='update_alert_all()'>수정</button>");
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
	</script>

</body>
</html>

<%
	}
%>