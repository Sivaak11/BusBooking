<%@page import="com.vast.vo.Seats"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Passenger Details</title>
<link rel="stylesheet" href="bus.css">
</head>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
}

.passenger-form {
	width: 100%;
	max-width: 600px;
	margin: 0 auto;
	background-color: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.form-label {
	font-size: 16px;
	color: #333;
	display: block;
	margin-bottom: 8px;
}

.form-input, .form-select {
	width: 100%;
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 14px;
}

.form-select {
	cursor: pointer;
}

.form-section-heading {
	color: orange;
	margin-bottom: 10px;
	font-size: 18px;
}

.form-button {
	background-color: orange;
	color: white;
	border: none;
	padding: 12px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	width: 100%;
}

.form-button:hover {
	background-color: darkorange;
}

/* Media query for responsiveness */
@media ( max-width : 600px) {
	.passenger-form {
		padding: 15px;
	}
	.form-label {
		font-size: 14px;
	}
	.form-input, .form-select, .form-button {
		font-size: 13px;
	}
}
</style>

<body>
	<header>
		<div class="header-class">
			<div class="logo">
				<span style="color: red;">Get</span> <span class="trusted">Bus-y</span>
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

		<form method="post" class="passenger-form">
			<h2 style="color: orange; text-align: center; padding:15px 0px;">Passenger Details</h2>
			<label for="name" class="form-label">Passenger Name:</label> <input
				type="text" id="name" name="name" class="form-input" required><br>
			<br> <label for="age" class="form-label">Age:</label> <input
				type="number" id="age" name="age" min="2" class="form-input"
				required><br>
			<br> <label for="mobile" class="form-label">Mobile
				Number:</label> <input type="tel" id="mobile" name="mobile"
				class="form-input" pattern="[0-9]{10}" required><br>
			<br> <label for="address" class="form-label">Address:</label> <input
				type="text" id="address" name="address" class="form-input" required><br>
			<br>

			<!-- New fields for seat number and bus name -->
			<label for="seat-number" class="form-label">Seat Number:</label> <input
				type="text" id="seat-number" name="seat-number" class="form-input"
				required><br>
			<br> <label for="bus-name" class="form-label">Bus Name:</label>
			<input type="text" id="bus-name" name="bus-name" class="form-input"
				required><br>
			<br>

			<!-- Payment Section -->
			<h3 class="form-section-heading">Payment</h3>
			<label for="payment-method" class="form-label">Payment
				Method:</label> <select id="payment-method" name="payment-method"
				class="form-select" required>
				<option value="credit-card">Credit Card</option>
				<option value="debit-card">Debit Card</option>
				<option value="net-banking">Net Banking</option>
				<option value="upi">UPI</option>
			</select><br>
			<br>

			<button type="submit" class="form-button">Pay Now</button>
		</form>

	</article>
<body>
	<header class="header-class">
		<div class="logo">
			<span style="color: red;">Get</span> <span class="trusted">Bus-y</span>
		</div>
		<div class="well">
			<a href="#">WELCOME</a>
		</div>
		<div class="nav">
			<a href="#login" class="login">Login/SignUp</a>
		</div>
	</header>

	<h2 style="color: orange;">Passenger Details</h2>

	<article class="hero">
		<%
		// Fetch the busId parameter from the request (though not used here)
		String busId = request.getParameter("busId");

		// Display any error message if it exists in the request
		if (request.getAttribute("res") != null) {
		%>
		<p style="color: red;"><%=request.getAttribute("res")%></p>
		<%
		}
		%>

		<%
		// Fetch the list of seats from the request attribute
		List<Seats> seatList = (List<Seats>) request.getAttribute("findseat");

		// If the seat list is not empty, render the hidden inputs for seat number and bus number
		if (seatList != null && !seatList.isEmpty()) {
			// Loop through the seat list
			for (Seats seat : seatList) {
		%><input type="hidden" name="seatNumber"
			value="<%=seat.getSeatNumber()%>"> <input type="hidden"
			name="busNumber" value="<%=seat.getBusNumber()%>">

		<%
		}
		}
		%>

		<!-- Passenger details form -->
		<form action="ticket.jsp" class="passenger-form">
			<label for="name" class="form-label">Passenger Name:</label> <input
				type="text" id="name" name="name" class="form-input" required><br>
			<br> <label for="age" class="form-label">Age:</label> <input
				type="number" id="age" name="age" min="2" class="form-input"
				required><br> <br> <label for="mobile"
				class="form-label">Mobile Number:</label> <input type="tel"
				id="mobile" name="mobile" class="form-input" pattern="[0-9]{10}"
				required><br> <br> <label for="address"
				class="form-label">Address:</label> <input type="text" id="address"
				name="address" class="form-input" required><br> <br>
			<h3 class="form-section-heading">Payment</h3>

			<label for="payment-method" class="form-label">Payment
				Method:</label> <select id="payment-method" name="payment-method"
				class="form-select" required>
				<option value="credit-card">Credit Card</option>
				<option value="debit-card">Debit Card</option>
				<option value="net-banking">Net Banking</option>
				<option value="upi">UPI</option>
			</select><br> <br>

			<button type="submit" class="form-button">Pay Now</button>
		</form>

	</article>

	<footer class="footer-bottom">
		<p>Copyright ©2022 All rights reserved</p>
	</footer>
>>>>>>> a89163c56555d481040aa8d2a3aba4a4c31e2f5b
</body>
</html>
