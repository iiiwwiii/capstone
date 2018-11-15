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
			<h3 class="ui header"><i class="user circle outline icon"></i><%=id%></h3>
		</header>
		
		<div class="ui three column grid">
			<div class="equal height column">
				<div class="ui fluid card">
					<div class="content">
						<div class="center aligned header">학부모 회원수</div>
						<div class="center aligned description pt-4">
							<h2 class="ui header">78명</h2>
						</div>
					</div>
				</div>
			</div>
			
			<div class="column">
				<div class="ui fluid card" style="height:100px;">
					<div class="content">
						<div class="center aligned header pt-2"><h1 class="ui header">출석부</h1></div>
					</div>
						<a class="ui basic button" href="/kindergarten/jsp/teacher/teacher_attend_alert.jsp">
							<i class="icon user"></i> 출석부 바로가기
						</a>
				</div>
			</div>
			
			<div class="column">
				<div class="ui fluid card">
					<div class="content">
						<div class="center aligned header">새로 가입한 학부모 회원</div>
						<div class="center aligned description pt-4">
							<h2 class="ui header">3명</h2>
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
			
			<div class="eleven wide column">
				<h3 class="ui header">From 학부모</h3>
				<table class="ui selectable celled table">
					<colgroup>
						<col width="20%">
						<col width="20%">
						<col width="20%">
					</colgroup>
					<tr>
						<td>애기2</td>
						<td>지각</td>
						<td><i>10 mins</i></td>
					</tr>
					<tr>
						<td>애기1</td>
						<td>늦잠</td>
						<td><i>15 mins</i></td>
					</tr>
					<tr>
						<td>애기10</td>
						<td>몸살감기</td>
						<td><i>17 mins</i></td>
					</tr>
					<tr>
						<td>애기11</td>
						<td>지각</td>
						<td><i>25 mins</i></td>
					</tr>
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
			<div class="form-group">
				<textarea class="form-control" id="exampleFormControlTextarea1" rows="6"></textarea>
			</div>
			<button type="button" class="ui blue basic right floated button">등록</button>
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

</body>
</html>

<%
	}
%>