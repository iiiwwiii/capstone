function writeSave(noticeform){
	
	if(!noticeform.notice_title.value){
	  alert("제목을 입력하십시오");
	  noticeform.notice_title.focus();
	  return false;
	}
	
	if(!noticeform.notice_content.value){
		alert("내용을 입력하십시오");
		noticeform.notice_content.focus();
		return false;
	}
		
	noticeform.action = "teacher_notice_update_Pro.jsp";
	noticeform.submit();
	
 } 
 

 