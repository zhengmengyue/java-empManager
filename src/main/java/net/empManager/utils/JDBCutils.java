package net.empManager.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCutils {

	public static Connection getConnection() throws ClassNotFoundException, SQLException {
		
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/empmngs?characterEncoding=utf-8";
		String username = "root";
		String password = "123456";
		
		Connection conn=DriverManager.getConnection(url, username, password);
		return conn;
	}
	
	public static void release(Statement stmt,Connection conn) {
		if(stmt!=null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			stmt=null;
		}
		if(conn!=null) {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			conn=null;
		}
	}
public static void release(ResultSet rs,Statement stmt,Connection conn) {
	if(rs!=null) {
		try {
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		rs=null;
	}
	release(stmt,conn);
}
}
