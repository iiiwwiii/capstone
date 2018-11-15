<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.teacher.TeacherDAO" %>
<%@ page import = "user.child.ChildVO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%!     
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");   
%>
<%
	//페이징, 검색 뺐음 
	request.setCharacterEncoding("utf-8"); 
	int count = 0; 

 	List<ChildVO> childList = null; 
 	TeacherDAO dao = TeacherDAO.getInstance();												
   	count = dao.childListCount(); 
   
   	if (count > 0) {																		
		childList = dao.userChildList();								
   	}	
   	
   	//등록 시 아이 생년월일 datepicker - 좀 불편해서 바꾸는게 좋을 듯  -> 일단 직접 입력하는걸로 해놨음 date형식으로 
   	String datepicker = "";
	if(request.getParameter("datepicker") != null ){
		datepicker = request.getParameter("datepicker");	
	}
			
%>
<!doctype html>
<html lang="ko">
<title>선생님 원아관리</title>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
<link href="/kindergarten/etc/css/nav/nav.css" rel="stylesheet" type="text/css"> <!-- nav -->
<link href="/kindergarten/etc/css/parents/parents_default.css" rel="stylesheet" type="text/css"> <!-- html, body, footer-->
</head>
<body>
<!-- menu -->
<jsp:include page="teacher_menu.inc.jsp" flush="false" />
	
<div class="container" style="margin-top:7%;"> 
	<div class="pricing-header pb-md-4 mx-auto text-center">
      	<h1 class="display-4">원아 관리</h1>
      	<p class="lead mt-3">A반 인원수 : <%=count %>명 </p>
    </div>
	<%
		if (count == 0) {
	%>
		<div class="alert alert-primary" role="alert">등록된 원아가 없습니다. </div>
	<%
		} else {
	%>
	<table class="ui selectable celled table">
		<colgroup>   
			<col width="4%">			
			<col width="10%">
			<col width="6%">		
			<col width="7%">
			<col width="5%">	
			<col width="10%">
			<col width="23%">	
			<col width="*">
			<col width="10%">
		</colgroup>
		<thead class="thead-light">
	  		<tr>
	  			<th><input type="checkbox" name="selectall"></th>
	    		<th>사진</th>
	    		<th>반</th>
	    		<th>이름</th>
			    <th>성별</th>
			    <th>생년월일</th>
			    <th>주소</th>
			    <th>특이사항</th>
			    <th>등록일</th>
	  		</tr>
		</thead>
		<tbody>
			<%  
			for (int i = 0 ; i < childList.size() ; i++) {		  												
	  		ChildVO child = childList.get(i);	
			%>
			<tr>
				<td><input type="checkbox" name="check" value="<%=child.getChild_num()%>"></td>
				<td><img src="../../etc/image/child/<%=child.getChild_pic()%>" alt="원아사진" width="60" height="60"></td>
				<td><%=child.getChild_class()%></td>
				<td><%=child.getChild_name()%></td>
				<td><%=child.getChild_sex()%></td>
				<td><%=child.getChild_birth()%></td>
				<td>(<%=child.getChild_post()%>) <%=child.getChild_addr()%></td>
				<td><%=child.getChild_memo()%></td>
				<td><%=sdf.format(child.getChild_date())%></td>
		    </tr>
		    <%} %>
		</tbody>
	</table>
	<div class="two ui buttons pt-5">
		<button class="ui yellow button" data-toggle="modal" data-target="#childplus">원아등록</button>
		<button class="ui red basic button">원아삭제</button><!-- 삭제 아직안함 -->
	</div>
</div>
<%}%>

<!-- 원아 등록  modal -->
<div class="modal fade" id="childplus" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">원아등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form method="post" name="childinsertform"  action="teacher_child_insert.jsp"  enctype="multipart/form-data">
				<div class="modal-body" style="font-size:12px;">				
		    		<div class="row" style="margin-top:10px;">
		      			<div class="col-sm-2">이름 </div>
		      			<div class="col-sm-4">
		      				<input type="text" class="form-control" name="child_name" style="font-size:12px;">
		      			</div>
		      			<div class="col-sm-2">사진 </div>
		      			<div class="col-sm-4">
						    <input type="file" class="form-control-file" name="child_pic">
		      			</div>
		    		</div>	
		    		
		    		<div class="row" style="margin-top:10px;">
		      			<div class="col-sm-2">성별</div>
		      			<div class="col-sm-4">
		      				<select class="form-control" name="child_sex" style="font-size:12px;">
						      <option value="남">남</option>
						      <option value="여">여</option>
						    </select>
		      			</div>
		      			<div class="col-sm-2">생년월일 </div>
		      			<div class="col-sm-4">
						    <input type="date" class="form-control" name="child_birth" style="font-size:12px;">
		      			</div>
		    		</div>	
		    		
		    		<div class="row" style="margin-top:10px;">
		      			<div class="col-sm-2">주소</div>   <!-- ★주소 다음-->
		      			<div class="col-sm-4">
		      				<input type="text" class="form-control" name="child_post" id="child_post" style="font-size:12px;" readonly="readonly">
		      			</div>
		      			<div class="col-sm-6">
		      				<div class="input-group">
                           		<input type="text" class="form-control" name="child_addr" id="child_addr" style="font-size:12px;">
                           		<div class="input-group-append">
                               		<button type="button" class="ui secondary basic button" name="postcodeBtn" id="postcodeBtn" style="font-size:12px;">우편번호</button>
                           		</div>
                       		</div>
		      			</div>
		    		</div>	
		    		
		    		<div class="row" style="margin-top:10px;">
		      			<div class="col-sm-2">특이사항</div>
		      			<div class="col-sm-10">
		      				<textarea class="form-control" rows="7" name="child_memo" style="font-size:12px;"></textarea>
		      			</div>      			
		    		</div>	
		    			  	    			  
				</div> <!-- modal body -->
				<div class="modal-footer">				
					<button type="submit" class="ui yellow button">등록</button> <!-- ★ 나중에 유효성 체크 하기. 일단 submit -->
				</div>	
			</form>
		</div>
 	</div>
</div>

<!--footer-->
<jsp:include page="teacher_footer.inc.jsp" flush="false" />	

<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script> <!-- 반드시 윗줄->nav.js -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script> <!-- datepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script> <!-- addr -->
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>  
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> <!-- sweetalert -->

<script>
	//checkbox
	$('input[name=selectall]').on('change', function(){
		$('input[name=check]').prop('checked', this.checked);	
	});

	//주소 daum api 
	$(document).ready(function(){
	  $('#postcodeBtn').click(function(){
	    fetchDaumPostcode();
	  });
	});

	function fetchDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            var fullRoadAddr = data.roadAddress; 
	            var extraRoadAddr = ''; 

	            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	            // 건물명이 있고, 공동주택일 경우 추가한다.
	            if(data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	            if(extraRoadAddr !== ''){
	                extraRoadAddr = ' (' + extraRoadAddr + ')';
	            }
	            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	            if(fullRoadAddr !== ''){
	                fullRoadAddr += extraRoadAddr;
	            }

	            $('#child_post').val(data.zonecode);
	            $('#child_addr').val(fullRoadAddr);
	        }
	    }).open();
	}
</script>

</body>
</html>