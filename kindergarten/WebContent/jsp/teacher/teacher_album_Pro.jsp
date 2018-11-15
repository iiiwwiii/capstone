<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%@ page import="picture.ScheduleDAO"%>


<% 
int album_num = 0;
String album_title = null;
String album_content = null;

%>

<% request.setCharacterEncoding("utf-8");%>

<%

ScheduleDAO dbPro = ScheduleDAO.getInstance();

String realFolder = "";//웹 어플리케이션상의 절대 경로

//파일이 업로드되는 폴더를 지정한다.
String saveFolder = "/etc/image/teacher";
String encType = "utf-8"; //엔코딩타입
int maxSize = 5*1024*1024*6;  //최대 업로될 파일크기 5Mb

ServletContext context = getServletContext();
//현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
realFolder = context.getRealPath(saveFolder);  

try{
   MultipartRequest multi = null;
   
   //전송을 담당할 콤포넌트를 생성하고 파일을 전송한다.
   //전송할 파일명을 가지고 있는 객체, 서버상의 절대경로,최대 업로드될 파일크기, 문자코드, 기본 보안 적용
   multi = new MultipartRequest(request,realFolder,
		   maxSize,encType,new DefaultFileRenamePolicy());
   
   //Form의 파라미터 목록을 가져온다
   Enumeration<?> params = multi.getParameterNames();
  
   //파라미터를 출력한다
   while(params.hasMoreElements()){ 
      String name = (String)params.nextElement(); //전송되는 파라미터이름
      String value = multi.getParameter(name);    //전송되는 파라미터값  
      
      if(name.equals("album_num")){
    	  album_num = Integer.parseInt(value);
      }
      if(name.equals("album_title")){
    	  album_title = value;
      }
      if(name.equals("album_content")){
    	  album_content = value;
      }
      
      
   }

   //전송한 파일 정보를 가져와 출력한다
   Enumeration<?> files = multi.getFileNames();
   
   //파일 정보가 있다면
   while(files.hasMoreElements()){
      //input 태그의 속성이 file인 태그의 name 속성값 :파라미터이름
      String name = (String)files.nextElement();
   
     //서버에 저장된 파일 이름
      String filename = multi.getFilesystemName(name);
     //전송전 원래의 파일 이름
      String original = multi.getOriginalFileName(name);
   
     //전송된 파일의 내용 타입
      String type = multi.getContentType(name);
     
     if(filename != null){
    	 int result = 0;
    	  if(name.equals("pic1")){
    	    	 result = dbPro.add_picture(album_num, album_content, filename);
    	     }else if(name.equals("pic2")){
    	    	 result = dbPro.add_picture(album_num, album_content, filename);
    	     }else if(name.equals("pic3")){
    	    	 result = dbPro.add_picture(album_num, album_content, filename);
    	     }else if(name.equals("pic4")){
    	    	 result = dbPro.add_picture(album_num, album_content, filename);
    	     }else if(name.equals("pic5")){
    	    	 result = dbPro.add_picture(album_num, album_content, filename);
    	     }else if(name.equals("pic6")){
    	    	 result = dbPro.add_picture(album_num, album_content, filename);
    	     }else if(name.equals("pic7")){
    	    	 result = dbPro.add_picture(album_num, album_content, filename);;
    	     }else if(name.equals("pic8")){
    	    	 result = dbPro.add_picture(album_num, album_content, filename);
    	     }else if(name.equals("pic9")){
    	    	 result = dbPro.add_picture(album_num, album_content, filename);
    	     }else if(name.equals("pic10")){
    	    	 result = dbPro.add_picture(album_num, album_content, filename);
    	     }else if(name.equals("pic11")){
    	    	 result = dbPro.add_picture(album_num, album_content, filename);
    	     }else if(name.equals("pic12")){
    	    	 result = dbPro.add_picture(album_num, album_content, filename);
    	     }
    	  
    	  
    	  if(result == 0){
   			%>
 			
   			<script>
   			alert("성공");
   			location.href="teacher_album.jsp";
   			</script>
   			
   			<%
    	  }

     }
  
   }
}catch(IOException ioe){
 System.out.println(ioe);
}catch(Exception ex){
 System.out.println(ex);
}
%>