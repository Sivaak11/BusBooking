<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ticket Confirmation</title>
<link rel="stylesheet" href="bus.css">
</head>
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

	<h2 style="color: green;">Thank you! Your ticket has been booked
		successfully.</h2>

	<article>
		<h3>Ticket Details:</h3>
		<form action="viewticket">
			<%
			// Retrieve the parameters
			String name = request.getParameter("name");
			String age = request.getParameter("age");
			String mobile = request.getParameter("mobile");
			String address = request.getParameter("address");
			String paymentMethod = request.getParameter("payment-method");
			String busNumber = request.getParameter("busNumber");
			String seatNumber = request.getParameter("seatNumber");

			// Debugging: Print the parameter values
			out.println("Name: " + name + "<br>");
			out.println("Age: " + age + "<br>");
			out.println("Mobile: " + mobile + "<br>");
			out.println("Address: " + address + "<br>");
			out.println("Payment Method: " + paymentMethod + "<br>");
			out.println("Bus Number: " + busNumber + "<br>");
			out.println("Seat Number: " + seatNumber + "<br>");
			%>

			<button type="submit" class="form-button">Download Ticket</button>
		</form>
	</article>

	<footer class="footer-bottom">
		<p>Copyright ©2022 All rights reserved</p>
	</footer>

	<script>
        function downloadTicket() {
            // Retrieve values directly from JSP variables
            const name = '<%=request.getParameter("name")%>';
            const age = '<%=request.getParameter("age")%>';
            const mobile = '<%=request.getParameter("mobile")%>';
            const address = '<%=request.getParameter("address")%>';
            const paymentMethod = '<%=request.getParameter("payment-method")%>';
            const busNumber = '<%=request.getParameter("busNumber")%>';
            const seatNumber = '<%=request.getParameter("seatNumber")%>
		';

			// Create the ticket content
			const ticketContent = `Passenger Name: ${name}\nAge: ${age}\nMobile Number: ${mobile}\nAddress: ${address}\nPayment Method: ${paymentMethod}\nBus Number: ${busNumber}\nSeat Number: ${seatNumber}`;

			// Create a Blob with the ticket content
			const blob = new Blob([ ticketContent ], {
				type : 'text/plain'
			});

			// Create a link element
			const link = document.createElement('a');
			link.href = URL.createObjectURL(blob);
			link.download = 'ticket.txt'; // File name

			// Trigger the download
			link.click();
		}
	</script>
</body>
</html>
