<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="picture.ScheduleDAO" %>
<%@ page import="picture.ScheduleVO" %>
<%@ page import="java.util.List" %>
	
<% request.setCharacterEncoding("utf-8");%>

<% 
	String search_schedule = null;
	if(request.getParameter("search_schedule") != null){
		search_schedule = request.getParameter("search_schedule");
	}
	
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
			    <td scope="col"><a href="teacher_album_Form.jsp?schedule_title=<%= schedule.getSchedule_title() %>&album_num=<%= schedule.getSchedule_num()%>"><%= schedule.getSchedule_title() %></a></td>
			</tr>
		</tbody>
<% 
		}
	}
%>