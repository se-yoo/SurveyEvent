<%@page import="java.util.StringTokenizer"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.File"%>
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
	
	String title="";
	int qCnt=0;
	String eDate="";
	String pName="";
	String winner="아직 당발하지 않았습니다";
	
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
		
		String sql = "select * from surveys where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,sId);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			title=rs.getString("title");
			qCnt=rs.getInt("qCnt");
			eDate=rs.getString("endDate");
			pName=rs.getString("pName");
		}
		
		sql = "select * from eventInfo where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,sId);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			winner=rs.getString("winner");
		}
	
	}catch(Exception e){
		System.out.println(e.toString());
	}finally{
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(conn != null) try{conn.close();}catch(SQLException sqle){}
	}
	
	String q[]=new String[qCnt];
	String a[][]=new String[qCnt][10];

	try {
		String filePath = application.getRealPath("/WEB-INF/question/" + sId + ".txt");
		BufferedReader reader = new BufferedReader(new FileReader(filePath));
		String tmpStr = "";

		for(int j=0;j<qCnt;j++){
			tmpStr = reader.readLine();
			StringTokenizer parse = new StringTokenizer(tmpStr, "`");
			q[j]=parse.nextToken();
			int i=0;
			while(parse.hasMoreTokens()){
				a[j][i++]=parse.nextToken();
			}
		}
	} catch (Exception e) {

	}
%>
	<div id="form">
		<div id="formBox">
				<div style="font-size:1.5em;"><%=title %></div><hr>
				<br><span style="font-size: 0.7em">상품 >> <%=pName %>
				<br> 마감날짜 >> <%=eDate %>
				<br> 당첨된 분 >> <%=winner %></span><br><br>
				<%
					for(int i=0;i<qCnt;i++){%>
						<br><br><span style="font-size:1.1em;">Q. <%=q[i] %></span><br><br>
					<%
						for(int j=0;j<10;j++){
							if(a[i][j]!=null){%>
							o <%=a[i][j] %><br>
							<%}
						}
					}
				%>
		</div>
	</div><br><br>
</body>
</html>