<%@ page import="java.util.List"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.servlet.ServletException"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Booking Confirmation</title>
<link rel="stylesheet" href="bus.css">

</head>
<body>
	<%
	HttpSession httpSession = request.getSession(false);
	if (httpSession == null || httpSession.getAttribute("login") == null) {
		request.setAttribute("msg", "you're not authenticated");
		response.sendRedirect("LogIn.jsp");
	}
	%>

	<header class="header-class">
		<div class="logo">
			<span style="color: red;"> Get </span> <span class="trusted">Bus-y</span>
		</div>
		<div
			style="font-family: sans-serif; font-size: xx-large; color: coral; font-weight: 800">
			WELCOME</div>
		<%
		if (null == session.getAttribute("login")) {
		%>
		<div class="nav">
			<a href="#login" class="login">Login</a>
		</div>
		<%
		} else {
		%>
		<div class="logOut">
			<p>User ID : ${sessionScope.login.userName}</p>
			<a href="logout" class="out">Logout</a>
		</div>
		</div>
		<%
		}
		%>

	</header>
	<article class="hero">
		<form action="update">
			<div class="confirmation-container">
				<h1 class="confirmation-heading">Thank You for Booking!</h1>

				<%
				String busId = request.getParameter("busId");
				String busName = request.getParameter("busName");
				String departure = request.getParameter("departure");
				String arrival = request.getParameter("arrival");
				int seats = Integer.parseInt(request.getParameter("seats"));
				String userId = request.getParameter("userId");
				String[] passengerNames = new String[seats];
				for (int i = 1; i <= seats; i++) {
					passengerNames[i - 1] = request.getParameter("name_" + i);
				}
				%>

				<div class="details">
					<p>
						<label>User Id:</label>
						<%=userId%></p>
					<p>
					<p>
						<label>Bus Number:</label>
						<%=busId%></p>
					<p>
						<label>Bus Name:</label>
						<%=busName%></p>
					<p>
						<label>Departure:</label>
						<%=departure%></p>
					<p>
						<label>Arrival:</label>
						<%=arrival%></p>
					<p>
						<label>Number of Seats:</label>
						<%=seats%></p>
					<p>
						<label>Passenger Names:</label>
					</p>
					<ul>
						<%
						for (String name : passengerNames) {
							out.println("<li>" + name + "</li>");
						}
						%>
					</ul>
				</div>
			</div>

			<input type="hidden" name="seats" value="<%=seats%>"> <input
				type="hidden" name="busId" value="<%=busId%>">
			<button type="submit" class="form-button">Done</button>
		</form>
	</article>
	<footer class="footer-bottom">
		<p>Copyright ©2022 All rights reserved</p>
		<a href="index.jsp">Home</a>
	</footer>
</body>
</html>
