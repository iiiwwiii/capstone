package attend;

import java.sql.Date;

public class To_teacherVO {
   private int to_num;   
   private String class_name;
   private String parents_id;   
   private String teacher_id;
   private int absence;
   private Date start_date;
   private Date end_date;
   private String to_content;
   public int getTo_num() {
      return to_num;
   }
   public void setTo_num(int to_num) {
      this.to_num = to_num;
   }
   public String getClass_name() {
      return class_name;
   }
   public void setClass_name(String class_name) {
      this.class_name = class_name;
   }
   public String getParents_id() {
      return parents_id;
   }
   public void setParents_id(String parents_id) {
      this.parents_id = parents_id;
   }
   public String getTeacher_id() {
      return teacher_id;
   }
   public void setTeacher_id(String teacher_id) {
      this.teacher_id = teacher_id;
   }
   public int getAbsence() {
      return absence;
   }
   public void setAbsence(int absence) {
      this.absence = absence;
   }
   public Date getStart_date() {
      return start_date;
   }
   public void setStart_date(Date start_date) {
      this.start_date = start_date;
   }
   public Date getEnd_date() {
      return end_date;
   }
   public void setEnd_date(Date end_date) {
      this.end_date = end_date;
   }
   public String getTo_content() {
      return to_content;
   }
   public void setTo_content(String to_content) {
      this.to_content = to_content;
   }
   
   

}