package net.empManager.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import net.empManager.domain.Employee;
import net.empManager.utils.JDBCutils;

public class EmployeeDao {

	// 查询所有员工信息
	public List<Employee> findAll() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Employee> list = new ArrayList<Employee>();
		try {
			conn = JDBCutils.getConnection();
			String sql = "SELECT * FROM employees";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(mapRow(rs));
			}
			return list;
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCutils.release(rs, pstmt, conn);
		}
		return null;
	}

	// 按部门查询员工
	public List<Employee> findByDepartment(String department) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Employee> list = new ArrayList<Employee>();
		try {
			conn = JDBCutils.getConnection();
			String sql = "SELECT * FROM employees WHERE department = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, department);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(mapRow(rs));
			}
			return list;
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCutils.release(rs, pstmt, conn);
		}
		return null;
	}

	// 按姓名查询员工（支持重名，返回列表）
	public List<Employee> findByName(String name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Employee> list = new ArrayList<Employee>();
		try {
			conn = JDBCutils.getConnection();
			String sql = "SELECT * FROM employees WHERE name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(mapRow(rs));
			}
			return list;
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCutils.release(rs, pstmt, conn);
		}
		return null;
	}

	// 按工号查询员工
	public Employee findByEmpId(String empId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = JDBCutils.getConnection();
			String sql = "SELECT * FROM employees WHERE emp_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, empId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return mapRow(rs);
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCutils.release(rs, pstmt, conn);
		}
		return null;
	}

	// 按主键 id 查询员工
	public Employee findById(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = JDBCutils.getConnection();
			String sql = "SELECT * FROM employees WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(id));
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return mapRow(rs);
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCutils.release(rs, pstmt, conn);
		}
		return null;
	}

	// 新增员工
	public boolean insert(Employee emp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = JDBCutils.getConnection();
			String sql = "INSERT INTO employees(emp_id, name, password, email, department, birthday) VALUES(?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, emp.getEmpId());
			pstmt.setString(2, emp.getName());
			pstmt.setString(3, emp.getPassword());
			pstmt.setString(4, emp.getEmail());
			pstmt.setString(5, emp.getDepartment());
			pstmt.setString(6, new SimpleDateFormat("yyyy-MM-dd").format(emp.getBirthday()));
			return pstmt.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCutils.release(pstmt, conn);
		}
		return false;
	}

	// 修改员工信息
	public boolean update(Employee emp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = JDBCutils.getConnection();
			String sql = "UPDATE employees SET emp_id=?, name=?, password=?, email=?, department=?, birthday=? WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, emp.getEmpId());
			pstmt.setString(2, emp.getName());
			pstmt.setString(3, emp.getPassword());
			pstmt.setString(4, emp.getEmail());
			pstmt.setString(5, emp.getDepartment());
			pstmt.setString(6, new SimpleDateFormat("yyyy-MM-dd").format(emp.getBirthday()));
			pstmt.setInt(7, emp.getId());
			return pstmt.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCutils.release(pstmt, conn);
		}
		return false;
	}

	// 删除员工
	public boolean delete(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = JDBCutils.getConnection();
			String sql = "DELETE FROM employees WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(id));
			return pstmt.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCutils.release(pstmt, conn);
		}
		return false;
	}

	// 将 ResultSet 当前行映射为 Employee 对象
	private Employee mapRow(ResultSet rs) throws SQLException {
		Employee emp = new Employee();
		emp.setId(rs.getInt("id"));
		emp.setEmpId(rs.getString("emp_id"));
		emp.setName(rs.getString("name"));
		emp.setPassword(rs.getString("password"));
		emp.setEmail(rs.getString("email"));
		emp.setDepartment(rs.getString("department"));
		emp.setBirthday(rs.getDate("birthday"));
		return emp;
	}
}
