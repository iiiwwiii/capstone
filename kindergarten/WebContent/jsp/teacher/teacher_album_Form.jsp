<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="picture.ScheduleDAO" %>
<%@ page import="picture.ScheduleVO" %>

<% 
	String schedule_title = null;
	String album_num = null;
	String schedule_num = null;
	String search_schedule = null;
	
	if(request.getParameter("schedule_title") != null){
		schedule_title = request.getParameter("schedule_title");
	}else{
		schedule_title = "스케줄 제목을 입력해주세요";
	}
	
	if(request.getParameter("album_num") != null){
		album_num = request.getParameter("album_num");
	}
	
	if(request.getParameter("search_schedule") != null){
		search_schedule = request.getParameter("search_schedule");
}
%>

<!doctype html>
<html lang="ko">
<title>선생님 사진등록 폼</title>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
<link href="/kindergarten/etc/css/nav/nav.css" rel="stylesheet" type="text/css"> <!-- nav -->
<link href="/kindergarten/etc/css/parents/parents_default.css" rel="stylesheet" type="text/css"> <!-- html, body, footer-->

<style>
.hover_div:hover img {
  -webkit-filter: brightness(100%); /* Safari 6.0 - 9.0 */
    filter: brightness(50%);

}

.hover_div:hover .middle {
  opacity: 1;
}

.hover_div:hover .middle2 {
  opacity: 1;
}

.middle {
  transition: .5s ease;
  opacity: 0;
  position: absolute;
  top: 25%;
  left: 50%;
  transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
  text-align: center;
}

.middle2 {
  text-color: white;
  transition: .5s ease;
  opacity: 0;
  position: absolute;
  bottom: 10%;
  left: 50%;
  transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
  text-align: center;
}

.text {
  background-color: #4CAF50;
  color: white;
  font-size: 16px;
  padding: 16px 32px;
}
</style>
</head>
<body>

<!-- menu -->
<jsp:include page="teacher_menu.inc.jsp" flush="false" />
	
