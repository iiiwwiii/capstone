<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.teacher.TeacherDAO"%>
<%@ page import = "user.child.ChildDAO" %>
<%@ page import="user.parents.ParentsVO"%>
<%@ page import="user.child.ChildVO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%!int pageSize = 8;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");%>
<%
	request.setCharacterEncoding("utf-8");
	String pageNum = request.getParameter("pageNum");
	int count = 0;
	int number = 0;

	if (pageNum == null) {
		pageNum = "1";
	}

	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;

	String search = "";
	if (request.getParameter("search") != null) {
		search = request.getParameter("search");
	}

	String click_id = "";
	if (request.getParameter("click_id") != null) {
		click_id = request.getParameter("click_id");
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
       $(document).ready(function(){
               $("#myModal").modal();
               
       });
       </script>
<%
	}
%>
<!doctype html>
<html lang="ko">
<title>선생님 학부모회원 관리</title>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
<link href="/kindergarten/etc/css/nav/nav.css" rel="stylesheet" type="text/css"> <!-- nav -->
</head>
<body>

<!-- menu -->
<jsp:include page="teacher_menu.inc.jsp" flush="false" />

	<div class="container" style="margin-top:7%;">
		<div class="pricing-header pb-md-4 mx-auto text-center">
	      	<h1 class="display-4"> 학부모회원 관리</h1>
	      	<p class="lead mt-3">학부모 회원의 현황을 확인하고 삭제와 가입승인을 할 수 있는 공간입니다. </p>
	    </div> 
		<div class="ui secondary menu" style="margin-top:3%;">
			<a class="active item"> 학부모회원 검색 </a> 
			<form method="get" action="teacher_user_list.jsp" id="custom-search-form" class="ui form">
				<div class="right menu">
					<div class="item">
						<div class="ui icon input">
							<input type="text" class="search-query" placeholder="id" name="search" value="<%=search%>">
							<i class="search link icon"></i>
						</div>
					</div>
				</div>
			</form>
		</div>
		<%
			List<ParentsVO> parentsList = null;
			TeacherDAO dao = TeacherDAO.getInstance();
			count = dao.userParentsListCount(search);

			if (count > 0) {
				parentsList = dao.userParentsList(search, startRow, pageSize);
			}

			number = count - (currentPage - 1) * pageSize;
		%>
		<div class="card" style="margin-top: 4px;">
			<div class="card-body">
				<span style="margin-left: 20px;"> 인원 : <%=count%>명 </span>
				<%
					if (count == 0) {
				%>
				<div class="alert alert-primary" role="alert">검색된 회원이 없습니다.</div>
				<%
					} else {
				%>
				<button type="button" id="parent_delete" class="ui negative basic button" style="margin-left:2%" onclick="parentsDelete(this.form);">삭제</button>
				<form id="parentform" name="parentsform" class="ui form" action="teacher_user_delete.jsp">
					<table class="table table-borderless table-hover" style="text-align: center; margin-top:3%">
						<colgroup>
							<col width="7%">
							<col width="12%">
							<col width="15%">
							<col width="*">
							<col width="13%">
							<col width="8%">
							<col width="7%">
							<col width="8%">
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" name="selectall"></th>
								<th>ID</th>
								<th>전화번호</th>
								<th>주소</th>
								<th>가입일</th>
								<th>원아이름</th>
								<th>원아반</th>
								<th>가입승인</th>
							</tr>
						</thead>
						<tbody>
							<%
								for (int i = 0; i < parentsList.size(); i++) {
									ParentsVO parents = parentsList.get(i);
							%>
							<tr>
								<td><input type="checkbox" name="check" value="<%=parents.getParents_id()%>"></td>
								<td id="<%=parents.getParents_id()%>"><%=parents.getParents_id()%></td>
								<td><%=parents.getParents_phone()%></td>
								<td><%=parents.getParents_addr()%></td>  
								<td><%=sdf.format(parents.getParents_date())%></td>
								<td><%=parents.getCon_child_name()%></td>
								<td><%=parents.getCon_child_class()%></td>
								<td>
								<%if (parents.isParents_app() == false) {%> 
									
								<a href="#" onclick="accept('<%=parents.getParents_id()%>','<%=parents.getCon_child_name()%>','<%=parents.getCon_child_class()%>');"
									class="badge badge-pill badge-danger">미승인</a> 
									
								<%} else if (parents.isParents_app() == true) {%> 
									
								<a href="#" class="badge badge-pill badge-success">승인</a>
									
								<%}%>
								</td>
							</tr>
							<%}%>
						</tbody>
					</table>
					<%}%>
				</form>
				<nav aria-label="Page navigation example">
					<ul class="pagination pagination-sm justify-content-end">
						<%
							if (count > 0) {
								int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
								int startPage = 1;
								if (currentPage % 10 != 0)
									startPage = (int) (currentPage / 10) * 10 + 1;
								else
									startPage = ((int) (currentPage / 10) - 1) * 10 + 1;
								int pageBlock = 10;
								int endPage = startPage + pageBlock - 1;
								if (endPage > pageCount)
									endPage = pageCount;

								if (startPage > 10) {
						%>
						<li class="page-item">
						<a class="page-link" href="teacher_user_list.jsp?pageNum=<%=startPage - 10%>">이전</a></li>
						<%
							}
								for (int i = startPage; i <= endPage; i++) {
									if (i == currentPage) {
						%>
						<li class="page-item active">
						<a class="page-link" href="#"><%=i%><span class="sr-only">(current)</span></a></li>
						<%
							} else {
						%>
						<li class="page-item"><a class="page-link" href="teacher_user_list.jsp?pageNum=<%=i%>"><%=i%></a></li>
						<%
							}
								}
								if (endPage < pageCount) {
						%>
						<li class="page-item"><a class="page-link" href="teacher_user_list.jsp?pageNum=<%=startPage + 10%>">다음</a></li>
						<%
							}
							}
						%>
					</ul>
				</nav>
			</div>
		</div>
	</div>
	<!-- end container -->

	<!-- parents profile modal-->
	<div class="modal fade" id="exampleModalLabel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel" style="margin-left: 10px;">학부모 회원 정보</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>		
				<div class="modal-body" style="font-size: 12px;" id="parentsmodal">
					
				</div>
				<div class="modal-footer">
					<button type="button" class="ui grey basic button" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<script>
	//td - modal 
	$('.pid').click(function(){
		var parents_id = $(this).attr("id");
		//alert(parents_id); - 넘어옴 
		$.ajax({
			url:"teacher_user_list.jsp",
			method:"post",
			data:{parents_id:parents_id},
			success:function(data){
				$('#parentsmodal').html(data); 
				$('#exampleModalLabel').modal("show");  
			}
		});
	});


