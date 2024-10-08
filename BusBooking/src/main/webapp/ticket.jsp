<%@ page import="java.util.List"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Booking Confirmation</title>
<link rel="stylesheet" href="bus.css">
</head>
<body>
	<c:if test="${empty sessionScope.login}">
		<c:set var="msg" value="You're not authenticated" />
		<c:redirect url="LogIn.jsp" />
	</c:if>

	<header class="header-class">
		<div class="logo">
			<span style="color: red;">Get</span> <span class="trusted">Bus-y</span>
		</div>
		<div
			style="font-family: sans-serif; font-size: xx-large; color: coral; font-weight: 800">
			WELCOME</div>

		<c:choose>
			<c:when test="${empty sessionScope.login}">
				<div class="nav">
					<a href="#login" class="login">Login</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="logOut">

					<p>User ID : ${sessionScope.login.userName}</p>
					<a class="out" href="index.jsp">Home</a> <a href="logout"
						class="out">Logout</a>

				</div>
			</c:otherwise>
		</c:choose>
	</header>

	<article class="hero">
		<form action="update">
			<div class="confirmation-container">
				<h1 class="confirmation-heading">Thank You for Booking!</h1>

				<c:set var="busId" value="${param.busId}" />
				<c:set var="busName" value="${param.busName}" />
				<c:set var="departure" value="${param.departure}" />
				<c:set var="arrival" value="${param.arrival}" />
				<c:set var="seats" value="${param.seats}" />
				<c:set var="userId" value="${param.userId}" />
				<c:set var="passengerNames" value="${param.passengerNames}" />

				<div class="details">
					<p>
						<label>User Id:</label> ${userId}
					</p>
					<p>
						<label>Bus Number:</label> ${busId}
					</p>
					<p>
						<label>Bus Name:</label> ${busName}
					</p>
					<p>
						<label>Departure:</label> ${departure}
					</p>
					<p>
						<label>Arrival:</label> ${arrival}
					</p>
					<p>
						<label>Number of Seats:</label> ${seats}
					</p>
					<p>
						<label>Passenger Names:</label>
					</p>
					<ul>
						<c:forEach var="name" items="${passengerNames}">
							<li>${name}</li>
						</c:forEach>
					</ul>
				</div>
			</div>

			<input type="hidden" name="seats" value="${seats}" /> <input
				type="hidden" name="busId" value="${busId}" />
			<button type="submit" class="form-button">Done</button>
		</form>
	</article>

	<footer class="footer-bottom">
		<p>Copyright ©2022 All rights reserved</p>

	</footer>
</body>
</html>
