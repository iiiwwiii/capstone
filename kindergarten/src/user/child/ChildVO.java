package user.child;

import java.sql.Date;
import java.sql.Timestamp;

public class ChildVO {
	private int child_num; 
	private String parents_id;
	private String child_class;
	private String child_name;
	private String child_sex;
	private Date child_birth;
	private String child_post;
	private String child_addr;
	private String child_pic;
	private String child_memo;
	private Timestamp child_date;
	
	private String parents_name;    //학부모이름  - 리스트에 같이 뿌리려다 미승인 에러나서 일단 안뿌림
	private String parents_phone;   //학부모전화번호
	
	
	
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
	public int getChild_num() {
		return child_num;
	}
	public void setChild_num(int child_num) {
		this.child_num = child_num;
	}
	public String getParents_id() {
		return parents_id;
	}
	public void setParents_id(String parents_id) {
		this.parents_id = parents_id;
	}
	public String getChild_class() {
		return child_class;
	}
	public void setChild_class(String child_class) {
		this.child_class = child_class;
	}
	public String getChild_name() {
		return child_name;
	}
	public void setChild_name(String child_name) {
		this.child_name = child_name;
	}
	public String getChild_sex() {
		return child_sex;
	}
	public void setChild_sex(String child_sex) {
		this.child_sex = child_sex;
	}

	public Date getChild_birth() {
		return child_birth;
	}
	public void setChild_birth(Date child_birth) {
		this.child_birth = child_birth;
	}
	public String getChild_post() {
		return child_post;
	}
	public void setChild_post(String child_post) {
		this.child_post = child_post;
	}
	public String getChild_addr() {
		return child_addr;
	}
	public void setChild_addr(String child_addr) {
		this.child_addr = child_addr;
	}
	public String getChild_pic() {
		return child_pic;
	}
	public void setChild_pic(String child_pic) {
		this.child_pic = child_pic;
	}
	public String getChild_memo() {
		return child_memo;
	}
	public void setChild_memo(String child_memo) {
		this.child_memo = child_memo;
	}
	public Timestamp getChild_date() {
		return child_date;
	}
	public void setChild_date(Timestamp child_date) {
		this.child_date = child_date;
	}
	
	
	
}