//미승인 -> 승인처리 (아이pk로 update하는게 아니라 문제 발생 - 같은 반에 같은 이름일 시 다 변경됨 -> 해결하려면 db변경 필요)
   function accept(id, name, ban){      
      swal({
           text: "승인하시겠습니까?",
           buttons: {
              confirm: {
                   text: "승인",
                   value: true
             },
              cancel: true,   
           },
           dangerMode: true,  
         })
         .then((willDelete) => {    
           if (willDelete) {  
              swal("승인되었습니다.") //그냥뿌려줌  - 메서드 잘 돌아갔을때 뿌리려면 ajax로 해야하는데 리스트가 ajax가 아니므로 그냥 함 
            .then((value) => {     
               location.href="teacher_user_accept.jsp?parents_id="+id+"&con_child_name="+name+"&con_child_class="+ban;      
            });            
           } else {
             return false;
           }
      });
   }
    
//check
   $('input[name=selectall]').on('change',function(){
      $('input[name=check]').prop('checked', this.checked)
   });
   
//delete
   function parentsDelete(parentsform){
      var count = $('input:checkbox[name="check"]:checked').length; 
      if(count>0){
         swal({
              text: "삭제하시겠습니까?",
              buttons: {
                 confirm: {
                      text: "삭제",
                      value: true
                },
                 cancel: true,   
              },
              dangerMode: true, 
            })
            .then((willDelete) => {     
              if (willDelete) { 
                 parentsform.submit();      
              } else { 
                return false;
              }
         });   
      }else if(count==0){
         swal("한 명 이상 선택해 주세요.");
         return;   
      }
   }
   
</script>

<!--footer-->
<jsp:include page="teacher_footer.inc.jsp" flush="false" />	

<script type="text/javascript" src="/kindergarten/etc/js/nav/nav.js"></script> <!-- 반드시 윗줄->nav.js -->
<script src="/kindergarten/etc/js/parents/parents.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script><!-- sweetalert -->

</body>
</html>