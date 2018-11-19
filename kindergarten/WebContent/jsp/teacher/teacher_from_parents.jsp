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
<link rel="stylesheet" type="text/css" href="semantic.min.css">
<link rel="stylesheet" type="text/css" href="accordion.min.css">
<script
  src="https://code.jquery.com/jquery-3.1.1.min.js"
  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
  crossorigin="anonymous"></script>
<script src="semantic.min.js"></script>
<script src="accordion.min.js"></script>
<body>

<!-- menu -->
<jsp:include page="teacher_menu.inc.jsp" flush="false" />

	<div class="container" style="margin-top:10%;">
	<div class="pricing-header pb-md-4 mx-auto text-center">
      	
      	<p class="lead mt-3">학부모로부터 온 메세지/지각/결석/요청사항을 확인할 수 있고 소통할 수 있습니다.</p>
    </div>
    </div>
	
	<div class="container">
	<div class="row"  style="margin-top:5%">
		<div class="col-md-5">
		
		
		 <h3 class="ui dividing header">새로운 메세지</h3>
		<div class="ui feed">
		  <div class="event">
		    <div class="label">
		      <img src="images/avatar/nan.jpg">
		    </div>
		    <div class="content">
		      <div class="summary">
		        <a class="user">
		          parents2
		        </a> 님이 지각요청을 하였습니다.
		        <div class="date">
		          1 Hour Ago
		        </div>
		      </div>
		      <div class="meta">
		        <a class="like">
		          <b class="text-dark"><i class="fas fa-check w3-text-orange"></i> 확인완료</b>
		        </a>
		      </div>
		    </div>
		  </div>
		  <div class="event">
		    <div class="label">
		      <img src="images/avatar/nan.jpg">
		    </div>
		    <div class="content">
		      <div class="summary">
		        <a>윌리엄</a> 님이 요청을 하였습니다.
		        <div class="date">
		          4 days ago
		        </div>
		      </div>
		      <div class="meta">
		        <a class="like">
		          <i class="fas fa-arrow-right"></i> 확인해주세요
		        </a>
		      </div>
		    </div>
		  </div>
		  <div class="event">
		    <div class="label">
		      <img src="images/avatar/nan.jpg">
		    </div>
		    <div class="content">
		      <div class="summary">
		        <a class="user">
		          박나은
		        </a> 님이 결석 요청을 하였습니다.
		        <div class="date">
		          2 Days Ago
		        </div>
		      </div>
		      <div class="meta">
		        <a class="like">
		          <i class="fas fa-arrow-right"></i> 확인해주세요
		        </a>
		      </div>
		    </div>
		  </div>
		  <div class="event">
		    <div class="label">
		      <img src="images/avatar/nan.jpg">
		    </div>
		    <div class="content">
		      <div class="summary">
		        <a>벤틀리</a> 님이 메세지를 보냈습니다.
		        <div class="date">
		          3 days ago
		        </div>
		      </div>
		      <div class="extra text">
		       선생님 안녕하세요! 벤틀리엄마에요. 요즘 벤틀리 신경많이써주셔서 너무 감사드려요
		      </div>
		      <div class="meta">
		        <a class="like">
		          <i class="fas fa-arrow-right"></i> 확인해주세요
		        </a>
		      </div>
		    </div>
		  </div>
		</div>
		
		
		
		
		</div>
		
	  	
		<div class="col-md-7">
		
		
		<div class="w3-card" style="padding:30px;">
		
		<div class="ui fluid category search text-right">
		  <div class="ui icon input">
		    <input class="prompt" type="text" placeholder="학부모 검색">
		    <i class="search icon"></i>
		  </div>
		  <div class="results"></div>
		</div>
		
		<div class="ui small comments" style="/*overflow:auto; height: 600px; width:auto;*/">
			  <div class="comment">
			    <a class="avatar">
			      <img src="images/avatar/nan.jpg">
			    </a>
			    <div class="content">
			      <a class="author">Matt</a>
			      <div class="metadata">
			        <span class="date">Today at 5:42PM</span>
			      </div>
			      <div class="text">
			        How artistic!
			      </div>
			      <div class="actions">
			        <a class="reply title" data-toggle="collapse" href="#collapseExample" role="button">Reply</a>
			        <div class="collapse" id="collapseExample">
					 <div id="div_all">
						<div class="form-group">
							<textarea class="form-control" id="al_content" rows="2"></textarea>
						</div>
						<button type="button" class="ui blue basic button text-right" onclick="insert_alert_all()">답글 입력</button>
					</div>
					</div>
			      </div>
			    </div>
			  </div>
			  
			  
			  
			  
			  
			  
			  
			  
			  
			  <div class="comment">
			    <a class="avatar">
			      <img src="images/avatar/nan.jpg">
			    </a>
			    
			    <div class="content">
			      <a class="author">Elliot Fu</a>
			      <div class="metadata">
			        <span class="date">Yesterday at 12:30AM</span>
			      </div>
			      <div class="text">
			        <p>This has been very useful for my research. Thanks as well!</p>
			      </div>
			      <div class="actions">
			        <a class="reply">Reply</a>
			      </div>
			    </div>
			    
			    
			    
			    <div class="comments">
			      <div class="comment">
			        <a class="avatar">
			          <img src="images/avatar/nan.jpg">
			        </a>

			        <div class="content">
			          <a class="author">Jenny Hess</a>
			          <div class="metadata">
			            <span class="date">Just now</span>
			          </div>
			          <div class="text">
			            Elliot you are always so right :)
			          </div>
			          <div class="actions">
			            <a class="reply">Reply</a>
			          </div>
			        </div>
			      </div>
			      
			      
			   
			      
			    </div>
			  </div>
			  <div class="comment">
			    <a class="avatar">
			      <img src="images/avatar/tom.jpg">
			    </a>
			    <div class="content">
			      <a class="author">Joe Henderson</a>
			      <div class="metadata">
			        <span class="date">5 days ago</span>
			      </div>
			      <div class="text">
			        Dude, this is awesome. Thanks so much
			      </div>
			      <div class="actions">
			        <a class="reply">Reply</a>
			      </div>
			    </div>
			  </div>
			  <form class="ui reply form">
			    <div class="field">
			      <textarea></textarea>
			    </div>
			    <div class="ui blue labeled submit icon button">
			      <i class="icon edit"></i> 답장
			    </div>
			  </form>
			</div>
		</div>
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
	

</body>
</html>

<%
	}
%>