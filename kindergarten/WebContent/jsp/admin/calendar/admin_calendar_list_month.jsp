<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.admin.AdminCalendarVO" %>
<%@ page import = "user.admin.AdminDAO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.sql.Date"%> 
<%
	String month = request.getParameter("monthid"); //해서 month만 찍으면 잘 나옴.
	//month 가 1월이면 1, 12월이면 12 이렇게 나옴. 전체면 전체리스트 나옴. 그럼 이걸 sql문에 넣기 위해 작업 해 주어야 함
	int monthcount = 0; 
	Date dal;
	if(month.length()==1){ 
		month = "0"+month;  
	}
	if(month.length()==2){ //select * from calendar where calendar_start_date like '2018-08%'; --> 하면 나옴.  ==> 이걸 2018-08-00으로 만들었음 
		month = "2018-"+month; //뒤에 -00 붙일 필요 없음. 위 sql문 나오니까 
		//dal = java.sql.Date.valueOf(month); - 이것만 지우면 잘 나옴 ㅠㅠ 2018-02-00으로 ㅠㅠ 내가볼땐 스트링으로 넘겨서 
	}
	 
	
	//Date d = java.sql.Date.valueOf(month);
	//==> month 찍으면 전체는 전체리스트, 1월은 2018-01, 12월은 2018-12 로 나옴. 
	
	//자바단으로 보내기 전에 0 붙이기 작업 여기서할건지 자바단에서 할건지 고르기 ==> 여기부터 1019에 진행 
	List<AdminCalendarVO> calendarMonthList = null;  
	  
	AdminDAO dao = AdminDAO.getInstance();												
	monthcount = dao.calendarMonthCount(month);       
   
	
	if (monthcount == 0){
		
%>

<div class="alert alert-info" role="alert" style="margin-top:20px;">
  등록된 유치원 일정이 없습니다. 
</div>


<% 
		
	}else if (monthcount > 0) {																		
		calendarMonthList = dao.calendarMonthList(month);								
	

	  
	
	
%>  

일정 수 : <%=monthcount %><br>
		<table class="table table-bordered">
			<colgroup> 
				<col width="10%">	
				<col width="50%">	
				<col width="40%">				
			</colgroup>
			<thead>			
				<tr>
					<td>번호(pk)</td>
					<td>일자</td>
					<td>내용</td>
				</tr>
			</thead>
			<tbody>	
			
			<%for (int i = 0 ; i < calendarMonthList.size(); i++) {	
				
				AdminCalendarVO notice = calendarMonthList.get(i);	
			%>	
			
			
			<tr>
				<td><%=notice.getCalendar_num() %>  </td>
				<td><%=notice.getCalendar_start_date() %> ~ <%=notice.getCalendar_end_date() %></td>
				<td><%=notice.getCalendar_title() %></td>
			</tr>
			<%}
			}%> 
			
		</tbody>
		
	</table>	
	
	
