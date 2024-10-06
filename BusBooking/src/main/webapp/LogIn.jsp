<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=ISO-8859-1" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Login - Get Bus-y</title>
    <link href="bus.css" rel="stylesheet" />
    <script>
        function validateForm() {
            const userId = document.forms["loginfrm"]["txtuserid"].value;
            const password = document.forms["loginfrm"]["txtpass"].value;
            const userIdRegex = /^[a-zA-Z0-9]+$/; // Only alphanumeric characters

            // Check for empty fields
            if (userId.trim() === "") {
                alert("User ID cannot be empty.");
                return false;
            }

            if (!userIdRegex.test(userId)) {
                alert("User ID can only contain alphanumeric characters.");
                return false;
            }

            if (password.length < 6) {
                alert("Password must be at least 6 characters long.");
                return false;
            }

            return true; // Form is valid
        }
    </script>
</head>
<body>
    <header class="header-class">
        <div class="logo">
            <span> Get </span> <span class="trusted">Bus-y</span>
        </div>
        <div style="font-family: sans-serif; font-size: xx-large; color: coral; font-weight: 800">
            WELCOME
        </div>
        <div class="nav">
            <a href="#login" class="login">Login/SignUp</a>
        </div>
    </header>

    <article class="hero">
        <form name="loginfrm" action="login" class="loginfrm" method="post" onsubmit="return validateForm()">
            <div class="article_Title">Login</div>
            <c:if test="${not empty requestScope.msg}">
                <div class="err">${requestScope.msg}</div>
            </c:if>
            <section>
                <div>User ID</div>
                <div>
                    <input type="text" name="txtuserid" placeholder="Enter your userid" required />
                </div>
            </section>
            <section>
                <div>Password</div>
                <div>
                    <input type="password" name="txtpass" placeholder="Enter your password" required />
                </div>
            </section>
            <section>
                <div>
                    <input type="submit" value="Login" />
                </div>
            </section>
        </form>
    </article>
    
    <footer class="footer-bottom">
        <p>Copyright ©2022 All rights reserved</p>
    </footer>
</body>
</html>
