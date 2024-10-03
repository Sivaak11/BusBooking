<%@page import="com.vast.vo.Seats"%>
<%@page import="java.util.List"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.WebServlet"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Passenger Details</title>
<link rel="stylesheet" href="bus.css">
</head>
<style>
/* Your existing CSS here */
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
		<h2 style="color: orange; text-align: center; padding: 15px 0px;">Passenger
			Details</h2>

		<%
		String busId = request.getParameter("busId");
		int seats = Integer.parseInt(request.getParameter("seats")); // Get the number of seats

		if (request.getAttribute("res") != null) {
		%>
		<p style="color: red;"><%=request.getAttribute("res")%></p>
		<%
		}
		%>

		<form method="post" class="passenger-form" action="ticket.jsp">
			<%
			// Loop to create input fields for each passenger
			for (int i = 1; i <= seats; i++) {
			%>
			<h3 style="color: orange;">
				Passenger
				<%=i%>
				Details
			</h3>
			<label for="name_<%=i%>" class="form-label">Passenger Name:</label>
			<input type="text" id="name_<%=i%>" name="name_<%=i%>"
				class="form-input" required><br>
			<br> <label for="age_<%=i%>" class="form-label">Age:</label> <input
				type="number" id="age_<%=i%>" name="age_<%=i%>" min="2"
				class="form-input" required><br>
			<br> <label for="mobile_<%=i%>" class="form-label">Mobile
				Number:</label> <input type="tel" id="mobile_<%=i%>"
				name="mobile_<%=i%>" class="form-input" pattern="[0-9]{10}"
				required><br>
			<br> <label for="address_<%=i%>" class="form-label">Address:</label>
			<input type="text" id="address_<%=i%>" name="address_<%=i%>"
				class="form-input" required><br>
			<br>
			<%
			}
			%>

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

	<footer class="footer-bottom">
		<p>Copyright ©2022 All rights reserved</p>
	</footer>
</body>
</html>
