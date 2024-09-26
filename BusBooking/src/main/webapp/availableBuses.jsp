<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Available Buses</title>
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
	<h1>Available Buses</h1>


	<c:if test="${not empty res}">
		<p style="color: red;">${res}</p>
	</c:if>


	<c:if test="${not empty findbus}">
		<table border="1" cellpadding="10">
			<thead>
				<tr>
					<th>Bus Number</th>
					<th>Name</th>
					<th>Departure</th>
					<th>Arrival</th>
				</tr>
			</thead>
			<tbody>
				<!-- Loop through each bus and display its details -->
				<c:forEach var="bus" items="${findbus}">
					<tr>
						<td>${bus.bus_Number}</td>
						<td>${bus.name}</td>
						<td>${bus.departure}</td>
						<td>${bus.arrival}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>


	<c:if test="${empty findbus}">
		<p>No buses available for the selected route.</p>
	</c:if>

</body>
</html>
