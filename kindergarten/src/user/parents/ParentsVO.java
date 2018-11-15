package user.parents;

import java.sql.*;

public class ParentsVO {		
	private String parents_id;		//parents, parents_confirm
	private String parents_pwd;		//parents
	private String parents_name;	//parents	
	private String parents_phone;	//parents
	private String parents_post;	//parents			
	private String parents_addr;	//parents			
	private Timestamp parents_date;	//parents
	private boolean parents_app;	//parents
	
	private String con_child_name;   //parents_confirm
	private String con_child_class;  //parents_confirm
	
	private String teacher_name; 	//teacher
	
	public String getTeacher_name() {
		return teacher_name;
	}
	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}
	public String getCon_child_name() {
		return con_child_name;
	}
	public void setCon_child_name(String con_child_name) {
		this.con_child_name = con_child_name;
	}
	public String getCon_child_class() {
		return con_child_class;
	}
	public void setCon_child_class(String con_child_class) {
		this.con_child_class = con_child_class;
	}
	public String getParents_id() {
		return parents_id;
	}
	public void setParents_id(String parents_id) {
		this.parents_id = parents_id;
	}
	public String getParents_pwd() {
		return parents_pwd;
	}
	public void setParents_pwd(String parents_pwd) {
		this.parents_pwd = parents_pwd;
	}
	public String getParents_name() {
		return parents_name;
	}
	public void setParents_name(String parents_name) {
		this.parents_name = parents_name;
	}
	public String getParents_phone() {
		return parents_phone;
	}
	public void setParents_phone(String parents_phone) {
		this.parents_phone = parents_phone;
	}
	public String getParents_post() {
		return parents_post;
	}
	public void setParents_post(String parents_post) {
		this.parents_post = parents_post;
	}
	public String getParents_addr() {
		return parents_addr;
	}
	public void setParents_addr(String parents_addr) {
		this.parents_addr = parents_addr;
	}
	public Timestamp getParents_date() {
		return parents_date;
	}
	public void setParents_date(Timestamp parents_date) {
		this.parents_date = parents_date;
	}
	public boolean isParents_app() {
		return parents_app;
	}
	public void setParents_app(boolean parents_app) {
		this.parents_app = parents_app;
	}	
	
	

}