<div class="container" style="margin-top: 10%">
	<div class="pricing-header pb-md-4 mx-auto text-center">
		<h1 class="display-4">사진 등록 폼</h1>
	</div>
	<!-- 사진 추가 폼 -->
	<form method="post" class="ui form pt-5" enctype="multipart/form-data" action="teacher_album_Pro.jsp">
		<div class="justify-content-center">
			<div class="ui form">
			<div class="four fields">			
				<!-- 선생님 그냥 session값 넣어주면 됨 -->
				<div class="four wide field">
					<label for="inputAddress">작성자</label> 
					<input type="text" class="form-control" readonly value="A반교사">
				</div>
				<!-- 반명 -->
				<div class="two wide field">
					<label for="inputAddress">반명</label>
						<select id="inputState" class="form-control" id="class_name">
						  	<option value="A" selected>A</option>
					        <option value="기린반">기린반</option>
					        <option value="햇님반">햇님반</option>
					        <option value="토끼반">토끼반</option>
					     </select>
				</div>		
				<!-- 앨범명  -->
				<div class="eight wide field">
					<label for="inputAddress">앨범 명</label>
						<input type="hidden" name="album_num" value="<%= album_num%>">
						<input type="text" class="form-control" name="album_title" id="album_title" readonly value="<%= schedule_title%>">
				</div>					
				<!-- 앨범 검색하는 버튼 -->
				<div class="two wide field">
					<br>
					<button type="button" class="ui yellow basic button" data-toggle="modal" data-target="#exampleModalCenter" id="album_search">앨범명 검색</button>
				</div>						
			</div>
			</div>
			
			<div class="form-group">
				<label for="inputAddress2">일정 내용</label>
				<textarea class="form-control" rows="10" name="album_content" id="album_content"></textarea>
			</div>
				<div class="form-group" style="margin-top:30px; margin-bototm:30px;">
					<div class="row form-group">
						<button type="button" class="ui black basic button ml-3" id="add_pic">사진 추가</button>
					</div>						    
						<input type="file" class="form-control-file" name="pic1" id="schedule_date1" style="display:none">
						<input type="file" class="form-control-file" name="pic2" id="schedule_date2" style="display:none;">
						<input type="file" class="form-control-file" name="pic3" id="schedule_date3" style="display:none;">
						<input type="file" class="form-control-file" name="pic4" id="schedule_date4" style="display:none;">
						<input type="file" class="form-control-file" name="pic5" id="schedule_date5" style="display:none;">
						<input type="file" class="form-control-file" name="pic6" id="schedule_date6" style="display:none;">
						<input type="file" class="form-control-file" name="pic7" id="schedule_date7" style="display:none;">
						<input type="file" class="form-control-file" name="pic8" id="schedule_date8" style="display:none;">
						<input type="file" class="form-control-file" name="pic9" id="schedule_date9" style="display:none;">
						<input type="file" class="form-control-file" name="pic10" id="schedule_date10" style="display:none;">
						<input type="file" class="form-control-file" name="pic11" id="schedule_date11" style="display:none;">
						<input type="file" class="form-control-file" name="pic12" id="schedule_date12" style="display:none;">
				</div>
				<div class="form-group row">
					<div class="col-md-2 hover_div" id="d1"></div>
					<div class="col-md-2 hover_div" id="d2"></div>
					<div class="col-md-2 hover_div" id="d3"></div>
					<div class="col-md-2 hover_div" id="d4"></div>
					<div class="col-md-2 hover_div" id="d5"></div>
					<div class="col-md-2 hover_div" id="d6"></div>
				</div>
				<div class="form-group row">
					<div class="col-md-2 hover_div" id="d7" style="height:150px;"></div>
					<div class="col-md-2 hover_div" id="d8"></div>
					<div class="col-md-2 hover_div" id="d9"></div>
					<div class="col-md-2 hover_div" id="d10"></div>
					<div class="col-md-2 hover_div" id="d11"></div>
					<div class="col-md-2 hover_div" id="d12"></div>
				</div>
				<div class="two ui buttons"><!-- 버튼 일정 등록  -> ajax써서!-->
					<button type="submit" class="ui yellow button" id="submit_button">등록</button>
					<button type="reset" class="ui grey basic button">취소</button>
				</div>
		</div>
  	</form>		
</div><!-- end container -->
	
	<!-- 앨범명 불러오는 모달 -->
	<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenter" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalCenterTitle">앨범명 검색</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form class="ui form">
			  <div class="form-group">
			      <input type="text" class="form-control" id="search_schedule" name="search_schedule" placeholder="yyyy-mm-dd or 제목검색어 입력">
			  </div>
			  <table class="table" id="table">
			      <colgroup>
			      	<col width="30%">
			      	<col width="*">
			      </colgroup>
				  <thead>
				    <tr>
				      <th scope="col">날짜</th>
				      <th scope="col">스케줄명</th>
				    </tr>
				  </thead> 
					<% 
		
					ScheduleVO schedule = null;					
					ScheduleDAO dbPro = ScheduleDAO.getInstance();
					
					List<ScheduleVO> scheduleList = dbPro.get_schedule_in_modal(search_schedule);
					
					if(scheduleList != null){
						for(int i=0; i<scheduleList.size(); i++){
							schedule = scheduleList.get(i);
					%>
					  <tbody>
					    <tr>
					      <th scope="col"><%= schedule.getSchedule_date() %></th>
					      <td scope="col"><%= schedule.getSchedule_title() %></td>
					    </tr>
					  </tbody>
					  <% 
						}
					}
					%>
	
				</table>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="ui grey basic button" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
<!--footer-->
<jsp:include page="teacher_footer.inc.jsp" flush="false" />	

<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script> <!-- 반드시 윗줄->nav.js -->	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>

<script>
	$(document).ready(function(){
	    $("#search_schedule").keyup(function(){
	    	$.ajax({
	    		  type:"get",
	    		  url: "teacher_album_search_Pro.jsp",
	    		  data: { search_schedule : $("#search_schedule").val() },
	    		  success: function(result){ $("#table").html(result)  }
	    		});
	    });
	});
