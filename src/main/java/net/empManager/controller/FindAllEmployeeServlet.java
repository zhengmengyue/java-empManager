package net.empManager.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.empManager.domain.Employee;
import net.empManager.service.EmployeeService;

@WebServlet("/FindAllEmployeeServlet")
public class FindAllEmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FindAllEmployeeServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		EmployeeService service = new EmployeeService();
		List<Employee> employees = service.findAll();
		if (employees != null) {
			request.setAttribute("employees", employees);
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
