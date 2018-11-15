package attend;

import java.sql.Date;

public class AlertVO {
   private String teacher_id;   
   private String alert_content;   
   private String alert_health;
   private String alert_tem;   
   private String alert_poo;   
   private String alert_sleep;   
   private String alert_food;   
   private String parents_id;   
   private Date  alert_date;   

   public String getTeacher_id() {
      return teacher_id;
   }
   public void setTeacher_id(String teacher_id) {
      this.teacher_id = teacher_id;
   }
   public String getAlert_content() {
      return alert_content;
   }
   public void setAlert_content(String alert_content) {
      this.alert_content = alert_content;
   }
   public String getAlert_health() {
      return alert_health;
   }
   public void setAlert_health(String alert_health) {
      this.alert_health = alert_health;
   }
   public String getAlert_tem() {
      return alert_tem;
   }
   public void setAlert_tem(String alert_tem) {
      this.alert_tem = alert_tem;
   }
   public String getAlert_poo() {
      return alert_poo;
   }
   public void setAlert_poo(String alert_poo) {
      this.alert_poo = alert_poo;
   }
   public String getAlert_sleep() {
      return alert_sleep;
   }
   public void setAlert_sleep(String alert_sleep) {
      this.alert_sleep = alert_sleep;
   }
   public String getAlert_food() {
      return alert_food;
   }
   public void setAlert_food(String alert_food) {
      this.alert_food = alert_food;
   }
   public String getParents_id() {
      return parents_id;
   }
   public void setParents_id(String parents_id) {
      this.parents_id = parents_id;
   }
   public Date getAlert_date() {
      return alert_date;
   }
   public void setAlert_date(Date alert_date) {
      this.alert_date = alert_date;
   }
  
}