</script>

<script>
	$(document).ready(function(){
			var count = 0;
		
			$("#add_pic").click(function(){
				count++;
		    	$("#schedule_date"+ count).click();
			});
			
			
			$("#schedule_date1").change(function(event){
		    	var realPath = URL.createObjectURL(event.target.files[0]); //파일 realpath가져오기
		        var check = $(this).val().split(".");
		        
		        if(check[1] != "jpg" && check[1] != "png" && check[1] != "JPG" && check[1] != "PNG"){
		        	$(this).val("");
		        	alert("옳지못한 사진 형식입니다. jpg, png만 가능");
		        }else{
		        	//alert(add);
		        	$("#d1").html("<img src='"+realPath+"' id='p_1' style='width:100%; height:150px;'><div class='middle'><button type='button' class='btn btn-light' id='del_p1'>&nbsp;&nbsp;삭&nbsp;제&nbsp;&nbsp;</button></div><div class='middle2'><button type='button' class='btn btn-success'>태그추가</button></div>")
		        	$("#d2").html("<div style='border: 1px solid gray; width:100%; height:150px;'><div class='w3-display-middle'><h2>+</h2></div></div>");
		        }
		    });
			
			$("#del_p1").click(function(){
				--count;
				
			});
		  
			
			
		  $("#schedule_date2").change(function(event){
		    	var realPath = URL.createObjectURL(event.target.files[0]); //파일 realpath가져오기
		        var check = $(this).val().split(".");
		        
		        if(check[1] != "jpg" && check[1] != "png" && check[1] != "JPG" && check[1] != "PNG"){
		        	$(this).val("");
		        	alert("옳지못한 사진 형식입니다. jpg, png만 가능");
		        }else{
		        	$("#d2").html("<img src='"+realPath+"' id='p_1' style='width:100%; height:150px;'><div class='middle'><button type='button' class='btn btn-light' id='del_p1'>&nbsp;&nbsp;삭&nbsp;제&nbsp;&nbsp;</button></div><div class='middle2'><button type='button' class='btn btn-success'>태그추가</button></div>")
		        	$("#d3").html("<div style='border: 1px solid gray; width:100%; height:150px;' id='sd2'><div class='w3-display-middle'><h2>+</h2></div></div>");

		        }
		    });
		  
		  $("#schedule_date3").change(function(event){
		    	var realPath = URL.createObjectURL(event.target.files[0]); //파일 realpath가져오기
		        var check = $(this).val().split(".");
		        
		        if(check[1] != "jpg" && check[1] != "png" && check[1] != "JPG" && check[1] != "PNG"){
		        	$(this).val("");
		        	alert("옳지못한 사진 형식입니다. jpg, png만 가능");
		        }else{
		        	$("#d3").html("<img src='"+realPath+"' id='p_1' style='width:100%; height:150px;'><div class='middle'><button type='button' class='btn btn-light' id='del_p1'>&nbsp;&nbsp;삭&nbsp;제&nbsp;&nbsp;</button></div><div class='middle2'><button type='button' class='btn btn-success'>태그추가</button></div>")
		        	$("#d4").html("<div style='border: 1px solid gray; width:100%; height:150px;'><div class='w3-display-middle'><h2>+</h2></div></div>");
		        }
		    });
		  
		  $("#schedule_date4").change(function(event){
		    	var realPath = URL.createObjectURL(event.target.files[0]); //파일 realpath가져오기
		        var check = $(this).val().split(".");
		        
		        if(check[1] != "jpg" && check[1] != "png" && check[1] != "JPG" && check[1] != "PNG"){
		        	$(this).val("");
		        	alert("옳지못한 사진 형식입니다. jpg, png만 가능");
		        }else{
		        	$("#d4").html("<img src='"+realPath+"' id='p_1' style='width:100%; height:150px;'><div class='middle'><button type='button' class='btn btn-light' id='del_p1'>&nbsp;&nbsp;삭&nbsp;제&nbsp;&nbsp;</button></div><div class='middle2'><button type='button' class='btn btn-success'>태그추가</button></div>")
		        	$("#d5").html("<div style='border: 1px solid gray; width:100%; height:150px;'><div class='w3-display-middle'><h2>+</h2></div></div>");
		        }
		    });
		  
		  $("#schedule_date5").change(function(event){
		    	var realPath = URL.createObjectURL(event.target.files[0]); //파일 realpath가져오기
		        var check = $(this).val().split(".");
		        
		        if(check[1] != "jpg" && check[1] != "png" && check[1] != "JPG" && check[1] != "PNG"){
		        	$(this).val("");
		        	alert("옳지못한 사진 형식입니다. jpg, png만 가능");
		        }else{
		        	$("#d5").html("<img src='"+realPath+"' id='p_1' style='width:100%; height:150px;'><div class='middle'><button type='button' class='btn btn-light' id='del_p1'>&nbsp;&nbsp;삭&nbsp;제&nbsp;&nbsp;</button></div><div class='middle2'><button type='button' class='btn btn-success'>태그추가</button></div>")
		        	$("#d6").html("<div style='border: 1px solid gray; width:100%; height:150px;'><div class='w3-display-middle'><h2>+</h2></div></div>");
		        }
		    });
		  
		  $("#schedule_date6").change(function(event){
		    	var realPath = URL.createObjectURL(event.target.files[0]); //파일 realpath가져오기
		        var check = $(this).val().split(".");
		        
		        if(check[1] != "jpg" && check[1] != "png" && check[1] != "JPG" && check[1] != "PNG"){
		        	$(this).val("");
		        	alert("옳지못한 사진 형식입니다. jpg, png만 가능");
		        }else{
		        	$("#d6").html("<img src='"+realPath+"' id='p_1' style='width:100%; height:150px;'><div class='middle'><button type='button' class='btn btn-light' id='del_p1'>&nbsp;&nbsp;삭&nbsp;제&nbsp;&nbsp;</button></div><div class='middle2'><button type='button' class='btn btn-success'>태그추가</button></div>")
		        	$("#d7").html("<div style='border: 1px solid gray; width:100%; height:150px;'><div class='w3-display-middle'><h2>+</h2></div></div>");
		        }
		    });
		  
		  $("#schedule_date7").change(function(event){
		    	var realPath = URL.createObjectURL(event.target.files[0]); //파일 realpath가져오기
		        var check = $(this).val().split(".");
		        
		        if(check[1] != "jpg" && check[1] != "png" && check[1] != "JPG" && check[1] != "PNG"){
		        	$(this).val("");
		        	alert("옳지못한 사진 형식입니다. jpg, png만 가능");
		        }else{
		        	$("#d7").html("<img src='"+realPath+"' id='p_1' style='width:100%; height:150px;'><div class='middle'><button type='button' class='btn btn-light' id='del_p1'>&nbsp;&nbsp;삭&nbsp;제&nbsp;&nbsp;</button></div><div class='middle2'><button type='button' class='btn btn-success'>태그추가</button></div>")
		        	$("#d8").html("<div style='border: 1px solid gray; width:100%; height:150px;'><div class='w3-display-middle'><h2>+</h2></div></div>");
		        }
		    });
		  
		  $("#schedule_date8").change(function(event){
		    	var realPath = URL.createObjectURL(event.target.files[0]); //파일 realpath가져오기
		        var check = $(this).val().split(".");
		        
		        if(check[1] != "jpg" && check[1] != "png" && check[1] != "JPG" && check[1] != "PNG"){
		        	$(this).val("");
		        	alert("옳지못한 사진 형식입니다. jpg, png만 가능");
		        }else{
		        	$("#d8").html("<img src='"+realPath+"' id='p_1' style='width:100%; height:150px;'><div class='middle'><button type='button' class='btn btn-light' id='del_p1'>&nbsp;&nbsp;삭&nbsp;제&nbsp;&nbsp;</button></div><div class='middle2'><button type='button' class='btn btn-success'>태그추가</button></div>")
		        	$("#d9").html("<div style='border: 1px solid gray; width:100%; height:150px;'><div class='w3-display-middle'><h2>+</h2></div></div>");
		        }
		    });
		  
		  $("#schedule_date9").change(function(event){
		    	var realPath = URL.createObjectURL(event.target.files[0]); //파일 realpath가져오기
		        var check = $(this).val().split(".");
		        
		        if(check[1] != "jpg" && check[1] != "png" && check[1] != "JPG" && check[1] != "PNG"){
		        	$(this).val("");
		        	alert("옳지못한 사진 형식입니다. jpg, png만 가능");
		        }else{
		        	$("#d9").html("<img src='"+realPath+"' id='p_1' style='width:100%; height:150px;'><div class='middle'><button type='button' class='btn btn-light' id='del_p1'>&nbsp;&nbsp;삭&nbsp;제&nbsp;&nbsp;</button></div><div class='middle2'><button type='button' class='btn btn-success'>태그추가</button></div>")
		        	$("#d10").html("<div style='border: 1px solid gray; width:100%; height:150px;'><div class='w3-display-middle'><h2>+</h2></div></div>");
		        }
		    });
		  
		  $("#schedule_date10").change(function(event){
		    	var realPath = URL.createObjectURL(event.target.files[0]); //파일 realpath가져오기
		        var check = $(this).val().split(".");
		        
		        if(check[1] != "jpg" && check[1] != "png" && check[1] != "JPG" && check[1] != "PNG"){
		        	$(this).val("");
		        	alert("옳지못한 사진 형식입니다. jpg, png만 가능");
		        }else{
		        	$("#d10").html("<img src='"+realPath+"' id='p_1' style='width:100%; height:150px;'><div class='middle'><button type='button' class='btn btn-light' id='del_p1'>&nbsp;&nbsp;삭&nbsp;제&nbsp;&nbsp;</button></div><div class='middle2'><button type='button' class='btn btn-success'>태그추가</button></div>")
		        	$("#d11").html("<div style='border: 1px solid gray; width:100%; height:150px;'><div class='w3-display-middle'><h2>+</h2></div></div>");
		        }
		    });
		  
		  $("#schedule_date11").change(function(event){
		    	var realPath = URL.createObjectURL(event.target.files[0]); //파일 realpath가져오기
		        var check = $(this).val().split(".");
		        
		        if(check[1] != "jpg" && check[1] != "png" && check[1] != "JPG" && check[1] != "PNG"){
		        	$(this).val("");
		        	alert("옳지못한 사진 형식입니다. jpg, png만 가능");
		        }else{
		        	//alert(add);
		        	$("#d11").html("<img src='"+realPath+"' id='p_1' style='width:100%; height:150px;'><div class='middle'><button type='button' class='btn btn-light' id='del_p1'>&nbsp;&nbsp;삭&nbsp;제&nbsp;&nbsp;</button></div><div class='middle2'><button type='button' class='btn btn-success'>태그추가</button></div>")
		        	$("#d12").html("<div style='border: 1px solid gray; width:100%; height:150px;'><div class='w3-display-middle'><h2>+</h2></div></div>");
		        }
		    });
		  
		  $("#schedule_date12").change(function(event){
		    	var realPath = URL.createObjectURL(event.target.files[0]); //파일 realpath가져오기
		        var check = $(this).val().split(".");
		        
		        if(check[1] != "jpg" && check[1] != "png" && check[1] != "JPG" && check[1] != "PNG"){
		        	$(this).val("");
		        	alert("옳지못한 사진 형식입니다. jpg, png만 가능");
		        }else{
		        	//alert(add);
		        	$("#d12").html("<img src='"+realPath+"' id='p_1' style='width:100%; height:150px;'><div class='middle'><button type='button' class='btn btn-light' id='del_p1'>&nbsp;&nbsp;삭&nbsp;제&nbsp;&nbsp;</button></div><div class='middle2'><button type='button' class='btn btn-success'>태그추가</button></div>")
		        }
		    });
	
		
		});
</script>
</body>
</html>
