<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bus Booking</title>
<link rel="stylesheet" href="index.css">
<script>
	function validateForm() {
		const departure = document.forms["firstform"]["txtdeparture"].value;
		const arrival = document.forms["firstform"]["txtarrival"].value;

		const regex = /^[A-Za-z]+( [A-Za-z]+)?$/;

		if (!regex.test(departure)) {
			alert("Please enter a valid departure location (letters only, at most one space).");
			return false;
		}

		if (!regex.test(arrival)) {
			alert("Please enter a valid arrival location (letters only, at most one space).");
			return false;
		}

		if (departure.toLowerCase() === arrival.toLowerCase()) {
			alert("Departure and arrival locations cannot be the same.");
			return false;
		}

		return true;
	}
</script>


</head>
<body>
	<header>
		<div class="header-class">
			<div class="logo">
				<span style="color: red;"> Get </span> <span class="trusted">Bus-y</span>
			</div>
			<div
				style="font-family: sans-serif; font-size: xx-large; color: coral; font-weight: 800; text-align: center;">
				WELCOME</div>
			<div class="nav">
				<c:choose>
					<c:when test="${empty sessionScope.login}">
						<a href="login" class="login">Login</a>
					</c:when>
					<c:otherwise>
						<div class="logOut">
							<p>User ID : ${sessionScope.login.userName}</p>
							<a href="showticket">Show My Ticket</a> <a href="logout"
								class="out">Logout</a>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</header>

	<article class="hero">
		<div class="overlay">
			<h1>Book Your Tickets</h1>
			<section class="booking-form">
				<form class="firstform" name="firstform" action="findbus"
					method="post" onsubmit="return validateForm()">
					<input type="text" name="txtdeparture" placeholder="From" required
						list="departure-options" /> <input type="text" name="txtarrival"
						placeholder="To" required list="arrival-options" />

					<datalist id="departure-options">
						<option value="Chennai">
						<option value="Coimbatore">
						<option value="Kovilpatti">
					</datalist>

					<datalist id="arrival-options">
						<option value="Chennai">
						<option value="Coimbatore">
						<option value="Kovilpatti">
					</datalist>

					<%
					Calendar cal = Calendar.getInstance();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					String minDate = sdf.format(cal.getTime());
					cal.add(Calendar.DAY_OF_MONTH, 60);
					String maxDate = sdf.format(cal.getTime());
					%>
					<input type="date" id="travel-date" name="txtdate" required
						min="<%=minDate%>" max="<%=maxDate%>" />

					<button type="submit" class="search-btn">Search bus</button>
				</form>
			</section>
		</div>
	</article>

	<footer class="footer-bottom">
		<p>Copyright ©2022 All rights reserved</p>
	</footer>
</body>
</html>
