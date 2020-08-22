<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Stop Process</title>
</head>
<body>
<%try {
		ApplicationDB db= new ApplicationDB();
		Connection con= db.getConnection();
		String scheduleID = request.getParameter("scheduleID");
		String transitLine = request.getParameter("transitLine");
		String stationID= request.getParameter("stationID");
		String arrivalTime= request.getParameter("arrivalTime");
		String departureTime= request.getParameter("departureTime");
		String verifyStop= "SELECT * FROM ScheduledStops WHERE schedule_id= ? AND station_id=?";
		PreparedStatement ps1= con.prepareStatement(verifyStop);
		ps1.setString(1, scheduleID);
		ps1.setString(2, stationID);
		ResultSet check=ps1.executeQuery();
		if(check.first()==false){
			String verifyTime="SELECT s.arrival_date, s.departure_date FROM Schedules s WHERE s.schedule_id=?";
			PreparedStatement ps2=con.prepareStatement(verifyTime);
			ps2.setString(1,scheduleID);
			ResultSet time=ps2.executeQuery();
			if(time.first()==true){
				String arrivalDate=time.getString("arrival_date");
				String departureDate=time.getString("departure_date");
				if(arrivalTime.compareTo(arrivalDate)>0 || departureTime.compareTo(departureDate)<0){
					response.sendRedirect("addStopFailure.jsp");
				}
			}
			PreparedStatement newTuple= con.prepareStatement("INSERT INTO ScheduledStops (schedule_id, transit_name, station_id, arrival_time, departure_time) VALUES (?, ?, ?, ?, ?)");
			newTuple.setString(1, scheduleID);
			newTuple.setString(2, transitLine);
			newTuple.setString(3, stationID);
			newTuple.setString(4, arrivalTime);
			newTuple.setString(5, departureTime);
			newTuple.executeUpdate();
			response.sendRedirect("addStopSuccess.jsp");
		}
		else response.sendRedirect("addStopFailure.jsp");
		con.close();
	}
	catch (Exception error){
		out.print(error);
	}
	%>

</body>
</html>