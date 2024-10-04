<%@ page language="java" contentType="text/html; charset=ISO-8859-1"

    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Login - Get Bus-y</title>
<link href="bus.css" rel="stylesheet" />
<style>

    .loginfrm {
        background-color: white;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
        max-width: 400px;
        width: 100%;
        text-align: center;
    }

    .loginfrm section {
        margin-bottom: 20px;
    }

    .loginfrm section div:first-child {
        margin-bottom: 10px;
        font-weight: bold;
        text-align: left;
    }

    input[type="text"], input[type="password"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
    }

    input[type="submit"] {
        background-color: #ffcc00;
        border: none;
        padding: 12px 20px;
        border-radius: 5px;
        font-size: 18px;
        color: #333;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover {
        background-color: #e6b800;
    }

    .err {
        color: red;
        margin-bottom: 15px;
    }

    .article_Titile {
        font-size: 28px;
        font-weight: bold;
        color: #333;
        margin-bottom: 20px;
    }
</style>
</head>
<body>
    <header class="header-class">
        <div class="logo">
            <span> Get </span> <span class="trusted">Bus-y</span>
        </div>
        <div class="well">
            <a href="#">WELCOME</a>
        </div>
        <div class="nav">
            <a href="#login" class="login">Login/SignUp</a>
        </div>
    </header>
    <article class="hero">
        <form action="login" method="post" class="loginfrm">
            <div class="article_Titile">Login</div>
            <div class="err">${requestScope.msg }</div>
            <section>
                <div>User Name</div>
                <div>
                    <input type="text" name="txtuname" placeholder="Enter your username" required/>
                </div>
            </section>
            <section>
                <div>Password</div>
                <div>
                    <input type="password" name="txtpass" placeholder="Enter your password" required/>
                </div>
            </section>
            <section>
                <div>
                    <input type="submit" value="Login" />
                </div>
                <a href="">NewUser?SignUp</a>
            </section>
        </form>
    </article>
    <footer class="footer-bottom">
        <p>Copyright ©2022 All rights reserved</p>
    </footer>
</body>
</html>

