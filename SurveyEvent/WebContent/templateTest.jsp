<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문, 선물</title>
<style>
	@font-face{
		font-family:Nanum;
		src:url('NanumBarunGothicLight.ttf') format('truetype');
	}
	body{
		color:gray;
		text-align:center;
		font-family:Nanum;
		background-color:#efeaf7;
	}
	table{
		text-align:center;
	}
	#menu{
		display:inline-block;
		width:70%;
		height:50px;
		background-color:white;
		border-radius:15px;
		font-size:1.3em;
		padding-top:30px;
	}
	#menu a{
		margin:0px 30px;
	}
	#menu a:link,#menu a:visited,#menu a:active{
		color:#cec0ea;
		text-decoration: none;
	}
	#menu a:hover{
		color:#2b1850;
		text-decoration: none;
	}
</style>
</head>
<body>
<%
	String contentpage=request.getParameter("CONTENTPAGE");
%>
<table id="table" border="0px" cellpadding="2" cellspacing="0" width="100%">
<tr height="15%">
	<td style="text-align:left;margin:auto;">
		<table style="text-align:center;margin-left:15%;">
			<tr>
			<td width="20%" style="text-align:right"><a href="main.jsp"><img src="resources/logo.png" width="90%"></a></td>
			<td width="60%" style="text-align:left"><div id="menu" style="text-align:center">
			<a href="main.jsp">설문참여</a>
			<a href="endedSurvey.jsp">종료된 설문</a>
			<a href="shop.jsp">상점</a>
			<a href="myPage.jsp?type=1">마이페이지</a></div></td>
			</tr>
		</table>
	</td>
</tr>
<tr style="vertical-align:top; ">
	<td>
		<jsp:include page="<%= contentpage %>"></jsp:include>
	</td>
</tr>
</table>
</body>
</html>