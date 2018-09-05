<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title></title>
<style>
body {
  background: #efeaf7;
  font-family: "Roboto";
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
body::before {
  z-index: -1;
  content: '';
  position: fixed;
  top: 0;
  left: 0;
  background: #efeaf7;
  /* IE Fallback */

  background: #efeaf7;
  width: 100%;
  height: 100%;
}
.form {
  position: absolute;
  top: 40%;
  left: 50%;
  background: #fff;
  width: 285px;
  margin: -140px 0 0 -182px;
  padding: 40px;
  box-shadow: 0 0 3px rgba(0, 0, 0, 0.3);
}
.form input {
  outline: none;
  display: block;
  width: 100%;
  margin: 0 0 20px;
  padding: 10px 15px;
  border: 1px solid #ccc;
  color: #ccc;
  font-family: "Roboto";
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  font-size: 14px;
  font-wieght: 400;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  -webkit-transition: 0.2s linear;
  -moz-transition: 0.2s linear;
  -ms-transition: 0.2s linear;
  -o-transition: 0.2s linear;
  transition: 0.2s linear;
}
.form input:focus {
  color: #333;
  border: 1px solid #e3d5ff;
}
.form button {
  cursor: pointer;
  background: #e3d5ff;
  width: 100%;
  padding: 10px 15px;
  border: 0;
  color: #fff;
  font-family: "Roboto";
  font-size: 14px;
  font-weight: 400;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  -webkit-transition: 0.2s linear;
  -moz-transition: 0.2s linear;
  -ms-transition: 0.2s linear;
  -o-transition: 0.2s linear;
  transition: 0.2s linear;
}
.form button:hover {
  background: #2b1850;
}

a, a:link {
  text-decoration: none;
  color:#2b1850;
}

a:hover {
  text-decoration: underline;
}
</style>
</head>
<body>
	<div class="form animated bounceIn" style="text-align:center">
  <img src="resources/logo_2.png" width="80%">
  <form action="signIn.jsp" method="post">
    <input placeholder="Username" type="text" name="user"></input>
    <input placeholder="Password" type="password" name="password"></input>
    <button class="animated infinite pulse">Login</button>
  </form><br>
	Not a member? <a href="signUp.jsp">Sign up now</a>
</div>
</body>
</html>