package net.empManager.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.empManager.domain.Employee;
import net.empManager.service.EmployeeService;

@WebServlet("/InsertEmployeeServlet")
public class InsertEmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public InsertEmployeeServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		Employee employee = new Employee();
		String empId = request.getParameter("empId");
		String empName = request.getParameter("empName");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String department = request.getParameter("department");
		String birthday = request.getParameter("birthday");
		Date date_birthday = new Date();
		try {
			date_birthday = new SimpleDateFormat("yyyy-MM-dd").parse(birthday);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		employee.setEmpId(empId);
		employee.setName(empName);
		employee.setPassword(password);
		employee.setEmail(email);
		employee.setDepartment(department);
		employee.setBirthday(date_birthday);

		EmployeeService service = new EmployeeService();
		boolean isSuccess = service.insert(employee);
		if (isSuccess) {
			request.getRequestDispatcher("FindAllEmployeeServlet").forward(request, response);
		} else {
			request.getRequestDispatcher("insert_fail.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
