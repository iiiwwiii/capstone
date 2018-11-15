package user.teacher;

import java.sql.Date;
import java.sql.Time;

public class TeacherAttendanceVO {
		/*create table attendance(
 attendance_num int auto_increment primary key comment '출석번호',
 child_num int comment '원아번호',
 attendance_date date comment '출석일',
 attendance_start_time time comment '등원시간',
 attendance_end_time time comment '하원시간',
 attendance_absence boolean comment '결석'
); */
	
	private int attendance_num;
	private int child_num;
	private Date attendance_date;
	private Time attendance_start_time;
	private Time attendance_end_time;
	private boolean attendce_absence;
	
	
	public int getAttendance_num() {
		return attendance_num;
	}
	public void setAttendance_num(int attendance_num) {
		this.attendance_num = attendance_num;
	}
	public int getChild_num() {
		return child_num;
	}
	public void setChild_num(int child_num) {
		this.child_num = child_num;
	}
	public Date getAttendance_date() {
		return attendance_date;
	}
	public void setAttendance_date(Date attendance_date) {
		this.attendance_date = attendance_date;
	}
	public Time getAttendance_start_time() {
		return attendance_start_time;
	}
	public void setAttendance_start_time(Time attendance_start_time) {
		this.attendance_start_time = attendance_start_time;
	}
	public Time getAttendance_end_time() {
		return attendance_end_time;
	}
	public void setAttendance_end_time(Time attendance_end_time) {
		this.attendance_end_time = attendance_end_time;
	}
	public boolean isAttendce_absence() {
		return attendce_absence;
	}
	public void setAttendce_absence(boolean attendce_absence) {
		this.attendce_absence = attendce_absence;
	}
	
	
}
