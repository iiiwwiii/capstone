package user.teacher;

import java.sql.Date;

public class TeacherFoodVO {
	// test AdminFoodVO - 사진X - join - foodnum
	// table - foodtest
	private int food_num;
	private Date food_date;
	private String food_image;

	// table - foodmenu + foodnum fk
	private int menu_num;
	private String menu_name;

	public int getFood_num() {
		return food_num;
	}

	public void setFood_num(int food_num) {
		this.food_num = food_num;
	}

	public Date getFood_date() {
		return food_date;
	}

	public void setFood_date(Date food_date) {
		this.food_date = food_date;
	}

	public String getFood_image() {
		return food_image;
	}

	public void setFood_image(String food_image) {
		this.food_image = food_image;
	}

	public int getMenu_num() {
		return menu_num;
	}

	public void setMenu_num(int menu_num) {
		this.menu_num = menu_num;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
}
