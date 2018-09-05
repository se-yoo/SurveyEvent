<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
#sMenu a{
	margin: 0px 30px;
}

#sMenu a:link, #sMenu a:visited, #sMenu a:active,#sMenu a:hover{
	text-decoration: none;
}
</style>
</head>
<body>
	<div id="sMenu"><%
		request.setCharacterEncoding("UTF-8");
		int type=Integer.parseInt(request.getParameter("type"));
		String color[]={"#2b1850","#2b1850","#2b1850"};
		String id = (String) session.getAttribute("id");
		color[type-1]="#bfb0dd";
		int save=0;
		
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
			
			String sql = "select * from users where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			
			if(rs.next())save=rs.getInt("save");
		
	%>	<h3><%=id %>님의 포인트 : <%=save %></h3><br>
		<a href="myPage.jsp?type=1" style="color:<%=color[0]%>">작성한 설문</a> |
		<a href="myPage.jsp?type=2" style="color:<%=color[1]%>">당첨된 설문</a> | <a href="myPage.jsp?type=3" style="color:<%=color[2]%>">구매한 상품 </a>
		| <a href="logOut.jsp" style="color:#2b1850">로그아웃</a>
	</div><br>
	<table id="f" border="0" cellpadding="0" cellspacing="20" style="margin:auto">
	<%
		sql = "select * from ";
		if(type==1){
			sql+="surveys where writer=?";
		}else if(type==2){
			sql+="eventInfo where winner=?";
		}else if(type==3){
			sql+="buyProduct where clientid=?";
		}
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		rs = pstmt.executeQuery();
		
		if(type==1){
			while (rs.next()) {
				if(c%4==0){%><tr><%}
				c++;
				
				SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
				
				String sql2 = "select * from eventInfo where id=?";
				
				PreparedStatement pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setString(1,rs.getString("id"));
				ResultSet rs2 = pstmt2.executeQuery();
				
				String clickUrl="";
				boolean endEvent=rs2.next();
				
				if(rs.getString("endDate").compareTo(transFormat.format(new Date()))>0){
					clickUrl="endSurv.jsp?id=";
				}else if(!endEvent){
					clickUrl="survWin.jsp?id=";
				}else{
					clickUrl="resultSurv.jsp?id=";
				}
				
				%>
				<td class="surv" width='20%'><a href="<%=clickUrl+rs.getString("id") %>"><h3><%=rs.getString("title") %><br></h3></a><br>
				상품 <span><%= rs.getString("pName")%></span><br>
				<%

				if(rs.getString("endDate").compareTo(transFormat.format(new Date()))>0){
					%>마감날짜 <span><%= rs.getString("endDate")%></span><%
				}else if(!endEvent){
					%><span style="font-size:0.8em;font-weight:bold">※이벤트 당발하고 결과 확인하세요</span><%
				}else{
					%><font style="font-size:0.8em">상태</font> <span style="font-size:0.8em;">당발완료/설문결과확인가능</span><%
				}
				%></td>
				<%
				if(c%4==0){%></tr><%}
			}
			if(c%4!=0){
				for(int i=0;i<4-c%4;i++){
					%><td width='20%'></td><%
				}
				%></tr><%
			}
		}
		else if(type==2){
			while (rs.next()) {
				String sql2 = "select * from surveys where id=?";
				
				PreparedStatement pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setString(1,rs.getString("id"));
				ResultSet rs2 = pstmt2.executeQuery();
				
				while(rs2.next()){
				if(c%4==0){%><tr><%}
				c++;
				%>
				<td class="surv" width='20%'><a href="eventInfo.jsp?id=<%=rs2.getString("id") %>"><h3><%=rs2.getString("title") %><br></h3></a><br>
				상품 <span><%= rs2.getString("pName")%></span><br>마감날짜 <span><%= rs2.getString("endDate")%></span></td>
				<%
				if(c%4==0){%></tr><%}
				}
			}
			if(c%4!=0){
				for(int i=0;i<4-c%4;i++){
					%><td width='20%'></td><%
				}
				%></tr><%
			}
		}
		else if(type==3){
			while (rs.next()) {
				if(c%4==0){%><tr><%}
				c++;
				%>
				<td class="surv" width='20%'><a href="productInfo.jsp?id=<%=rs.getString("id") %>"><h3><%=rs.getString("productName") %><br></h3></a><br>
				<span>기프티콘을 보려면 상품이름을 누르세요</span></td>
				<%
				if(c%4==0){%></tr><%}
			}
			if(c%4!=0){
				for(int i=0;i<4-c%4;i++){
					%><td width='20%'></td><%
				}
				%></tr><%
			}
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