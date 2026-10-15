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

@WebServlet("/UpdateEmployeeServlet")
public class UpdateEmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateEmployeeServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		String id = request.getParameter("id");
		String empId = request.getParameter("empId");
		String name = request.getParameter("name");
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

		Employee employee = new Employee();
		employee.setId(Integer.parseInt(id));
		employee.setEmpId(empId);
		employee.setName(name);
		employee.setPassword(password);
		employee.setEmail(email);
		employee.setDepartment(department);
		employee.setBirthday(date_birthday);

		EmployeeService service = new EmployeeService();
		boolean isSuccess = service.update(employee);
		if (isSuccess) {
			request.getRequestDispatcher("FindAllEmployeeServlet").forward(request, response);
		} else {
			response.sendRedirect("FindAllEmployeeServlet");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
