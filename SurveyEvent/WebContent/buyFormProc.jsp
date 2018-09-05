<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title></title>
<style>
#form {
	padding-top: 50px;
	padding-bottom: 50px;
	display: inline-block;
	width: 70%;
	background-color: white;
}

#formBox {
	display: inline-block;
	width: 35%;
	text-align: left;
	color: #2b1850;
}

#upload {
	width: 90%;
	margin: 10px 0px;
}

input {
	font-family: Nanum;
}

input[type='button'], input[type='submit'] {
	background-color: #cec0ea;
	color: white;
	border: 0px;
	padding: 5px;
	width:100%;
}

.qq {
	margin: 10px auto 0px auto;
}
</style>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	int pId=Integer.parseInt(request.getParameter("id"));
	
	String info[]={"[롯데리아]핫크리스피세트","[BHC]BHC 양념치킨 + 콜라 1.25L","[롯데리아]와일드쉬림프버거세트","[도미노피자]페퍼로니M+콜라1.25L"};
	int price[]={6300,17500,6500,15390};
%>
	<div id="form">
		<form action="buy.jsp?id=<%=pId %>" method="post">
			<div id="formBox">
				<div style="font-size:1.5em;"><%=info[pId-1] %></div><hr>
				<br><br>
				<div style="margin:auto"><img src="<%="resources/product/"+pId+".jpg"%>" height="350px"></div>
				<br><input id="buy" type="submit" value="구매하기"><br>
			</div>
		</form>
	</div><br>
</body>
</html>