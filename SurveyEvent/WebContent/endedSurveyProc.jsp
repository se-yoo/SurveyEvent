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
	<a href="writeSurvey.jsp"><img src="resources/banner.png" width="40%"></a><br><br>
	<table id="f" border="0" cellpadding="0" cellspacing="20" style="margin:auto">
	<%
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
		
		String sql = "select * from surveys where date(endDate)<=date_format(now(),'%Y-%m-%d') order by id desc";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			if(c%4==0){%><tr><%}
			c++;
			%>
			<td class="surv" width='20%'><a href="endSurv.jsp?id=<%=rs.getString("id") %>"><h3><%=rs.getString("title") %><br></h3></a><br>
			상품 <span><%= rs.getString("pName")%></span><br>마감날짜 <span><%= rs.getString("endDate")%></span></td>
			<%
			if(c%4==0){%></tr><%}
		}
		if(c%4!=0){
			for(int i=0;i<4-c%4;i++){
				%><td width='20%'></td><%
			}
			%></tr><%
		}
	
	}catch(Exception e){
		System.out.println(e.toString());
	}finally{
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(conn != null) try{conn.close();}catch(SQLException sqle){}
	}
	%></table>
</body>
</html>