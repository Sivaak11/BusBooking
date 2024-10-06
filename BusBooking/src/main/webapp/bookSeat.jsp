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
</head>
<body>
	<%
	HttpSession httpSession = request.getSession(false);
	if (httpSession == null || httpSession.getAttribute("login") == null) {
		request.setAttribute("msg", "You're not authenticated");
		response.sendRedirect("LogIn.jsp");
		return; // Make sure to return after redirecting
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
			<h3>User ID : ${sessionScope.login.userName}</h3>
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

		<form class="passenger-form" action="ticket" method="post">
			<input type="hidden" name="busId" value="<%=busId%>"> <input
				type="hidden" name="busName" value="<%=busName%>"> <input
				type="hidden" name="departure" value="<%=departure%>"> <input
				type="hidden" name="arrival" value="<%=arrival%>"> <input
				type="hidden" name="seats" value="<%=seats%>"> <input
				type="hidden" name="userId" value="<%=userId%>">

			<%
			for (int i = 1; i <= seats; i++) {
			%>
			<h3 style="color: orange;">
				Passenger
				<%=i%>
				Details
			</h3>
			<label for="name_<%=i%>" class="form-label">Passenger Name:</label> <input
				type="text" id="name_<%=i%>" name="name_<%=i%>" class="form-input"
				required><br> <br> <label for="age_<%=i%>"
				class="form-label">Age:</label> <input type="number" id="age_<%=i%>"
				name="age_<%=i%>" min="2" class="form-input" required><br>
			<br>
			<%
			}
			%>
			<br> <label for="mobile" class="form-label">Mobile
				Number:</label> <input type="tel" id="mobile" name="mobile"
				class="form-input" pattern="[0-9]{10}" required><br> <br>
			<label for="address" class="form-label">Address:</label> <input
				type="text" id="address" name="address" class="form-input" required><br>
			<br>

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
		<a href="index.jsp">Home</a>
	</footer>
</body>
</html>
