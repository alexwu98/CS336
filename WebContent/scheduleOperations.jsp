<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Schedule Operations</title>
</head>
<body>
	Schedule Operations
	<br>
	<br>
	<form method="get" action="editSchedule.jsp">
		<input type="submit" value="Edit Schedules">
	</form>
	<br>
	<form method="get" action="addSchedule.jsp">
		<input type="submit" value="Add Schedules">
	</form>
	<br>
	<form method="get" action="deleteSchedule.jsp">
		<input type="submit" value="Delete Schedules">
	</form>
	<br>
	<br> Current Available Schedules
	<br>
	<br>
	<table border>
	<tr bgcolor="#A52A2A">
		<td><b>Schedule ID</b></td>
		<td><b>Transit Line</b></td>
		<td><b>Train ID</b></td>
		<td><b>Origin Departure Time</b></td>
		<td><b>Destination Arrival Time</b></td>
		<td><b>Schedule Fare</b></td>
	</tr>




	<%
		try {
			ApplicationDB app = new ApplicationDB();
			Connection con = app.getConnection();
			String scheduleInfo = "SELECT s.schedule_id, s.transit_name, s.train_id, s.departure_date, s.arrival_date, s.fare FROM Schedules s ORDER BY s.schedule_id";
			PreparedStatement ps = con.prepareStatement(scheduleInfo);
			ResultSet result = ps.executeQuery();
			while (result.next()) {
	%>
	<tr bgcolor="#DEB887">
		<td><%=result.getString("schedule_id")%></td>
		<td><%=result.getString("transit_name")%></td>
		<td><%=result.getString("train_id")%></td>
		<td><%=result.getString("departure_date")%></td>
		<td><%=result.getString("arrival_date")%></td>
		<td><%=result.getString("fare")%></td>
	</tr>
	<%
		}
			con.close();
		} catch (Exception error) {
			out.print(error);
		}
	%>
	</table>
</body>
</html>