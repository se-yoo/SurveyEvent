<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
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
#form {
	padding-top: 50px;
	padding-bottom: 50px;
	display: inline-block;
	width: 70%;
	background-color: white;
}

#formBox {
	display: inline-block;
	width: 37%;
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
}

.qq {
	margin: 10px auto 0px auto;
}
</style>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String sId=request.getParameter("id");
	
	String pName="";
	String img="";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs=null;

	try{
		String url = "jdbc:mysql://localhost:3306/surveyEvent?useUnicode=true&characterEncoding=utf-8";  
		String did = "root";  
		String dpw = "1234";
		int c=0;

		Class.forName("com.mysql.jdbc.Driver");    
		conn=DriverManager.getConnection(url,did,dpw);  
		
		String sql = "select * from buyProduct where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,sId);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			pName=rs.getString("productName");
			img=rs.getString("productPic");
		}
	
	}catch(Exception e){
		System.out.println(e.toString());
	}finally{
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(conn != null) try{conn.close();}catch(SQLException sqle){}
	}
%>
	<div id="form">
		<div id="formBox">
			<div style="font-size:1.5em;">구매 내역<br>(<%=pName %>)</div><hr>
			<br><br>
			<div style="margin:auto"><img src="<%=img%>" height="350px"></div>
			<hr>
		</div>
	</div><br>
</body>
</html>