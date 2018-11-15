<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.child.ChildDAO" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*" %> <!--child_birth -->

<% request.setCharacterEncoding("utf-8");%>

<%
	String realFolder = "";//웹 어플리케이션상의 절대 경로
	String filename ="";
  	MultipartRequest imageUp = null; 

  	String saveFolder = "/etc/image/child";//파일이 업로드되는 폴더를 지정한다.
  	String encType = "utf-8"; //엔코딩타입
  	int maxSize = 2*1024*1024;  //최대 업로될 파일크기 5Mb
  	//현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
  	ServletContext context = getServletContext();
  	realFolder = context.getRealPath(saveFolder);  

 	try{
     	//전송을 담당할 콤포넌트를 생성하고 파일을 전송한다.
		//전송할 파일명을 가지고 있는 객체, 서버상의 절대경로,최대 업로드될 파일크기, 문자코드, 기본 보안 적용
		imageUp = new MultipartRequest(
			request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
   
		//전송한 파일 정보를 가져와 출력한다
     	Enumeration<?> files = imageUp.getFileNames();
   
     	//파일 정보가 있다면
     	while(files.hasMoreElements()){
			//input 태그의 속성이 file인 태그의 name 속성값 :파라미터이름
       		String name = (String)files.nextElement();
   
       		//서버에 저장된 파일 이름
       		filename = imageUp.getFilesystemName(name);
		}
	}catch(Exception e){
		e.printStackTrace();
}
%>

<jsp:useBean id="child" scope="page" class="user.child.ChildVO" />

<%
	String child_name = imageUp.getParameter("child_name");
	String child_sex = imageUp.getParameter("child_sex");
	String childb = imageUp.getParameter("child_birth");
	java.sql.Date child_birth=java.sql.Date.valueOf(childb); //string -> sql.date 변환 
	String child_post = imageUp.getParameter("child_post");
	String child_addr = imageUp.getParameter("child_addr");
	String child_memo = imageUp.getParameter("child_memo");
	
	child.setChild_name(child_name);
	child.setChild_sex(child_sex);
	child.setChild_birth(child_birth);
	child.setChild_post(child_post);
	child.setChild_addr(child_addr);
	child.setChild_pic(filename);
	child.setChild_memo(child_memo);
	child.setChild_date(new Timestamp(System.currentTimeMillis())); //등록일 
	
	
	ChildDAO dao = ChildDAO.getInstance();
	dao.childinsert(child);

  	response.sendRedirect("teacher_child_list.jsp");
%>