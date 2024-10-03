<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Bus Booking</title>
    <link rel="stylesheet" href="bus.css">
</head>
<body>
    <header>
        <div class="header-class">
            <div class="logo">
                <span style="color: red;"> Get </span> <span class="trusted">Bus-y</span>
            </div>
            <div class="well">
                <a href="#">WELCOME</a>
            </div>
            <div class="nav">
                <a href="#login" class="login">Login/SignUp</a>
            </div>
        </div>
    </header>
    <article class="hero">
        <div class="overlay">
            <h1>Book Your Tickets</h1>
            <section class="booking-form">
                <form action="findbus" >
                    <input type="text" name="txtdeparture" placeholder="From" required />
                    <input type="text" name="txtarrival" placeholder="To" required />
                    
                    <%                        
                        Calendar cal = Calendar.getInstance();
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        String minDate = sdf.format(cal.getTime());
                      
                        cal.add(Calendar.DAY_OF_MONTH, 60);
                        String maxDate = sdf.format(cal.getTime());
                    %>
                    
                    <input type="date" id="travel-date" name="txtdate" required 
                        min="<%= minDate %>" max="<%= maxDate %>" />
                    <button type="submit" class="search-btn">Search bus</button>
                </form>
            </section>
        </div>
    </article>
    <footer class="footer-bottom">
        <p>Copyright ©2022 All rights reserved</p>
    </footer>
</body>
</html>