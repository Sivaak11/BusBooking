<%@page import="com.vast.vo.Bus"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Available Buses</title>
<link rel="stylesheet" type="text/css" href="bus.css">
</head>
<body>

	<header class="header-class">

		<div class="logo">
			<span style="color: red;"> Get </span> <span class="trusted">Bus-y</span>
		</div>
		<div class="well">
			<a href="#">WELCOME</a>
		</div>
		<div class="nav">
			<a href="#login" class="login">Login/SignUp</a>
		</div>

	</header>
	<article class="hero">

		<c:if test="${not empty res}">
			<p style="color: red;">${res}</p>
		</c:if>

		<c:if test="${not empty buses}">
		
			<div class="table">
			  <div class="subdata">

                <label>Departure:</label>
               <%=request.getParameter("txtdeparture") %>

                <label>Arrival:</label>
                <%=request.getParameter("txtarrival") %>

                <label>Date: </label>
                 <%=request.getParameter("txtdate") %>
            </div>
				<table border="1" cellpadding="10">
					<thead>

						<tr>
							<th>Bus Number</th>
							<th>Name</th>
							<th>Time</th>
							<th>Book Ticket</th>
							<!-- New column for booking ticket -->
						</tr>
					</thead>
					<tbody>

						<!-- Loop through each bus and display its details -->
						<%
						List<Bus> buses = (List<Bus>) request.getAttribute("buses");
						if (buses != null) {
							for (Bus bus : buses) {
								out.println("<tr>");
								out.println("<td>" + bus.getBus_Number() + "</td>");
								out.println("<td>" + bus.getName() + "</td>");
								out.println("<td>" + bus.getDeparture_time() + "</td>");
								out.println("<td><button class='seatbutton' type='button' onclick=\"location.href='viewSeat?busId="
								+ bus.getBus_Number() + "'\">View Seat</button></td>");
								out.println("</tr>");
							}
						}
					    if (buses != null && !buses.isEmpty()) {

					        Bus bus = buses.get(0);  
					        String departure = bus.getDeparture();
					        String arrival = bus.getArrival();
					        String date = bus.getDate();
					        

					        request.setAttribute("departure", departure);
					        request.setAttribute("arrival", arrival);
					        request.setAttribute("date", date);
					    }
						%>
					</tbody>
				</table>

			</div>
		</c:if>

		<c:if test="${empty buses}">

		</c:if>

		</div>
	</article>


	<footer class="footer-bottom">
		<p>Copyright ©2022 All rights reserved</p>

	</footer>
</body>
</html>
