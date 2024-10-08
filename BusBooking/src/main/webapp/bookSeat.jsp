<%@page import="com.vast.vo.UserDetails"%>
<%@page import="java.util.List"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.WebServlet"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
			const name = document.getElementById(name_${i}).value;
			const address = document.getElementById('address').value;
			const mobileInput = document.getElementById('mobile').value;
			const errorMessage = document.getElementById('error-message');
			if (mobileInput.length !== 10 || isNaN(mobileInput)) {
				errorMessage.textContent = "Please enter exactly 10 digits.";
				return false;
			}

			if (!/^[a-zA-Z]+( [a-zA-Z]+)?$/.test(name)) {
				alert(Passenger ${i}: Name must contain only letters and a single space.);
				isValid = false;
			}

			if (!/^[a-zA-Z0-9\s]+$/.test(address)) {
				alert("Address must contain only alphanumeric characters.");
				isValid = false;
			}
		}

		return isValid;
	}
</script>
</head>
<body>
	<c:if test="${sessionScope.login == null}">
		<c:set var="msg" value="You're not authenticated" />
		<c:redirect url="LogIn.jsp" />
	</c:if>

	<header>
		<div class="header-class">
			<div class="logo">
				<span style="color: red;">Get</span> <span class="trusted">Bus-y</span>
			</div>
			<div
				style="font-family: sans-serif; font-size: xx-large; color: coral; font-weight: 800">
				WELCOME</div>
			<c:choose>
				<c:when test="${sessionScope.login == null}">
					<a href="login" class="login">Login</a>
				</c:when>
				<c:otherwise>
					<div class="logOut">

						<p>User ID : ${sessionScope.login.userName}</p>
						<a class="out" href="index.jsp">Home</a> <a href="logout"
							class="out">Logout</a>

					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</header>

	<article>
		<h2 style="color: orange; text-align: center; padding: 15px 0px;">Passenger
			Details</h2>

		<c:set var="busId" value="${param.busId}" />
		<c:set var="user" value="${sessionScope.login}" />
		<c:set var="userId" value="${user.userId}" />
		<c:set var="departure" value="${param.departure}" />
		<c:set var="arrival" value="${param.arrival}" />
		<c:set var="busName" value="${param.busname}" />
		<c:set var="seats" value="${param.seats}" />
		<c:set var="pricePerSeat" value="800" />
		<c:set var="totalPrice" value="${pricePerSeat * seats}" />

		<c:if test="${not empty requestScope.res}">
			<p style="color: red;">${requestScope.res}</p>
		</c:if>

		<form class="passenger-form" action="ticket" method="post"
			onsubmit="return validateForm()">
			<input type="hidden" name="busId" value="${busId}" /> <input
				type="hidden" name="busName" value="${busName}" /> <input
				type="hidden" name="departure" value="${departure}" /> <input
				type="hidden" name="arrival" value="${arrival}" /> <input
				type="hidden" name="seats" value="${seats}" /> <input type="hidden"
				name="userId" value="${userId}" />

			<h4 id="total-price" style="color: white;">ENTER DETAILS</h4>
			<c:forEach var="i" begin="1" end="${seats}">
				<div class="passenger-details">
					<h3 style="color: orange;">Passenger ${i} Details</h3>
					<label for="name_${i}" class="form-label">Passenger Name:</label> <input
						type="text" id="name_${i}" name="name_${i}" class="form-input"
						required pattern="^[A-Za-z]+( [A-Za-z]+)?$"
						title="Name must contain only alphabets and at most one space." />

					<br> <br> <label for="age_${i}" class="form-label">Age:</label>
					<input type="number" id="age_${i}" name="age_${i}" min="2" max="98"
						class="form-input" required /> <br> <br>
				</div>
			</c:forEach>

			<script>
				const pricePerSeat = 800;
				const seatCount = $
				{
					seats
				};
				const totalPrice = pricePerSeat * seatCount;
				document.getElementById('total-price').textContent = TOTAL PRICE = ${totalPrice} rupees; // Update the displayed total price
			</script>
			<br> <label for="mobile" class="form-label">Mobile
				Number:</label> <input type="tel" id="indianMobile" name="indianMobile"
				class="form-input" pattern="^(?!(\d)\1{9})[6,7,8,9]\d{9}$"
				title="Please enter a valid Indian mobile number (10 digits )."
				required /> <br> <br> <label for="address"
				class="form-label">Address:</label> <input type="text" id="address"
				name="address" class="form-input" required
				pattern="^[A-Za-z0-9\- , .]+"
				title="Address must contain only alphanumeric characters and hyphens." />

			<br> <br>
			<h4 id="total-price" style="color: black;">TOTAL PRICE =
				${totalPrice} rupees</h4>
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
		<p>Copyright ©2022 All rights reserved</p>

	</footer>
</body>
</html>