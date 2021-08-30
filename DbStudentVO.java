package homework;

public class DbStudentVO {
	private String studno;
	private String name;
	private String grade;
	private Double height;
	
	
	
	public String getStudno() {
		return studno;
	}



	public void setStudno(String studno) {
		this.studno = studno;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getGrade() {
		return grade;
	}



	public void setGrade(String grade) {
		this.grade = grade;
	}
	



	public Double getHeight() {
		return height;
	}



	public void setHeight(Double height) {
		this.height = height;
	}



	@Override
	public String toString() {
		return "DbstudentVo [grade=" + grade + ", height=" + height + ", name=" + name + ", studno=" + studno+ "]";
	}
	
	
	
	
	
	
	
	

}
