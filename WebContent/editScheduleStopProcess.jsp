<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Schedule Stop Process</title>
</head>
<body>
<%try {
		ApplicationDB db= new ApplicationDB();
		Connection con= db.getConnection();
		int commaCheck=0;
		String scheduleID = request.getParameter("scheduleID");
		String stationID= request.getParameter("stationID");
		String arrivalTime= request.getParameter("arrival");
		String departureTime= request.getParameter("departure");
		String verifyStop= "SELECT * FROM ScheduledStops WHERE schedule_id= ? AND station_id=?";
		PreparedStatement ps1= con.prepareStatement(verifyStop);
		ps1.setString(1, scheduleID);
		ps1.setString(2, stationID);
		ResultSet check=ps1.executeQuery();
		if(check.first()==true){
			String editStatement = "UPDATE ScheduledStops SET ";
			String whereStatement= "WHERE schedule_id= "+scheduleID+" AND station_id= "+stationID;
			if(arrivalTime.isEmpty()==false){
				editStatement=editStatement+" arrival_time = '"+arrivalTime+"'";
				commaCheck=1;
			}
			if(departureTime.isEmpty()==false){
				if(commaCheck==1){
					editStatement=editStatement+",";
				}
				editStatement=editStatement+" departure_time= '"+departureTime+"'";
			}
			editStatement=editStatement+whereStatement;
			PreparedStatement ps2=con.prepareStatement(editStatement);
			ps2.executeUpdate();
			String odCheck="SELECT t.origin, t.destination FROM TransitLines t, Schedules s WHERE s.schedule_id=? AND s.transit_name=t.transit_name";
			PreparedStatement ps3=con.prepareStatement(odCheck);
			ps3.setString(1, scheduleID);
			ResultSet od=ps3.executeQuery();
			if(od.first()){
				String origin=od.getString("origin");
				String destination=od.getString("destination");
				if(stationID.equals(origin)){
					PreparedStatement o=con.prepareStatement("UPDATE Schedules SET Schedules.departure_date=? WHERE Schedules.schedule_id=?");
					o.setString(1, departureTime);
					o.setString(2, scheduleID);
					o.executeUpdate();
				}
				else if(stationID.equals(destination)){
					PreparedStatement d=con.prepareStatement("UPDATE Schedules SET Schedules.arrival_date=? WHERE Schedules.schedule_id=?");
					d.setString(1, arrivalTime);
					d.setString(2, scheduleID);
					d.executeUpdate();
				}
			}
			response.sendRedirect("editScheduleSuccess.jsp");
		}
		else response.sendRedirect("editScheduleFailure.jsp");
		con.close();
	}

	catch (Exception error){
		out.print(error);
	}
	%>
</body>
</html>