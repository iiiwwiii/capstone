package user.teacher;

import java.sql.Date;

public class TeacherCalendarVO {
	private int calendar_num;
	private Date calendar_start_date;
	private Date calendar_end_date;
	private String calendar_title;
	
	public int getCalendar_num() {
		return calendar_num;
	}
	public void setCalendar_num(int calendar_num) {
		this.calendar_num = calendar_num;
	}
	public Date getCalendar_start_date() {
		return calendar_start_date;
	}
	public void setCalendar_start_date(Date calendar_start_date) {
		this.calendar_start_date = calendar_start_date;
	}
	public Date getCalendar_end_date() {
		return calendar_end_date;
	}
	public void setCalendar_end_date(Date calendar_end_date) {
		this.calendar_end_date = calendar_end_date;
	}
	public String getCalendar_title() {
		return calendar_title;
	}
	public void setCalendar_title(String calendar_title) {
		this.calendar_title = calendar_title;
	}
}
