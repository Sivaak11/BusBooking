<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bus Booking</title>
<link rel="stylesheet" href="bus.css">
<script>
	function validateForm() {
		const departure = document.forms["firstform"]["txtdeparture"].value;
		const arrival = document.forms["firstform"]["txtarrival"].value;

		const regex = /^[A-Za-z]+( [A-Za-z]+)?$/; // Regex to allow letters and at most one space

		if (!regex.test(departure)) {
			alert("Please enter a valid departure location (letters only, at most one space).");
			return false;
		}

		if (!regex.test(arrival)) {
			alert("Please enter a valid arrival location (letters only, at most one space).");
			return false;
		}

		return true; // Form is valid
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
				style="font-family: sans-serif; font-size: xx-large; color: coral; font-weight: 800">
				WELCOME</div>
			<div class="nav">
				<c:choose>
					<c:when test="${sessionScope.login == null}">
						<a href="login" class="login">Login</a>
					</c:when>
					<c:otherwise>
						<h3>User ID : ${sessionScope.login.userName}</h3>
						<a href="showticket">Show My Ticket</a>
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
					<input type="text" name="txtdeparture" placeholder="From" required />
					<input type="text" name="txtarrival" placeholder="To" required />

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
		<p>Copyright �2022 All rights reserved</p>
	</footer>
</body>
</html>
