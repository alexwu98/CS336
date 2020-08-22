<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
</head>
<body>
	Register for a customer account!
	<br>
	<br>
	<form action="customerRegister.jsp" method="post">
		Email Address: <input type="text" name="email" required> <br> *Max 50 Characters
		<br>
		All of the following fields can be a maximum of 20 characters long <br>
		Username: <input type="text" name="username" required> <br> 
		Password: <input type="password" name="password" required> <br>
		First Name: <input type="text" name="fname" required> <br>
		Last Name: <input type="text" name="lname" required> <br>
		<input type="submit" value="Submit">
	</form>
	<br>
	<br>
	Already have an account? <a href=homeLogin.jsp> Login </a>

</body>
</html>