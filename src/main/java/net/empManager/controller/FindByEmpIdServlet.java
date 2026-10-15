package net.empManager.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.empManager.domain.Employee;
import net.empManager.service.EmployeeService;

@WebServlet("/FindByEmpIdServlet")
public class FindByEmpIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FindByEmpIdServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String empId = request.getParameter("empId");
		EmployeeService service = new EmployeeService();
		Employee employee = service.findByEmpId(empId);
		if (employee != null) {
			request.setAttribute("employee", employee);
		} else {
			request.setAttribute("empIdError", "请输入正确的员工工号！");
		}
		request.setAttribute("searchEmpId", empId);
		request.setAttribute("allEmployees", service.findAll());
		request.getRequestDispatcher("find.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
