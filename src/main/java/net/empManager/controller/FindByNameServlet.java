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

@WebServlet("/FindByNameServlet")
public class FindByNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		EmployeeService service = new EmployeeService();
		List<Employee> employees = service.findByName(name);
		if (employees == null || employees.isEmpty()) {
			request.setAttribute("nameError", "请输入正确的员工姓名！");
		} else {
			request.setAttribute("employees", employees);
		}
		request.setAttribute("searchName", name);
		request.setAttribute("allEmployees", service.findAll());
		request.getRequestDispatcher("find.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
