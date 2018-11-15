<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String notice_title = request.getParameter("notice_title");
	String notice_content = request.getParameter("notice_content");
	String notice_fi = request.getParameter("notice_fi");
	
	out.print(notice_title);
	out.print(notice_content);
	out.print(notice_fi);


%>