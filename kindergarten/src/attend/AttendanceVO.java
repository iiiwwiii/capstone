package attend;

import java.sql.Date;
import java.sql.Time;

public class AttendanceVO {
   private int child_num;
   private Date attendance_date;
   private Time attendance_start_time;         
   private Time attendance_end_time;
   private int attendance_absence;
   private String to_teacher;
 
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
   
   public int getAttendance_absence() {
   return attendance_absence;
}
public void setAttendance_absence(int attendance_absence) {
   this.attendance_absence = attendance_absence;
}
public String getTo_teacher() {
      return to_teacher;
   }
   public void setTo_teacher(String to_teacher) {
      this.to_teacher = to_teacher;
   }

}