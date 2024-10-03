<%@ page import="java.util.List" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation</title>
    <link rel="stylesheet" href="bus.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .confirmation-container {
            max-width: 600px;
            margin: auto;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .confirmation-heading {
            color: orange;
            text-align: center;
        }
        .details {
            margin-top: 20px;
        }
        .details label {
            font-weight: bold;
        }
    </style>
</head>
<body>

    <div class="confirmation-container">
        <h1 class="confirmation-heading">Thank You for Booking!</h1>

        <%
            String busId = request.getParameter("busId");
            String busName = request.getParameter("busName");
            String departure = request.getParameter("departure");
            String arrival = request.getParameter("arrival");
           int seats = Integer.parseInt(request.getParameter("seats"));

            // Collect passenger names
            String[] passengerNames = new String[seats];
            for (int i = 1; i <= seats; i++) {
                passengerNames[i - 1] = request.getParameter("name_" + i);
            }
        %>

        <div class="details">
            <p><label>Bus Number:</label> <%= busId %></p>
            <p><label>Bus Name:</label> <%= busName %></p>
            <p><label>Departure:</label> <%= departure %></p>
            <p><label>Arrival:</label> <%= arrival %></p>
            <p><label>Number of Seats:</label> <%= seats %></p>
            <p><label>Passenger Names:</label></p>
            <ul>
                <%
                    for (String name : passengerNames) {
                        out.println("<li>" + name + "</li>");
                    }
                %>
            </ul>
        </div>
    </div>

    <footer class="footer-bottom">
        <p>Copyright ©2022 All rights reserved</p>
    </footer>

</body>
</html>
