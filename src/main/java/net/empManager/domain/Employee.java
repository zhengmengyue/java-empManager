package net.empManager.domain;

import java.util.Date;

public class Employee {
	private int id;
	private String empId;
	private String name;
	private String password;
	private String email;
	private String department;
	private Date birthday;

	public Employee() {
		super();
	}

	public int getId() { return id; }
	public void setId(int id) { this.id = id; }

	public String getEmpId() { return empId; }
	public void setEmpId(String empId) { this.empId = empId; }

	public String getName() { return name; }
	public void setName(String name) { this.name = name; }

	public String getPassword() { return password; }
	public void setPassword(String password) { this.password = password; }

	public String getEmail() { return email; }
	public void setEmail(String email) { this.email = email; }

	public String getDepartment() { return department; }
	public void setDepartment(String department) { this.department = department; }

	public Date getBirthday() { return birthday; }
	public void setBirthday(Date birthday) { this.birthday = birthday; }
}
