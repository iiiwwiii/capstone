package user.teacher;

import java.sql.Timestamp;

public class TeacherVO {
	private String teacher_id;
	private String teacher_pwd;
	private String teacher_class;
	private String teacher_name;
	private String teacher_phone;
	private String teacher_post;
	private String teacher_addr;
	private String teacher_pic; 
	private Timestamp teacher_date; //나중에 datetime으로 변경 
	
	public String getTeacher_id() {
		return teacher_id;
	}
	public void setTeacher_id(String teacher_id) {
		this.teacher_id = teacher_id;
	}
	public String getTeacher_pwd() {
		return teacher_pwd;
	}
	public void setTeacher_pwd(String teacher_pwd) {
		this.teacher_pwd = teacher_pwd;
	}
	public String getTeacher_class() {
		return teacher_class;
	}
	public void setTeacher_class(String teacher_class) {
		this.teacher_class = teacher_class;
	}
	public String getTeacher_name() {
		return teacher_name;
	}
	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}
	public String getTeacher_phone() {
		return teacher_phone;
	}
	public void setTeacher_phone(String teacher_phone) {
		this.teacher_phone = teacher_phone;
	}
	public String getTeacher_post() {
		return teacher_post;
	}
	public void setTeacher_post(String teacher_post) {
		this.teacher_post = teacher_post;
	}
	public String getTeacher_addr() {
		return teacher_addr;
	}
	public void setTeacher_addr(String teacher_addr) {
		this.teacher_addr = teacher_addr;
	}
	public String getTeacher_pic() {
		return teacher_pic;
	}
	public void setTeacher_pic(String teacher_pic) {
		this.teacher_pic = teacher_pic;
	}
	public Timestamp getTeacher_date() {
		return teacher_date;
	}
	public void setTeacher_date(Timestamp teacher_date) {
		this.teacher_date = teacher_date;
	}
	
	 
	
}
