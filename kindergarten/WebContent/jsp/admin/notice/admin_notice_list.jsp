<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import = "user.admin.AdminDAO" %>
<%@ page import = "user.admin.AdminNoticeVO" %>

<%!
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
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
	 
	List<AdminNoticeVO> noticeList = null; 
	AdminDAO dao = AdminDAO.getInstance();												
	count = dao.noticeCount(); 

	if (count > 0) {																		
		noticeList = dao.noticeList(startRow, pageSize);								
	}	
	number = count-(currentPage-1)*pageSize;  	


%>
<!doctype html>
<html lang="ko">
<title>관리자 공지사항</title>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="/kindergarten/assets/bootstrap-4.1.3/css/bootstrap.min.css">
 
</head>
<body style="font-size:12px;">

<div class="container">
	<h4>관리자 공지사항 리스트</h4>
	<%=count %>개 글 <br>
	
	<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#noticeplus">공지사항 등록</button>
	<%
		if (count == 0) {
	%>
		<div class="alert alert-primary" role="alert">공지사항이 없습니다. </div>
	<%
		} else {
	%>
	<table class="table table-bordered">
		<colgroup>   			
			<col width="60%">
			<col width="20%">		
			<col width="20%">
		</colgroup>
		 <thead class="thead-light">								   
		   <tr>
		     <th>notice_title(제목)</th>
		     <th>notice_count(조회수)</th>
		     <th>notice_date(작성일)</th>
		   </tr>
		 </thead>							
		  <tbody>
		  
			<%  
			for (int i = 0 ; i < noticeList.size(); i++) {	
				
				AdminNoticeVO notice = noticeList.get(i);	
			%>
		    <tr>		      
		      <td>
		      	<a href="admin_notice_layout.jsp?num=<%=notice.getNotice_num()%>&pageNum=<%=currentPage%>">     
				      <%if(notice.isNotice_fi()==true){%>
				      	<i class="fas fa-flag"></i> 
				      <%}%>
				      <%=notice.getNotice_title()%>	 	
			      </a>       
		      </td>  
		      <td><%=notice.getNotice_count()%></td>
		      <td><%=notice.getNotice_date() %></td> 
		    </tr>	
			<%}%>							    
		  </tbody>
		</table>
	<% 
	}
	%>	
	 
	 <!-- 페이징 접어둠 -->
	<nav aria-label="Page navigation example" style="float:right; margin-right:20px;">							
		<ul class="pagination justify-content-end">
	<%
   		if (count > 0) {											
      			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);  
			int startPage =1;	
			if(currentPage % 10 != 0)
          			startPage = (int)(currentPage/10)*10 + 1;
			else
          			startPage = ((int)(currentPage/10)-1)*10 + 1;
			int pageBlock = 10;									
       		int endPage = startPage + pageBlock - 1;        
       		if (endPage > pageCount) 
       			endPage = pageCount;
       
       		if (startPage > 10) { %>
          			<li class="page-item"><a class="page-link" href="admin_notice_list.jsp?pageNum=<%= startPage - 10 %>">이전</a></li>
				<%}        
        		for (int i = startPage ; i <= endPage ; i++) {					
        			if(i == currentPage){
					%>
						<li class="page-item active">
		      				<a class="page-link" href="#"><%=i %><span class="sr-only">(current)</span></a>
		    			</li>
					<%        		
        			} else {
					%>
						<li class="page-item"><a class="page-link" href="admin_notice_list.jsp?pageNum=<%=i %>"><%=i %></a></li>
					<%        		
        			}
      			}      
        		if (endPage < pageCount) {  %>
        			<li class="page-item"><a class="page-link" href="admin_notice_list.jsp?pageNum=<%= startPage + 10 %>">다음</a></li>      
				<%}
    		}%>
		</ul>
	</nav>																								
</div>


<!-- 공지 등록 modal -->
<div class="modal fade" id="noticeplus" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel" style="margin-left:10px;">공지등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form method="post" name="noticeinsertform"  action="admin_notice_insert.jsp">
				<div class="modal-body" style="font-size:12px;">				
		    		<div class="row" style="margin-top:10px;">
		      			<div class="col-sm-2">제목 </div>
		      			<div class="col-sm-10">
		      				<input type="text" class="form-control" name="notice_title">
		      			</div>		      			
		    		</div>	
		    		<div class="row" style="margin-top:10px;">
		      			<div class="col-sm-2">내용 </div>
		      			<div class="col-sm-10">
		      				<textarea class="form-control" rows="8" name="notice_content"></textarea>
		      			</div>		      			
		    		</div>	
		    		<div class="row" style="margin-top:10px;">
		      			<div class="col-sm-2">상단고정 </div>
		      			<div class="col-sm-10">
		      				<input type="checkbox" name="notice_fi"> <!-- checked일 시 on으로 넘어감, 아니면 null -->
		      			</div>		      			
		    		</div>	
				</div> <!-- modal body -->
				<div class="modal-footer">				
					<button type="submit" class="btn btn-primary" style="font-size:12px;">등록</button> <!-- ★ 나중에 유효성 체크 하기. 일단 submit -->
				</div>	
			</form>
		</div>
 	</div>
</div>

<script src="/kindergarten/etc/js/parents/parents.js"></script> <!-- 필없는데 걍 놔둠, 나중에 정리  -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/kindergarten/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>  
<script src="/kindergarten/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> <!-- sweetalert -->
</body>
</html>