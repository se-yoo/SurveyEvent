<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title></title>
<style>
#f{
	width:70%; text-align:center;
}
#f a:link,#f a:visited,#f a:active{
	text-decoration:none;
	color:#75619e;
}
#f a:hover{
	text-decoration:none;
	color:#cec0ea;
}
.surv{
	height:100px;
	background-color:white;
	color:#75619e;
	padding:15px 15px 10px 15px;
	text-align:left;
	margin:20px;
	border:2px solid #cec0ea;
}
.surv h3{
	margin:5px;
}
.surv span{
	color:#bfb0dd;
}
</style>
</head>
<body>
	<table id="f" border="0" cellpadding="0" cellspacing="20" style="margin:auto">
		<tr>
		<td width="20%"><a href="buyForm.jsp?id=1"><img src="resources/product/1.jpg" width="100%"></a></td>
		<td width="20%"><a href="buyForm.jsp?id=2"><img src="resources/product/2.jpg" width="100%"></a></td>
		<td width="20%"><a href="buyForm.jsp?id=3"><img src="resources/product/3.jpg" width="100%"></a></td>
		<td width="20%"><a href="buyForm.jsp?id=4"><img src="resources/product/4.jpg" width="100%"></a></td>
		</tr>
	</table>
</body>
</html>