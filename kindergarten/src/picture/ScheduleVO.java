package picture;

import java.sql.*;

public class ScheduleVO {
	private int schedule_num;
	private String class_name;
	private Date schedule_date;
	private Time schedule_start_time;
	private Time schedule_end_time;
	private String schedule_title;
	private String schedule_content;
	private String writer;
	
	public int getSchedule_num() {
		return schedule_num;
	}
	public void setSchedule_num(int schedule_num) {
		this.schedule_num = schedule_num;
	}
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public Date getSchedule_date() {
		return schedule_date;
	}
	public void setSchedule_date(Date schedule_date) {
		this.schedule_date = schedule_date;
	}
	public Time getSchedule_start_time() {
		return schedule_start_time;
	}
	public void setSchedule_start_time(Time schedule_start_time) {
		this.schedule_start_time = schedule_start_time;
	}
	public Time getSchedule_end_time() {
		return schedule_end_time;
	}
	public void setSchedule_end_time(Time schedule_end_time) {
		this.schedule_end_time = schedule_end_time;
	}
	public String getSchedule_title() {
		return schedule_title;
	}
	public void setSchedule_title(String schedule_title) {
		this.schedule_title = schedule_title;
	}
	public String getSchedule_content() {
		return schedule_content;
	}
	public void setSchedule_content(String schedule_content) {
		this.schedule_content = schedule_content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
}
