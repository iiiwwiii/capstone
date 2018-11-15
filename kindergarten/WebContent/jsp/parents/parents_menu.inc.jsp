<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.parents.ParentsDAO"%> 
<%@ page import="user.parents.ParentsVO"%> 
<%@ page import="user.child.ChildVO"%> 
<%
	String id = null;
	if(session.getAttribute("id")==null){		 
		response.sendRedirect("/kindergarten/jsp/first/first_main.jsp");  //이거 url접근 시 에러남. 여기 인클루드해서. 이거 나중에 좀 처리해줘야될듯 -> null아니면 아래 다묶는다거나 해서 
	}else if(session.getAttribute("id")!=null){		//이거 괄호를 맨 아래까지 내려줬음. 위에서 세션만 설정해봤자 아래 메서드에서 id값없어서 에러남. 
		id = (String)session.getAttribute("id");
	
	//회원id를 이용해서 회원이름 + 회원전화번호 select
	ParentsDAO parentsdao = ParentsDAO.getInstance(); 
	ParentsVO menuinfovo = parentsdao.parentsMenuInfo(id); 
	String parentsmenuchildpic = parentsdao.parentsMenuChildPic(id); 	
	
%> 
	
	<!--navbar--> 
	<nav class="navbar navbar-color-on-scroll navbar-transparent fixed-top navbar-expand-lg "  color-on-scroll="100" id="sectionsNav">
		<div class="container">
			<div class="navbar-translate">
				<a class="navbar-brand" href="parents_main.jsp">KINDERGARTEN </a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link" href="parents_attend_Form.jsp">출석부</a></li>
					<li class="nav-item"><a class="nav-link" href="parents_alert.jsp">알림장</a></li>
					<li class="nav-item"><a class="nav-link" href="parents_album.jsp">앨범</a></li>
					<li class="nav-item"><a class="nav-link" href="#">일정</a></li>
					<li class="nav-item"><a class="nav-link" href="parents_food_list.jsp">식단</a></li>
					<li class="nav-item"><a class="nav-link" href="parents_notice_list.jsp">공지사항</a></li>
					<li class="dropdown nav-item">
						<a class="nav-link" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
  						  회원정보
  						</a>

						<div class="dropdown-menu dropdown-with-icons">
							<div class="row">
								<div class="col-sm-6">
									<img class="w3-circle popupprofileimg" src="/kindergarten/etc/image/child/<%=parentsmenuchildpic%>">
								</div>
								<div class="col-sm-6"> 
									<div class="popupprofileinfo"> 
										<span class="popupprofile_1"><%=id %><br> <%=menuinfovo.getParents_name() %><br> <%=menuinfovo.getParents_phone() %>
										</span>
									</div>
								</div>
							</div>
							<hr>
							<div class="popupprofilebtn">
								<a href="parents_mypage.jsp"  style="font-size:12px;">마이페이지</a>  &nbsp;&nbsp;
								<a href="/kindergarten/jsp/first/first_logout.jsp"  style="font-size:12px;">로그아웃</a>								
							</div><!-- popupprofilebtn end -->
						</div><!-- dropdown-menu end -->
					</li><!-- dropdown end-->
				</ul><!--navbar-nav end-->
			</div><!--collapse end-->
		</div><!--container end-->
	</nav><!--navbar end-->
	
	<%}%>