<%@page import="com.vast.vo.UserDetails"%>
<%@page import="java.util.List"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.WebServlet"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Passenger Details</title>
<link rel="stylesheet" href="bus.css">
<script>
	function validateForm() {
		const seatCount = document.querySelectorAll('.passenger-details').length;
		let isValid = true;

		for (let i = 1; i <= seatCount; i++) {
			const name = document.getElementById(`name_${i}`).value;
			const address = document.getElementById('address').value;
			const mobileInput = document.getElementById('mobile').value;
			const errorMessage = document.getElementById('error-message');
			if (mobileInput.length !== 10 || isNaN(mobileInput)) {
				errorMessage.textContent = "Please enter exactly 10 digits.";
				return false;
			}
			// Validate Passenger Name: Only alphabets and one s	pace allowed
			if (!/^[a-zA-Z]+( [a-zA-Z]+)?$/.test(name)) {
				alert(`Passenger ${i}: Name must contain only letters and a single space.`);
				isValid = false;
			}

			// Validate Address: Only alphanumeric characters and spaces
			if (!/^[a-zA-Z0-9\s]+$/.test(address)) {
				alert("Address must contain only alphanumeric characters.");
				isValid = false;
			}
		}

		return isValid; // Return the overall validity of the form
	}
</script>
</head>
<body>
	<%
	HttpSession httpSession = request.getSession(false);
	if (httpSession == null || httpSession.getAttribute("login") == null) {
		request.setAttribute("msg", "You're not authenticated");
		response.sendRedirect("LogIn.jsp");
		return;
	}
	%>

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
			<div class="logOut">

						<p>User ID : ${sessionScope.login.userName}</p>
						<a class="out" href="index.jsp">Home</a> <a href="logout"
							class="out">Logout</a>

					</div>
			<%
			}
			%>
		</div>
	</header>

	<article>
		<h2 style="color: orange; text-align: center; padding: 15px 0px;">Passenger
			Details</h2>

		<%
		String busId = request.getParameter("busId");
		UserDetails user = (UserDetails) session.getAttribute("login");
		String userId = user.getUserId();
		String departure = request.getParameter("departure");
		String arrival = request.getParameter("arrival");
		String busName = request.getParameter("busname");
		int seats = Integer.parseInt(request.getParameter("seats"));

		if (request.getAttribute("res") != null) {
		%>
		<p style="color: red;"><%=request.getAttribute("res")%></p>
		<%
		}
		%>

		<form class="passenger-form" action="ticket" 
			onsubmit="return validateForm()" method="post">
			<input type="hidden" name="busId" value="<%=busId%>"> <input
				type="hidden" name="busName" value="<%=busName%>"> <input
				type="hidden" name="departure" value="<%=departure%>"> <input
				type="hidden" name="arrival" value="<%=arrival%>"> <input
				type="hidden" name="seats" value="<%=seats%>"> <input
				type="hidden" name="userId" value="<%=userId%>">

			<%
			int pricePerSeat = 800; // Define the price per seat
			int totalPrice = pricePerSeat * seats; // Calculate total price based on the number of seats
			%>
			<%
			for (int i = 1; i <= seats; i++) {
			%>
			<h4 id="total-price" style="color: white;">ENTER DETAILS</h4>
			<div class="passenger-details">
				<h3 style="color: orange;">
					Passenger
					<%=i%>
					Details
				</h3>
				<label for="name_<%=i%>" class="form-label">Passenger Name:</label>
				<input type="text" id="name_<%=i%>" name="name_<%=i%>"
					class="form-input" required pattern="^[A-Za-z]+( [A-Za-z]+)?$"
					title="Name must contain only alphabets and at most one space.">

				<br> <br> <label for="age_<%=i%>" class="form-label">Age:</label>
				<input type="number" id="age_<%=i%>" name="age_<%=i%>" min="2"
					max="98" class="form-input" required> <br> <br>
			</div>
			<%
			}
			%>
			<script>
				// Calculate and display the total price in the client-side
				const pricePerSeat = 800; // Define the price per seat
				const seatCount =
			<%=seats%>
				; // Get the number of seats from server-side
				const totalPrice = pricePerSeat * seatCount; // Calculate total price
				document.getElementById('total-price').textContent = `TOTAL PRICE = ${totalPrice} rupees`; // Update the displayed total price
			</script>
			<br> <label for="mobile" class="form-label">Mobile
				Number:</label> <input type="tel" id="mobile" name="mobile"
				class="form-input"  pattern="^(?!(\d)\1{9})[6,7,8,9]\d{9}$" required> <br> <br>
			<label for="address" class="form-label">Address:</label> <input
				type="text" id="address" name="address" class="form-input" required
				pattern="^[A-Za-z0-9\- ,]+$"
				title="Address must contain only alphanumeric characters and hyphens.">

			<br> <br>
			<h4 id="total-price" style="color: black;">
				TOTAL PRICE =
				<%=totalPrice%>
				rupees
			</h4>
			<h3 class="form-section-heading">Payment</h3>
			<label for="payment-method" class="form-label">Payment
				Method:</label> <select id="payment-method" name="payment-method"
				class="form-select" required>
				<option value="credit-card">Credit Card</option>
				<option value="debit-card">Debit Card</option>
				<option value="net-banking">Net Banking</option>
				<option value="upi">UPI</option>
			</select> <br> <br>

			<button type="submit" class="form-button">Pay Now</button>
		</form>
	</article>

	<footer class="footer-bottom">
		<p>Copyright �2022 All rights reserved</p>
	
	</footer>
</body>
</html>
