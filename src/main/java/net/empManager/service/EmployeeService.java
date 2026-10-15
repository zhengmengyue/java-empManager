package net.empManager.service;

import java.util.List;

import net.empManager.dao.EmployeeDao;
import net.empManager.domain.Employee;

public class EmployeeService {
	EmployeeDao dao = new EmployeeDao();

	public List<Employee> findAll() {
		return dao.findAll();
	}

	public List<Employee> findByDepartment(String department) {
		return dao.findByDepartment(department);
	}

	public List<Employee> findByName(String name) {
		return dao.findByName(name);
	}

	public Employee findByEmpId(String empId) {
		return dao.findByEmpId(empId);
	}

	public Employee findById(String id) {
		return dao.findById(id);
	}

	public boolean insert(Employee emp) {
		return dao.insert(emp);
	}

	public boolean update(Employee emp) {
		return dao.update(emp);
	}

	public boolean delete(String id) {
		return dao.delete(id);
	}
}
