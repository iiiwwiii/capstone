package user.admin;

import java.sql.Timestamp;

public class AdminNoticeVO {
	private int notice_num;
	private String notice_title;
	private String notice_content;
	private int notice_count;
	private boolean notice_fi;  //픽스값 - 체크박스 안할 시 0, 체크박스 체크 시 1 
	private Timestamp notice_date;
	
	
	
	public boolean isNotice_fi() {
		return notice_fi;
	}
	public void setNotice_fi(boolean notice_fi) {
		this.notice_fi = notice_fi;
	}
	public int getNotice_num() {
		return notice_num;
	}
	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public int getNotice_count() {
		return notice_count;
	}
	public void setNotice_count(int notice_count) {
		this.notice_count = notice_count;
	}
	public Timestamp getNotice_date() {
		return notice_date;
	}
	public void setNotice_date(Timestamp notice_date) {
		this.notice_date = notice_date;
	}
	
	

}
