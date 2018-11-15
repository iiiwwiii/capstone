<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	Calendar cal = Calendar.getInstance();
	String strYear = request.getParameter("year");	
	String strMonth = request.getParameter("month");
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH);
	int date = cal.get(Calendar.DATE);

	if(strYear != null)
	{
		year = Integer.parseInt(strYear);
	
		month = Integer.parseInt(strMonth); 
	}else{}

	//년도/월 셋팅
	cal.set(year, month, 1);
	int startDay = cal.getMinimum(java.util.Calendar.DATE);
	int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
	int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
	int newLine = 0;

	//오늘 날짜 저장.
	Calendar todayCal = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));
%>

<html lang="ko">
<HEAD>
	<TITLE>캘린더</TITLE>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
</HEAD>
<BODY>
	<form name="calendarFrm" id="calendarFrm" action="" method="post">	
		<input type="button" onclick="javascript:location.href='./jstlex.jsp'" value="오늘"/>

				<!--날짜 네비게이션  -->

									<a href="./jstlex.jsp?year=<%=year-1%>&amp;month=<%=month%>" target="_self">
										<b>이전해</b><!-- 이전해 -->
									</a>
                    				<%if(month > 0 ){ %>
										<a href="./jstlex.jsp?year=<%=year%>&amp;month=<%=month-1%>" target="_self">
											<b>이전달</b><!-- 이전달 -->
										</a>
									<%} else {%>
                           				<b>이전달(1월)</b>	
                           			<%} %>
                           			
									<%=year%>년
                    				<%=month+1%>월
				
				                    <%if(month < 11 ){ %>
										<a href="./jstlex.jsp?year=<%=year%>&amp;month=<%=month+1%>" target="_self">
			                            	<b>다음달</b>
										</a>
									<%}else{%>
									 	<b>다음달(12월)</b>
									 <%} %>
									<a href="./jstlex.jsp?year=<%=year+1%>&amp;month=<%=month%>" target="_self">
										<b>다음해</b>
                    				</a>
								<br>
								
								<table border="0" cellspacing="1" cellpadding="1" bgcolor="#FFFFFF">
									<THEAD>
										<TR>
						       				<TD width='100px'>
						       					<DIV align="center"><font color="red">일</font></DIV>
						       				</TD>
						       				<TD width='100px'>
						       					<DIV align="center">월</DIV>
						       				</TD>
						       				<TD width='100px'>
						       					<DIV align="center">화</DIV>
						       				</TD>
						       				<TD width='100px'>
						       					<DIV align="center">수</DIV>
						       				</TD>
						       				<TD width='100px'>
						       					<DIV align="center">목</DIV>
						       				</TD>
						       				<TD width='100px'>
						       					<DIV align="center">금</DIV>
						       				</TD>
						       				<TD width='100px'>
						       					<DIV align="center"><font color="#529dbc">토</font></DIV>
						       				</TD>
										</TR>
									</THEAD>
									<TBODY>
										<TR>
				
<%
				//처음 빈공란 표시
				for(int index = 1; index < start ; index++ )		
				{
				  out.println("<TD >&nbsp;</TD>");
				  newLine++;
				}
				for(int index = 1; index <= endDay; index++)
				{
       			String color = "";
       			if(newLine == 0){color = "RED";
       			}else if(newLine == 6){color = "#529dbc";
				}else{color = "BLACK"; 
				}
		        String sUseDate = Integer.toString(year); 
		        sUseDate += Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1);
		        sUseDate += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);
		        int iUseDate = Integer.parseInt(sUseDate);
		        
       			String backColor = "#EFEFEF";

		        if(iUseDate == intToday ) {
					backColor = "#c9c9c9";
		       }
				out.println("<TD valign='top' align='left' height='92px' bgcolor='"+backColor+"' nowrap>");

%>
		       <font color='<%=color%>'>
					<%=index %>
				</font>
		<%
		       out.println("<BR>");
		       out.println(iUseDate);
		       out.println("<BR>");
		
		       //기능 제거 
		       out.println("</TD>");
		       newLine++;
		       
		       if(newLine == 7)
		       {
			         out.println("</TR>");
			         if(index <= endDay)
			         {
			           out.println("<TR>");
			         }
			         newLine=0;
			       }
				}
		
		//마지막 공란 LOOP
				while(newLine > 0 && newLine < 7)
				{
				  out.println("<TD>&nbsp;</TD>");
				  newLine++;
				}

%>
				</TR>
			</TBODY>
		</TABLE>
	</DIV>
</form>
</BODY>
</HTML>
