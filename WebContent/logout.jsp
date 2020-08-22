<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Logout</title>
</head>
<body><% if ((Boolean)session.getAttribute("active")==true) {
	session.invalidate(); response.sendRedirect("homeLogin.jsp"); } %>
</body>
</html>