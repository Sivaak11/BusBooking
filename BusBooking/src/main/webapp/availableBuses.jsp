<%@ page import="com.vast.vo.UserDetails"%>
<%@ page import="com.vast.vo.Bus"%>
<%@ page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Available Buses</title>
<link rel="stylesheet" type="text/css" href="bus.css">
<script>
        function updateSeatCount(busNumber, operation) {
            var seatCountElement = document.getElementById('seatCount_' + busNumber);
            var currentCount = parseInt(seatCountElement.innerText);

            if (operation === 'add') {
                seatCountElement.innerText = currentCount + 1;
            } else if (operation === 'subtract' && currentCount > 0) {
                seatCountElement.innerText = currentCount - 1;
            }
        }

        function bookSeat(busNumber, busName, departure, arrival, userId) {
            var seatCountElement = document.getElementById('seatCount_' + busNumber);
            var bookedSeats = parseInt(seatCountElement.innerText);

            if (bookedSeats > 0) {
                location.href = 'bookSeat.jsp?busId=' + busNumber + '&seats='
                    + bookedSeats + '&departure='
                    + encodeURIComponent(departure) + '&arrival='
                    + encodeURIComponent(arrival) + '&busname='
                    + encodeURIComponent(busName) + '&userid='
                    + encodeURIComponent(userId);
            } else {
                alert("Please select at least one seat to book.");
            }
        }
    </script>
</head>

<c:if test="${empty sessionScope.login}">
	<jsp:forward page="LogIn.jsp">
		<jsp:param name="msg" value="Your Not Authenticated" />
	</jsp:forward>
</c:if>

<body>
	<header class="header-class">
		<div class="logo">
			<span style="color: red;"> Get </span> <span class="trusted">Bus-y</span>
		</div>
		<div
			style="font-family: sans-serif; font-size: xx-large; color: coral; font-weight: 800">
			WELCOME</div>

		<c:choose>
			<c:when test="${not empty sessionScope.login}">
				 <h3>User ID : ${sessionScope.login.userName}</h3>
			</c:when>
		</c:choose>
	</header>

	<article class="hero">
		<c:if test="${not empty res}">
			<p style="color: red;">${res}</p>
		</c:if>

		<c:if test="${not empty buses}">
			<div class="table">
				<div class="subdata">
					<h4 style="font-size: 20px; margin: 10px">Route :</h4>
					<span>${param.txtdeparture}</span> <label style="font-size: 20px;">To</label>
					<span>${param.txtarrival}</span> <label>Date: </label> <span>${param.txtdate}</span>
				</div>

				<form action="yourBusSearchHandler.jsp" method="POST">
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
							<c:forEach var="bus" items="${requestScope.buses}">
								<tr>
									<td>${bus.bus_Number}</td>
									<td>${bus.name}</td>
									<td>${bus.departure_time}</td>
									<td>${bus.availableSeats}</td>
									<td class='seat-count-wrapper'>
										<button type='button'
											onclick="updateSeatCount('${bus.bus_Number}', 'subtract')">-</button>
										<span id='seatCount_${bus.bus_Number}'>0</span>
										<button type='button'
											onclick="updateSeatCount('${bus.bus_Number}', 'add')">+</button>
										<button class='seatbutton' type='button'
											onclick='bookSeat("${bus.bus_Number}", "${bus.name}", "${param.txtdeparture}", "${param.txtarrival}", "${sessionScope.login.userId != null ? sessionScope.login.userId : ""}")'>Book
											Seats</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
			</div>
		</c:if>

		<c:if test="${empty buses}">
			<p>No buses available.</p>
		</c:if>
	</article>

	<footer class="footer-bottom">
		<p>Copyright ©2022 All rights reserved</p>
		<a href="index.jsp">Home</a>
	</footer>
</body>
</html>
