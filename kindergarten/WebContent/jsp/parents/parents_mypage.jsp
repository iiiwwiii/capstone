<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="user.parents.ParentsDAO"%>
<%@ page import="user.parents.ParentsVO"%>
<%@ page import="user.child.ChildVO"%>
<%@ page import="user.teacher.TeacherVO"%>

<%!	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<%
	request.setCharacterEncoding("utf-8");

	List<ParentsVO> parentsList = null;
	ParentsDAO dao = ParentsDAO.getInstance();
	
	ChildVO getChildList = null;
	TeacherVO getTeacherList = null;
	
	//parents session 
	String id = null;
	if(session.getAttribute("id")==null){		
		response.sendRedirect("/kindergarten/jsp/first/first_main.jsp");
	}else  if(session.getAttribute("id")!=null){
		id = (String)session.getAttribute("id");
		
%>

<!doctype html>
<html lang="ko">
<title>학부모 마이페이지</title>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
<link href="/kindergarten/etc/css/parents/parents.css" rel="stylesheet" type="text/css">
<link href="/kindergarten/etc/css/nav/nav.css" rel="stylesheet" type="text/css"> <!-- nav -->
<link href="/kindergarten/etc/css/parents/parents_default.css" rel="stylesheet" type="text/css"> <!-- html, body, footer-->
</head>
<body>

<!-- menu -->
<jsp:include page="parents_menu.inc.jsp" flush="false" />

<%
	//parents_id는 로그인한 세션값을 넣어준다
	parentsList = dao.getParentsList(id);
	for (int i = 0; i < parentsList.size(); i++) {
		ParentsVO parents = parentsList.get(i);
%>
<div class="pricing-header pb-md-4 mx-auto pt-2 text-center" style="margin-top:7%">
	<h2 class="display-4"><%=parents.getParents_name()%>님</h2>
	<p class="lead pt-2">내 정보와 우리 아이의 정보를 수정하거나 담당 선생님의 정보를 조회할 수 있는 공간입니다.</p>
</div>
	<div class="container col-lg-6 col-offset-2 mt-5">
		<nav>
			<div class="nav nav-tabs" id="nav-tab" role="tablist">
				<a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" 
					href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">내 정보</a> 
				<a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab"
					href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">내 아이 정보</a> 
				<a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" 
					href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">선생님 정보</a>
			</div>
		</nav>
		<div class="tab-content" id="nav-tabContent">
			<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
				<form class="ui equal width form" style="margin-top:5%; margin-bottom:5%">
					<div class="field">
						<label>아이디</label> 
						<input type="text" name="parents_id" value="<%=parents.getParents_id()%>">
					</div>
					<div class="field">
						<label>비밀번호</label> 
						<input type="text" name="parents_pwd" value="<%=parents.getParents_pwd()%>">
					</div>
					<div class="field">
						<label>이름</label> 
						<input type="text" name="parents_name" value="<%=parents.getParents_name()%>">
					</div>
					<div class="field">
						<label>휴대폰 번호</label> 
						<input type="text" name="parents_phone" value="<%=parents.getParents_phone()%>">
					</div>
					<div class="fields">
						<div class="field">
							<label>우편번호</label> 
							<input type="text" name="parents_post" value="<%=parents.getParents_post()%>">
						</div>
						<div class="field">
							<label>주소</label> 
							<input type="text" name="parents_addr" value="<%=parents.getParents_addr()%>">
						</div>
					</div>
					<button class="tiny ui yellow button" type="submit">수정</button>
				</form>
			</div>
<%
	} getChildList = dao.getChildList("parents2");
%>
			<div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
				<form class="ui equal width form" style="margin-top:5%; margin-bottom:5%">
					<div class="field">
						<label>이름</label> 
						<input type="text" name="child_name" value="<%=getChildList.getChild_name()%>">
					</div>
					<div class="field">
						<label>반</label> 
						<input type="text" name="child_class" value="<%=getChildList.getChild_class()%>">
					</div>
					<div class="field">
						<label>성별</label> 
						<input type="text" name="child_sex" value="<%=getChildList.getChild_sex()%>">
					</div>
					<div class="field">
						<label>생일</label> 
						<input type="text" name="child_birth" value="<%=getChildList.getChild_birth()%>">
					</div>
					<div class="fields">
						<div class="field">
							<label>우편번호</label> 
							<input type="text" name="child_post" value="<%=getChildList.getChild_post()%>">
						</div>
						<div class="field">
							<label>주소</label> 
							<input type="text" name="child_addr" value="<%=getChildList.getChild_addr()%>">
						</div>												
					</div>				
					<div class="field">
						<label>사진</label> 
						<a href="#" class="ui medium image"> 
							<img src="/kindergarten/etc/image/child/<%=getChildList.getChild_pic()%>">
							<input type="hidden" name="child_pic">
						</a>
					</div>
					<div class="field">
						<label>유의사항</label> 
						<textarea><%=getChildList.getChild_memo()%></textarea>
						<input type="hidden" name="child_memo">
					</div>
					<button class="tiny ui yellow button" type="submit">수정</button>
				</form>
			</div>
<%
	getTeacherList = dao.getTeacherList("A");
%>		
			<div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
				<form class="ui equal width form" style="margin-top:5%; margin-bottom:5%">
					<div class="field">
						<label>반</label> 
						<input type="text" name="teacher_class" value="<%=getTeacherList.getTeacher_class()%>">
					</div>
					<div class="field">
						<label>이름</label> 
						<input type="text" name="teacher_name" value="<%=getTeacherList.getTeacher_name()%>">
					</div>
					<div class="field">
						<label>전화번호</label> 
						<input type="text" name="teacher_phone" value="<%=getTeacherList.getTeacher_phone()%>">
					</div>								
					<div class="field">
						<label>사진</label> 					
						<input type="image" name="teacher_pic" value="<%=getTeacherList.getTeacher_pic()%>">
					</div>
				</form>
			</div>
		</div>
	</div>

<!--footer js링크들은 나중에-->
<jsp:include page="parents_footer.inc.jsp" flush="false" />


<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script> <!-- 반드시 윗줄->nav.js -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>
</body>
</html>
<%}%>