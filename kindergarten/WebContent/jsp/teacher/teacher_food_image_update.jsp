<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="user.teacher.TeacherDAO"%>

<%
	request.setCharacterEncoding("utf-8");

	TeacherDAO dao = TeacherDAO.getInstance();

	String realFolder = "";//웹 어플리케이션상의 절대 경로
	String filename = "";
	MultipartRequest imageUp = null;

	String saveFolder = "/etc/image/teacher";//파일이 업로드되는 폴더를 지정한다.
	String encType = "utf-8"; //엔코딩타입
	int maxSize = 2 * 1024 * 1024; //최대 업로될 파일크기 5Mb
	//현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
	ServletContext context = getServletContext();
	realFolder = context.getRealPath(saveFolder);

	try {
		//전송을 담당할 콤포넌트를 생성하고 파일을 전송한다.
		//전송할 파일명을 가지고 있는 객체, 서버상의 절대경로,최대 업로드될 파일크기, 문자코드, 기본 보안 적용
		imageUp = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

		//전송한 파일 정보를 가져와 출력한다
		Enumeration<?> files = imageUp.getFileNames();

		//파일 정보가 있다면
		while (files.hasMoreElements()) {
			//input 태그의 속성이 file인 태그의 name 속성값 :파라미터이름
			String name = (String) files.nextElement();

			//서버에 저장된 파일 이름
			filename = imageUp.getFilesystemName(name);
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>

<jsp:useBean id="food" scope="page" class="user.teacher.TeacherFoodVO" />

<%
	food.setFood_image(filename); //이미지만 update임

	//String o = request.getParameter("foodnum");/// -> 이건 됨 
	//out.println("번호:"+o);  

	String food_num = imageUp.getParameter("food_num");
	int fn = Integer.parseInt(food_num);

	food.setFood_num(fn);

	dao.foodImageUpdate(food);

	response.sendRedirect("teacher_food_list.jsp");
%>