<%@page import="com.vast.vo.TicketDetails"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.Set"%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Ticket Details</title>
<link rel="stylesheet" href="bus.css">
</head>
<body>
	<header>
		<div class="header-class">
			<div class="logo">
				<span style="color: red;">Get</span> <span class="trusted">Bus-y</span>
			</div>
			<div
				style="font-family: sans-serif; font-size: xx-large; color: coral; font-weight: 800">
				WELCOME</div>
			<%
			if (null == session.getAttribute("login")) {
			%>
			<a href="login" class="login">Login</a>
			<%
			} else {
			%>
			<h3>User ID : ${sessionScope.login.userName}</h3>
			<%
			}
			%>
		</div>
	</header>

	<%
	// Retrieve the ticket details from the request
	Set<TicketDetails> tickets = (Set<TicketDetails>) request.getAttribute("ticketDeetail");
	String errorMsg = (String) request.getAttribute("res");
	%>

	<div class="container">
		<%
		if (errorMsg != null) {
		%>
		<p style="color: red; text-align: center;"><%=errorMsg%></p>
		<%
		} else if (tickets != null && !tickets.isEmpty()) {
		for (TicketDetails ticket : tickets) {
		%>
		<div class="ticket-detail"
			style="border: 1px solid #ccc; padding: 20px; margin: 10px;">
			<h3>Ticket Information</h3>
			<p>
				<strong>Bus ID:</strong>
				<%=ticket.getBusId()%></p>
			<p>
				<strong>Bus Name:</strong>
				<%=ticket.getBusName()%></p>
			<p>
				<strong>Departure:</strong>
				<%=ticket.getDeparture()%></p>
			<p>
				<strong>Arrival:</strong>
				<%=ticket.getArrival()%></p>
			<p>
				<strong>Seat Number:</strong>
				<%=ticket.getSeatNumber()%></p>
			<p>
				<strong>Passenger Name:</strong>
				<%=ticket.getPassengerName()%></p>
			<p>
				<strong>Age:</strong>
				<%=ticket.getAge()%></p>
			<p>
				<strong>Mobile:</strong>
				<%=ticket.getMobile()%></p>
			<p>
				<strong>Address:</strong>
				<%=ticket.getAddress()%></p>
			<p>
				<strong>Payment Method:</strong>
				<%=ticket.getPaymentMethod()%></p>
			<p>
				<strong>User ID:</strong>
				<%=ticket.getUserId()%></p>
		</div>
		<%
		}
		} else {
		%>
		<p style="text-align: center;">No ticket details found.</p>
		<%
		}
		%>
	</div>

	<footer class="footer-bottom">
		<p>Copyright ©2022 All rights reserved</p>
		<a href="index.jsp">Home</a>
	</footer>
</body>
</html>
