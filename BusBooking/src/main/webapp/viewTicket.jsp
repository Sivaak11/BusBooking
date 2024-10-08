<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vast.vo.TicketDetails"%>
<%@ page import="java.util.Set"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Ticket Details</title>
<link rel="stylesheet" href="viewticket.css">
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
			<c:choose>
				<c:when test="${empty sessionScope.login}">
					<a href="login" class="login">Login</a>
				</c:when>
				<c:otherwise>
					<h3>User ID: ${sessionScope.login.userName}</h3>
					<a class="out" href="index.jsp">Home</a>
				</c:otherwise>
			</c:choose>
		</div>
	</header>

	<article class="hero">
		<div class="container">
			<c:set var="tickets" value="${requestScope.ticketDeetail}" />
			<c:set var="errorMsg" value="${requestScope.res}" />

			<c:if test="${not empty errorMsg}">
				<p style="color: red; text-align: center;">${errorMsg}</p>
			</c:if>

			<c:if test="${not empty tickets}">
				<c:forEach var="ticket" items="${tickets}">
					<div class="ticket-detail"
						style="border: 1px solid #ccc; padding: 20px; margin: 10px;">
						<h3>Ticket Information</h3>
						<p>
							<strong>Bus ID:</strong> ${ticket.busId}
						</p>
						<p>
							<strong>Bus Name:</strong> ${ticket.busName}
						</p>
						<p>
							<strong>Departure:</strong> ${ticket.departure}
						</p>
						<p>
							<strong>Arrival:</strong> ${ticket.arrival}
						</p>
						<p>
							<strong>Seat Number:</strong> ${ticket.seatNumber}
						</p>
						<p>
							<strong>Passenger Name:</strong> ${ticket.passengerName}
						</p>
						<p>
							<strong>Age:</strong> ${ticket.age}
						</p>
						<p>
							<strong>Mobile:</strong> ${ticket.mobile}
						</p>
						<p>
							<strong>Address:</strong> ${ticket.address}
						</p>
						<p>
							<strong>Payment Method:</strong> ${ticket.paymentMethod}
						</p>
						<p>
							<strong>User ID:</strong> ${ticket.userId}
						</p>
					</div>
				</c:forEach>
			</c:if>

			<c:if test="${empty tickets}">
				<p style="text-align: center;">No ticket details found.</p>
			</c:if>
		</div>
	</article>

	<footer class="footer-bottom">
		<p>Copyright ©2022 All rights reserved</p>
		 
	</footer>
</body>
</html>
