<%@page import="com.vast.vo.Bus"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Available Buses</title>
<link rel="stylesheet" type="text/css" href="bus.css">
<script>
	function updateSeatCount(busNumber, operation) {
		var seatCountElement = document
				.getElementById('seatCount_' + busNumber);
		var currentCount = parseInt(seatCountElement.innerText);

		if (operation === 'add') {
			seatCountElement.innerText = currentCount + 1;
		} else if (operation === 'subtract' && currentCount > 0) {
			seatCountElement.innerText = currentCount - 1;
		}
	}

	function bookSeat(busNumber) {
		var seatCountElement = document
				.getElementById('seatCount_' + busNumber);
		var bookedSeats = parseInt(seatCountElement.innerText);

		if (bookedSeats > 0) {
			// Redirect to booking page or send an AJAX request to book seats
			location.href = 'viewSeat?busId=' + busNumber + '&seats='
					+ bookedSeats;
		} else {
			alert("Please select at least one seat to book.");
		}
	}
</script>
</head>
<body>

	<header class="header-class">
		<div class="logo">
			<span style="color: red;"> Get </span> <span class="trusted">Bus-y</span>
		</div>
		<div class="well">
			<a href="#">WELCOME</a>
		</div>
		<div class="nav">
			<a href="#login" class="login">Login/SignUp</a>
		</div>
	</header>

	<article class="hero">
		<c:if test="${not empty res}">
			<p style="color: red;">${res}</p>
		</c:if>

		<c:if test="${not empty buses}">
			<div class="table">

				<div class="subdata">

					<label>Departure:</label>
					<%=request.getParameter("txtdeparture")%>

					<label>Arrival:</label>
					<%=request.getParameter("txtarrival")%>

					<label>Date: </label>
					<%=request.getParameter("txtdate")%>
				</div>

				<table border="1" cellpadding="10">
					<thead>
						<tr>
							<th>Bus Number</th>
							<th>Name</th>
							<th>Time</th>
							<th>Available Seats</th>
							<th>Book Ticket</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<Bus> buses = (List<Bus>) request.getAttribute("buses");
						if (buses != null) {
							for (Bus bus : buses) {
								out.println("<tr>");
								out.println("<td>" + bus.getBus_Number() + "</td>");
								out.println("<td>" + bus.getName() + "</td>");
								out.println("<td>" + bus.getDeparture_time() + "</td>");
								out.println("<td>" + bus.getAvailableSeats() + "</td>");
								out.println("<td>");
								out.println("<button type='button' onclick=\"updateSeatCount('" + bus.getBus_Number()
								+ "', 'subtract')\">-</button>");
								out.println("<span id='seatCount_" + bus.getBus_Number() + "'>0</span>");
								out.println(
								"<button type='button' onclick=\"updateSeatCount('" + bus.getBus_Number() + "', 'add')\">+</button>");
								out.println("<button class='seatbutton' type='button' onclick='bookSeat(\"" + bus.getBus_Number()
								+ "\")'>Book Seats</button>");
								out.println("</td>");
								out.println("</tr>");
							}
						}
						%>
					</tbody>
				</table>
			</div>
		</c:if>

		<c:if test="${empty buses}">
			<p>No buses available.</p>
		</c:if>

	</article>

	<footer class="footer-bottom">
		<p>Copyright ©2022 All rights reserved</p>
	</footer>

</body>
</html>
