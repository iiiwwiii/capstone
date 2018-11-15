<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.admin.AdminDAO" %>
<%@ page import = "user.admin.AdminFoodVO" %>
<% request.setCharacterEncoding("utf-8");%>
<%
	String[] num = request.getParameterValues("menunum");
	String[] name = request.getParameterValues("menuname");

	//넘어옴 - 음식이름들.. update문 어케쓰지
	//update fooodmenu set menuname = ? where menunum = ?   해서 자바단에서 돌리면 될것같은데 배열 두개 받아서 두개 넘겨가지고 
	//for(int i=0; i<name.length; i++){
	//	out.println(num[i]);
	//	out.println(name[i]);
	//} ==> 테스트완료 ( 13 짜장면 14 탕수육 이렇게 넘어옴 )
			
	AdminDAO dao = AdminDAO.getInstance();
	dao.menuupdate(num, name);   
	
	response.sendRedirect("admin_food_list.jsp");
	

%>