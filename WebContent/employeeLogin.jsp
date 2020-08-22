<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee Login</title>
</head>
<body>
	<%try {
		ApplicationDB db= new ApplicationDB();
		Connection con= db.getConnection();
		String user = request.getParameter("username");
		String pw = request.getParameter("password");
		String verify = "SELECT * FROM Employees WHERE username= ? AND password = ?";
		PreparedStatement ps = con.prepareStatement(verify);
		ps.setString(1, user);
		ps.setString(2, pw);
		ResultSet result=ps.executeQuery();
		if(result.first()){
			session.setAttribute("active", true);
			session.setAttribute("firstname", result.getString("first_name"));
			session.setAttribute("ssn", result.getString("ssn"));
			if((int)result.getInt("isAdmin") == 1){
				response.sendRedirect("adminSuccess.jsp");}
			else{
				response.sendRedirect("employeeLoginSuccess.jsp");}
		}
		else{
			response.sendRedirect("loginFailed.jsp");}
	db.closeConnection(con);
	}
	catch (Exception error){
		out.print(error);
	}
	%>
</body>
</html>