<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="picture.ScheduleDAO" %>
<%@ page import="picture.ScheduleVO" %>
<%@ page import="java.util.List" %>
	
<% 	
	request.setCharacterEncoding("utf-8");
	java.text.SimpleDateFormat t_format = new java.text.SimpleDateFormat("kk:mm");
%>
	
<!DOCTYPE html>
<html>
<head>
<title>선생님 일정 관리</title>
<meta charset='utf-8' />
<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" /> 
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
<link rel="stylesheet" href="../../assets/Time-Selection-Popover-jQuery-Timepicker/dist/css/timepicker.css">
<link href="/kindergarten/etc/css/nav/nav.css" rel="stylesheet" type="text/css"> <!-- nav -->
<link href="/kindergarten/etc/css/parents/parents_default.css" rel="stylesheet" type="text/css"> <!-- html, body, footer-->	
</head>
<body>

<!-- menu -->
<jsp:include page="teacher_menu.inc.jsp" flush="false" />
	
<div class="container"  style="margin-top: 10%;">
	<div class="pricing-header pb-md-4 mx-auto text-center">
      	<h1 class="display-4">일정 관리</h1>
      	<p class="lead mt-3">아이들의 일정을 확인하고 관리할 수 있는 공간입니다.</p>
    </div> 		
	<!-- 반 일정 등록 폼  -->
		<form action="teacher_class_Schedule_Pro.jsp" class="ui form">
				<div class="field">
					<label for="inputAddress">일정 제목</label>
					<input type="text" class="form-control" name="schedule_title" id="schedule_title">
				</div>
				<div class="field">
					<label for="inputAddress2">일정 내용</label>
					<textarea class="form-control" rows="7" name="schedule_content" id="schedule_content"></textarea>
				</div>
				<div class="fields">
					<div class="six wide field">
						<label for="inputEmail4">날짜</label>
					    <input class="form-control" type="date" name="schedule_date" id="schedule_date" placeholder="날짜">
					</div>
					<div class="six wide field">
						<label for="inputEmail4">시작 시간</label>
					    <input type="text" class="form-control" name="schedule_start_time" id="schedule_start_time" placeholder="시작 시간">
					</div>
					<div class="six wide field">
					    <label for="inputPassword4">종료 시간</label>
					    <input type="text" class="form-control" name="schedule_end_time" id="schedule_end_time" placeholder="종료 시간">
					</div>
				</div>
				<div class="fields">
					<div class="five wide field">
						<label for="inputState">반 명</label>
					    <select id="inputState" class="form-control" name="class_name" id="class_name">
					      	<option value="A" selected value="a">A</option>
					        <option value="기린반">기린반</option>
					        <option value="햇님반">햇님반</option>
					        <option value="토끼반">토끼반</option>
					    </select>
					</div>
					<div class="six wide field">
						<label for="inputZip">작성자</label>
						<input type="text" class="form-control" name="writer" id="writer" value="A반교사">
					</div>
					<!-- 버튼 일정 등록  -> ajax써서!-->
					<div class="five wide field ui buttons" style="height:15%; margin-top:2%">
						<button type="submit" class="ui yellow basic button" id="submit_button">등록</button>
						<button type="reset" class="ui grey basic button">취소</button>
					</div>
			</div>
  		</form>
		<!-- 테이블에 표시 -->
		<div style="margin-top:5%;">
<% 
	ScheduleVO schedule = null;
	ScheduleDAO dbPro = ScheduleDAO.getInstance();
	List<ScheduleVO> scheduleList = dbPro.get_schedule_group();
			
	if(scheduleList != null){
		for(int i=0; i<scheduleList.size(); i++){
			schedule = scheduleList.get(i);
%>
			<table class="table">
				<colgroup>
			  		<col width="15%">
			  		<col width="25%">
			  		<col width="*">
			  		<col width="6%">
			  		<col width="10%">
			  		<col width="5%">
			  		<col width="5%">
			  	</colgroup>
				<thead class="thead-light">
					<tr>
						<th class="text-right" colspan="7"><%= schedule.getSchedule_date() %></th>
					</tr>
				</thead>
				<tbody>
<% 
	//같은 날짜끼리 넣기
	ScheduleVO one_schedule = null;
	List<ScheduleVO> oneByone_schedule = dbPro.get_TodaySchedule(schedule.getSchedule_date());
						  
	if(oneByone_schedule.size() > 0){
		for(int j=0; j<oneByone_schedule.size(); j++){
			one_schedule = oneByone_schedule.get(j);
			String start = t_format.format(one_schedule.getSchedule_start_time());
			String end = t_format.format(one_schedule.getSchedule_end_time());
%>
				 	<tr>
						<td scope="col"><%= start %> - <%= end %></th>
						<td scope="col"><%= one_schedule.getSchedule_title() %></td>
						<td scope="col"><%= one_schedule.getSchedule_content() %></td>
						<td scope="col"><%= one_schedule.getClass_name() %></td>
						<td scope="col"><%= one_schedule.getWriter() %></td>
						<td scope="col"><button type="button" class="btn btn-warning">수정</button></td>
						<td scope="col"><button type="button" class="btn btn-light" id="deleteOne" onclick="deleteschedule(<%= one_schedule.getSchedule_num()%>)">삭제</button></td>
					</tr>
<% }}%>
				</tbody>
			</table>
<%}}else{%>
			<table class="table">
				<colgroup>
			  		<col width="15%">
			  		<col width="25%">
			  		<col width="*">
			  		<col width="6%">
			  		<col width="10%">
			  		<col width="5%">
			  		<col width="5%">
			  	</colgroup>
				<tr>
					<td scope="col">리스트</td>
				</tr>
			</table>
<%}%>
		</div>
</div>

<!--footer-->
<jsp:include page="teacher_footer.inc.jsp" flush="false" />	

<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script> <!-- 반드시 윗줄->nav.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src='../../assets/fullcalendar-3.9.0/lib/jquery.min.js'></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
	function deleteschedule(oneSchedule){
		if (confirm("일정을 정말 삭제하시겠습니까?")) {
			$(document).ready(function(){
				$.ajax({ 
					type: "post",
		            url: "teacher_delete_Schedule_Pro.jsp",
		            data: {oneSchedule : oneSchedule},
		            success: function(result){
		            location.href="teacher_schedule_Form.jsp"
				}
		     });
		});
	}else{
		    	alert("noo");
		    }
	}

		$("#submit_button").on("click",function() {
		    var action = $('form').attr("action");
		    var form_data = {
 	     	        class_name : $("#class_name").val(),
 	     	        schedule_date : $("#schedule_date").val(),
 	     	        schedule_start_time : $("#schedule_start_time").val(),
 	     	        schedule_end_time : $("#schedule_end_time").val(),
 	     	        schedule_title : $("#schedule_title").val(),
 	     	        schedule_content : $("#schedule_content").val(),
 	     	        writer :  $("#writer").val()
		    };
		    
	        $.ajax({
                type: "get",
                url: action,
                data: form_data
     		 });
	        //alert(this.value);
		});

	
	</script>
	
	<!-- timepicker -->	
	<script src="../../assets/Time-Selection-Popover-jQuery-Timepicker/dist/js/timepicker.js"></script>
	<script>
		$('#schedule_start_time').timepicker();
		$('#schedule_end_time').timepicker();
	</script>

</body>
</html>
