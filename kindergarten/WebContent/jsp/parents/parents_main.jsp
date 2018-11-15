<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "java.util.Date"%>
<%@ page import = "java.util.Calendar"%>
<%@ page import = "user.parents.ParentsDAO"%> 
<%@ page import = "user.parents.ParentsVO"%> 
<%@ page import = "user.teacher.TeacherFoodVO" %>
<%@ page import = "user.child.ChildVO"%>
<%@ page import = "user.teacher.TeacherNoticeVO"%> 
<%@ page import = "user.teacher.TeacherCalendarVO"%>
<%@ page import = "picture.ScheduleVO" %>
<%@ page import = "picture.ImageVO"%>
<%@ page import = "attend.AttendanceVO" %>
<%@ page import = "attend.AttendanceDAO"%>
 
<%!
	Date today = new Date(); 
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat tdf = new SimpleDateFormat("HH:mm");	
%>
<%
	//date
	Calendar cal = Calendar.getInstance();
	String rYear = request.getParameter("year"); //처음에 널이야 	
	String rMonth = request.getParameter("month");
	String rDate = request.getParameter("date"); 
	
	int year = cal.get(Calendar.YEAR); //처음 세팅해줌 
	int month = cal.get(Calendar.MONTH);
	int date = cal.get(Calendar.DATE);
	
	if(rYear != null) //넘어오는게 널이 아니면 넣어라. 
	{
		year = Integer.parseInt(rYear); //처음에 널이면 여기 안와 위에서 처음에 넣어줘 
		month = Integer.parseInt(rMonth); 
		date = Integer.parseInt(rDate); 	
	}else{}	 
	
	cal.set(year, month, date);
	int startDay = cal.getMinimum(java.util.Calendar.DATE); //그 달의 첫 날 
	int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); // 그 달의 마지막 날 

	
	if(date < startDay){
		month = month-1;			
		date = endDay; //전 달의 마지막 날이 안잡힘 ㅠㅠㅠ 0으로 나옴	
	}
	
	if(date > endDay){
		month = month + 1;
		date = startDay;  //시작날도 안잡힘 1이고뭐고 안뜨고 걍 2로 넘어감 		
		// url에 2018-9-32 라 뜨면 화면에는 2018-11-1이라 뜸 . 뭐냐 .. startDay, endDay는 잘 바뀜 화면에서 1될때.. 		
	}
		
	//parents session 
	String id = null;
	if(session.getAttribute("id")==null){		
		response.sendRedirect("/kindergarten/jsp/first/first_main.jsp");
	}else  if(session.getAttribute("id")!=null){
		id = (String)session.getAttribute("id");
	
	
	//parents - child pic+name
	ParentsDAO parentsdao = ParentsDAO.getInstance();
	ChildVO childpicname = parentsdao.parentsChildName(id);  
	
	int childnum = childpicname.getChild_num();
	//main-notice
 	List<TeacherNoticeVO> noticevo = parentsdao.parentsMainNotice(); 
	
	
	//today food 
	//AdminDAO admindao = AdminDAO.getInstance(); 
	List<TeacherFoodVO> dayfoodlist = null;
	int dayfoodmenucount = 0; 
	String dayfoodimage = "없음"; 
	
	String foody = Integer.toString(year); //2018
	String foodm = Integer.toString(month+1); //10월이면 9라뜸 +1
	String foodd = Integer.toString(date); //일 
	
	
	if(foodd.length()==1){
		foodd = "0" + foodd;  //1일이면 01로 
	}
	
	String resulttoday = foody+foodm+foodd;
	String rretoday = foody+"-"+foodm+"-"+foodd;
	//foody+foodm+foodd -> 2018-10-31 날짜 잘 바뀜. 메서드에 집어넣으면 될듯.  
	dayfoodmenucount = parentsdao.parentsTodayMenuCount(resulttoday);   //null check - > 잘 나옴. 10-31기준 6이라 나옴 찍어봄
	
	if(dayfoodmenucount != 0){
		dayfoodlist = parentsdao.parentsTodayMenu(resulttoday);
		dayfoodimage = parentsdao.parentsTodayMenuImage(resulttoday); 
	}
	
	//today schedule - 시간표 
	List<ScheduleVO> schedulelist = null;
	int schedulecount = 0;
	String ban = "A"; //일단 다 A반 기준  
	 
	schedulecount = parentsdao.parentsClassScheduleCount(ban, resulttoday); 
	
	if(schedulecount !=0) { 
		schedulelist = parentsdao.parentsClassScheduleList(ban, resulttoday); 
	}	 
	
	//Today Gallery 
	List<ImageVO> gallerylist = null;
	int gallerycount = 0;
	
	gallerycount = parentsdao.parentstodaygalleryCount(ban, resulttoday);  
	
	if(gallerycount != 0){
		gallerylist = parentsdao.parentstodaygallerylist(ban, resulttoday); 
	} 
	
	//월간일정 - 일단 날짜잡아서 뿌림 -> list, < > ajax는 나중에
	List<TeacherCalendarVO> calendarlist = null; 
	int calendarcount = 0;
	
	//일정 시작일 기준  
	calendarcount = parentsdao.parentscalendarcount(foodm); //월만 잡아넘김  2018-11 check 
	
	if(calendarcount != 0){
		calendarlist = parentsdao.parentscalendarlist(foodm); 
	}  
	   
	//ATTENDANCE
	AttendanceVO attvo = null; 

		attvo = parentsdao.childtodayattence(rretoday, childnum);   
	
%>
	 
<!doctype html> 
<html lang="ko">
<title>학부모 메인</title>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> 
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" >
<link rel="stylesheet" href="/kindergarten/etc/css/parents/parents_main.css"> <!-- parents_main css -->	
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"> <!-- 여기부터 아래3개 datepicker(하단에 원래있던 jquery관련js지움) -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<script>
//?year=2018&month=9&date=32				
	$(function () {
		$("#datepickerr").datepicker({dateFormat:'yy-mm-dd'});
	});
	
	$(function(){

	    $("#date3").datepicker({
	    	dateFormat:'yy-mm-dd', //2018-10-10 
	        onSelect:function(dateText, inst) {
	            console.log(dateText); //f12 - console -> 2018-10-10          
	        }
	    	
	    	//datepicker - main z-index 뒤에 가려짐 -> 나중에 처리하기 
	    	//beforeShow:function() {
	    	//	setTimeout(function(){
	        //            $('.ui-datepicker').css('z-index', 9999);
	        //    }, 0);
	    	//}
	    });

	});
</script>
</head>	
<body class="profile-page">

<!-- menu -->
<jsp:include page="parents_menu.inc.jsp" flush="false" />
	
<!--page-header-->
	<div class="page-header header-filter" data-parallax="true"> 
		<div class="container">
			<div class="row justify-content-center ">
				<span class="calendar">				
					 <a href="./parents_main.jsp?year=<%=year%>&amp;month=<%=month%>&amp;date=<%=date-1 %>" style="font-size:30px;">&lt;</a>									
					 &nbsp;
					 <%=year%>-<%=month+1%>-<%=date %><input type="hidden" name="date" id="date3" size="12" />
					<a onclick="$('#date3').datepicker('show');"><i class="far fa-calendar-alt" style="font-size:30px;"></i></a>				
					 &nbsp; 
					 <a href="./parents_main.jsp?year=<%=year%>&amp;month=<%=month%>&amp;date=<%=date+1 %>" style="font-size:30px;">&gt;</a>		
					 
				</span>
			</div>
		</div>
	</div>
	
	<div class="container main main-raised">
		<div class="profile-content">
			<div class="container">
				<div class="row">
					<div class="col-md-6 ml-auto mr-auto">
						<div class="profile">
							<div class="avatar">
								<img src="/kindergarten/etc/image/child/<%=childpicname.getChild_pic()%>" alt="Circle Image" class="img-raised rounded-circle img-fluid">
							</div>
							<div class="name">
								<h4><%=childpicname.getChild_name() %></h4>		
							</div>
							<!-- name end -->
						</div>
						<!-- profile end -->
					</div>
					<!--col-md-6 end-->
				</div>
				<!-- row end -->
			</div>
			<!-- container -->
		</div>
		<!-- profile-content end -->

		<div class="container container_main">
			<div class="row">
				<div class="col-sm-3">
					<div class="card card_1">
						<div class="card-body ">
							<div class="row">
								<div class="col-sm-12 title">출결</div> 
							</div>
							
							<div class="row justify-content-center">
								<div class="col-sm-5 align-middle content to_0_1">
									<div class="circle1" style="padding-top: 31%; margin-left:1vw; font-size: 16px; color:white; background: red;">결석</div>
								</div>
								<div class="col-sm-7 align-let to to_0_2">
									<span class="to_1" style="margin-left:1vw;"> 등원&nbsp; &nbsp; - </span>
									<p> 
									<span class="to_1" style="margin-left:1vw;"> 하원&nbsp;&nbsp;  - </span>
								</div>
							</div>
							
						</div>
					</div>
				</div>

				<div class="col-sm-6">
					<div class="card card_1">
						<div class="card-body">
							<div class="row">
								<div class="col-sm-12 title">시간표</div> <!-- schedulelist -->
							</div>		
											
								<%
									if(schedulecount != 0){ //위에서 리스트 메서드 돌릴때 체크해줬찌만 또 돌려줘야됨. 에러남 
										for(int ii=0; ii<schedulelist.size(); ii++){
											ScheduleVO schedule = schedulelist.get(ii);	 
								%>
											<div class="row justify-content-center content" style="padding:2px;"> 
												<div class="col-sm-4">
													<%=tdf.format(schedule.getSchedule_start_time()) %> ~ <%=tdf.format(schedule.getSchedule_end_time()) %>													
												</div>
												<div class="col-sm-8">
												&emsp; <%=schedule.getSchedule_title()%>
												</div>
											</div>											
								<% 
										}
									}else if(schedulecount == 0){
										out.println("등록된 시간표가 없습니다.");
									}
								
								%>
					
						</div>
					</div>
				</div>

				<div class="col-sm-3">
					<div class="card card_1">
						<div class="card-body">
							<div class="row justify-content-center">
							 <% if(dayfoodmenucount != 0){%>
							 	<img src="/kindergarten/etc/image/teacher/<%= dayfoodimage%>" style="width: 80%; height: 110px;"></img>
							<% }else if(dayfoodmenucount ==0){%>
								<img src="/kindergarten/etc/image/teacher/food_default.PNG" style="width: 80%; height: 110px;"></img>
							<% }%>
								
							</div>
							<div class="row justify-content-center content">
								<div class="col-sm-12" style="font-size:12px; margin-top:8px;">
									<%
									if(dayfoodmenucount != 0){ //위에서 리스트 메서드 돌릴때 체크해줬찌만 또 돌려줘야됨. 에러남 
										for(int ii=0; ii<dayfoodlist.size(); ii++){
											TeacherFoodVO menu = dayfoodlist.get(ii);	 
											out.println(menu.getMenu_name());
											out.println(" ");
										}
									}else if(dayfoodmenucount == 0){
										out.println("등록된 메뉴가 없습니다.");
									}
									
									%>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-sm-9">
					<div class="card card_2 ">
						<div class="card-body">
							<div class="row">
								<div class="col-sm-12 title">알림장</div>
							</div>
							<div class="row">
								<div class="col-sm-12 content">
									<span style="font-weight: bold;">- 원에서 가정으로 </span>
									<p>소정이 어머님, 안녕하세요. 하루가 다르게 날씨가 추워지네요. 곧 추운 겨울이 올 것 같아요. 그런데
										지난 주부터 놀이 중 소정이가 목과 얼굴 주변을 긁는 모습이 자주 관찰되네요. 원에 보관하고 있는 보습제를
										충분히 발라주자 조금은 진정이 되었답니다. 가정에서도 간지러워 하며 자주 긁는지 궁금하네요. 혹시 소정이가
										아토피성 피부가 아닐까 생각해 봅니다. 더 악화되기 전에 병원에서 처방을 받으면 어떨까요? 
								</div>
							</div>
							<div class="row justify-content-center"> 
								<div class="col-sm-2" style="font-size:12px;"><img src="/kindergarten/etc/image/parents/icon/love.png" style="width:24px;"> 건강상태좋음</div>
								&emsp;&emsp;
								<div class="col-sm-2" style="font-size:12px;"><img src="/kindergarten/etc/image/parents/icon/thermometer.png" style="width:24px;"> 체온정상</div>
								&emsp;&emsp;
								<div class="col-sm-2" style="font-size:12px;"><img src="/kindergarten/etc/image/parents/icon/poop.png" style="width:24px;"> 배변활동정상</div>
								&emsp;&emsp;
								<div class="col-sm-2" style="font-size:12px;"><img src="/kindergarten/etc/image/parents/icon/night.png" style="width:24px;"> 1시간수면</div>
								&emsp;&emsp;
								<div class="col-sm-2" style="font-size:12px;"><img src="/kindergarten/etc/image/parents/icon/rice.png" style="width:24px;"> 식사함</div>
								&emsp;&emsp;
							</div>
			
						</div>
					</div>
				</div>

				<div class="col-sm-3">
					<div class="card card_2 ">
						<div class="card-body">
							<div class="row card_menu1">
								<div class="col-sm-12 title">메세지</div>
							</div>
							<div class="row justify-content-center">
								<div class="col-sm-12">
									<textarea wrap="hard" style="width: 100%; height: 200%; border: 1px solid #c6e0de;"></textarea>
								</div>
							</div>
							<br><br><br>
							<div class="row justify-content-center">
								<div class="col-sm-12">
								    <button type="button" class="btn btn-warning btn-sm btn-block">SEND</button>
								</div> 
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- end row -->

			<div class="row">
				<div class="col-sm-7">
					<div class="card card_1">
						<div class="card-body">
							<div class="row">
								<div class="col-sm-12 title" style="margin-bottom:5px;">공지사항</div>								
							</div>					
								<%  
									for (int i = 0 ; i < noticevo.size(); i++) {	
										
										TeacherNoticeVO mainnotice = noticevo.get(i);	
								%>
								<div class="row content" style="padding:2px;">
								<div class="col-sm-9"><a href="parents_notice_layout.jsp?num=<%=mainnotice.getNotice_num()%>"><%=mainnotice.getNotice_title() %></a></div>
								<div class="col-sm-3" style="text-align:right;"><%=sdf.format(mainnotice.getNotice_date()) %></div>
								</div>
								 
								<%} %>
						</div>
					</div>
				</div>

				<div class="col-sm-5">
					<div class="card card_1">
						<div class="card-body">
							<div class="row">
								<div class="col-sm-12 title" style="margin-bottom:5px;">월간일정</div>
							</div>
							<div class="row justify-content-center">
								<div class="row justify-content-center">
									<span class="glyphicon glyphicon-circle-arrow-left" aria-hidden="true"></span>
									<div style="font-size: 17px">&#60; &nbsp; <%=foody %>.<%=foodm %> &nbsp; &#62;</div> 
								</div>
							</div>
							<br>
						<%
									if(calendarcount != 0){ //위에서 리스트 메서드 돌릴때 체크해줬찌만 또 돌려줘야됨. 에러남 
										for(int ii=0; ii<calendarlist.size(); ii++){
											TeacherCalendarVO calen = calendarlist.get(ii);	 
								%>		
								<div class="row content"  style="padding:2px;">
									<div class="col-sm-1"></div>
									<div class="col-sm-7"><%=calen.getCalendar_start_date()%> ~ <%=calen.getCalendar_end_date()%> </div>
									<div class="col-sm-3"><%=calen.getCalendar_title()%></div>		
									<div class="col-sm-1"></div>										
								</div>									
								<% 
										}
									}else if(calendarcount == 0){
										out.println("등록된 일정이 없습니다.");
									}
								
								%>
							
						</div>
					</div>
				</div>
			</div>
			<!-- end row -->

			<div class="row">
				<div class="col-sm-12" style="font-size: 20px; font-weight: bord; color: #c99900;">
					<br>&nbsp;&nbsp;Today Gallery
				</div>
			</div>
			
			<%
					if(gallerycount != 0){%>
						<div class="row">
			<%  
						for(int ii=0; ii<gallerylist.size(); ii++){
							ImageVO img = gallerylist.get(ii);	  
											
			%>
						<!-- 0일때 열고 0 1 2 3 3에 닫히고 다시 4 에서 열고 4 5 6 7 7에서 닫히고  -->									
						<div class="col-sm-4">
							<div class="card_3">
							    <div class="card-body">
									<img src="/kindergarten/etc/image/teacher/<%= img.getImage_name()%>"  style="width:100%; height:200px;"></img>												
								</div>
							</div>
						</div>  
							         	
			<% 															
					}
				}else if(gallerycount == 0){%>
										
						<div class="alert alert-warning" role="alert" style="margin-top:20px;"> 등록된 사진이 없습니다.</div><br><br>
			<%}%>			
						</div>
		</div><!-- container end -->
	</div><!-- container main end -->
	
	<jsp:include page="parents_footer.inc.jsp" flush="false" />

	<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script> <!-- 반드시 윗줄->nav.js -->
	<script src="https://unpkg.com/popper.js@1.12.6/dist/umd/popper.js"></script>
	<script src="https://unpkg.com/bootstrap-material-design@4.1.1/dist/js/bootstrap-material-design.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
	<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
</body>
</html>
<%}//session%>