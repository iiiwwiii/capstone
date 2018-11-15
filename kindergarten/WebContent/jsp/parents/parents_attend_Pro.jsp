<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="attend.AttendanceDAO"%>
<%@ page import="attend.To_teacherVO"%>

<jsp:useBean id="to_teacher" scope="page" class="attend.To_teacherVO">
   <jsp:setProperty name="to_teacher" property="parents_id"/>
   <jsp:setProperty name="to_teacher" property="absence"/>
   <jsp:setProperty name="to_teacher" property="to_content"/>
</jsp:useBean>

[
<%
   AttendanceDAO dbPro = AttendanceDAO.getInstance();
   String start_date = null, end_date = null;
   if(request.getParameter("start_date") != null && request.getParameter("end_date") != null){
      start_date = request.getParameter("start_date");
      end_date = request.getParameter("end_date");
      to_teacher.setStart_date(java.sql.Date.valueOf(start_date));
      to_teacher.setEnd_date(java.sql.Date.valueOf(end_date));
   }
   
   
   

   //System.out.println(to_teacher.getStart_date());
   To_teacherVO to_teacher1 = null;
   int result = dbPro.insert_to_teacher(to_teacher);
   
   if(result == 0){
      List<To_teacherVO> to_teacherList = dbPro.get_to_teacher(to_teacher.getParents_id());
      if(to_teacherList != null){
         for(int i=0; i<to_teacherList.size()-1; i++){
            to_teacher1 = to_teacherList.get(i);
            %>
            {
            "to_num" : "<%= to_teacher1.getTo_num() %>",
            "class_name" : "<%= to_teacher1.getClass_name() %>",
            "parents_id" : "<%= to_teacher1.getParents_id() %>",
            "teacher_id" : "<%= to_teacher1.getTeacher_id() %>",
            "absence" : "<%= to_teacher1.getAbsence() %>",
            "start_date" : "<%= to_teacher1.getStart_date() %>",
            "end_date" : "<%= to_teacher1.getEnd_date() %>",
            "to_content" : "<%= to_teacher1.getTo_content() %>"
            },
            <%
         }
         
         to_teacher1 = to_teacherList.get(to_teacherList.size()-1);
         %>
         {
            "to_num" : "<%= to_teacher1.getTo_num() %>",
            "class_name" : "<%= to_teacher1.getClass_name() %>",
            "parents_id" : "<%= to_teacher1.getParents_id() %>",
            "teacher_id" : "<%= to_teacher1.getTeacher_id() %>",
            "absence" : "<%= to_teacher1.getAbsence() %>",
            "start_date" : "<%= to_teacher1.getStart_date() %>",
            "end_date" : "<%= to_teacher1.getEnd_date() %>",
            "to_content" : "<%= to_teacher1.getTo_content() %>"
         }
         <%
      }
   }else if (result == 1){
      out.println("실패");
   }
   
%>
]





