<%@page import="com.vast.vo.Seats"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="bus.css">
</head>
<body>
	<header>
		<div class="header-class">
			<div class="logo">
				<span style="color: red;"> Get </span> <span class="trusted">Bus-y</span>
			</div>
			<div class="well">
				<a href="#">WELCOME</a>
			</div>
			<div class="nav">
				<a href="#login" class="login">Login/SignUp</a>
			</div>
		</div>
	</header>
	<article>
		<h2 style="color: orange;">Available Seats</h2>
		<div class="hero">

			<!-- Check if there is any error message -->
			<%
			request.getParameter("busId");
			%>
			<%
			if (request.getAttribute("res") != null) {
			%>
			<p style="color: red;"><%=request.getAttribute("res")%></p>
			<%
			}
			%>


			<%
			List<Seats> seat = (List<Seats>) request.getAttribute("findseat");
			if (seat != null && !seat.isEmpty()) {
			%>
			<table>
				<tr>
					<th>Bus Number</th>
					<th>Seat Number</th>
					<th>Action</th>
					<!-- New column for the button -->
				</tr>

				<%
				for (Seats seatObj : seat) {
					Seats seats = (Seats) seatObj;
				%>
				<tr>
					<td><%=seats.getBusNumber()%></td>
					<td><%=seats.getSeatNumber()%></td>
					<td>
						<form action="bookSeat.jsp" method="post">
							<input type="hidden" name="seatNumber"
								value="<%=seats.getSeatNumber()%>"> <input type="hidden"
								name="busNumber" value="<%=seats.getBusNumber()%>">
							<button type="submit">Book Now</button>
						</form>
					</td>
					<!-- Button added here -->
				</tr>
				<%
				}
				%>
			</table>

			<%
			} else {
			%>
			<p>No available seats found.</p>
			<%
			}
			%>
		</div>
	</article>
</body>
</html>
