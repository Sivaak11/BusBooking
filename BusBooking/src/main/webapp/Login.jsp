<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href="bus.css" rel="stylesheet" />
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

		<div class="article_Titile">Login</div>
		<div class="err">${requestScope.msg }</div>
		<form action="login" method="post">
			<div class="loginfrm">
				<section>
					<div>User Name</div>
					<div>
						<input type="text" name="txtuname" />
					</div>
				</section>
				<section>
					<div>Password</div>
					<div>
						<input type="password" name="txtpass" />
					</div>
				</section>
				<section>

					<div>
						<input type="submit" value="login" />
					</div>
				</section>
			</div>
		</form>
	</article>
</body>
</html>