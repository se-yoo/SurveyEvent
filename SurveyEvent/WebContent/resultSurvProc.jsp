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
.color{
		display:inline-block;
		width:15px;
		height:15px;
		margin-left:15px;
}
</style>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String sId=request.getParameter("id");
	
	String title="";
	int qCnt=0;
	String winner="";
	
	String color[]={"#fb7171","#fb9b71","#fbc571","#fbe671","#dffb71","#9ad877","#addef7","#adbdf7","#bfadf7","#f7adea"};
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs=null;

	try{
		String url = "jdbc:mysql://localhost:3306/surveyEvent?useUnicode=true&characterEncoding=utf-8";  
		String did = "root";  
		String dpw = "1234";

		Class.forName("com.mysql.jdbc.Driver");    
		conn=DriverManager.getConnection(url,did,dpw);  
		
		String sql = "select * from surveys where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,sId);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			title=rs.getString("title");
			qCnt=rs.getInt("qCnt");
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
	
	int totalCnt=0;
	int aCnt[][]=new int[qCnt][10];
	int ac[]=new int[qCnt];

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
		String url = "jdbc:mysql://localhost:3306/surveyEvent?useUnicode=true&characterEncoding=utf-8";  
		String did = "root";  
		String dpw = "1234";

		Class.forName("com.mysql.jdbc.Driver");    
		conn=DriverManager.getConnection(url,did,dpw); 
		
		String sql2 = "select count(*) from q"+sId;
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		ResultSet rs2 = pstmt2.executeQuery();

		if(rs2.next()) {
			totalCnt=rs2.getInt(1);
		}
		
		for(int i=1;i<=qCnt;i++){
			for(int j=1;j<=10;j++){
				if(a[i-1][j-1]!=null){
					sql2 = "select count(*) from q"+sId+" where q"+i+"="+j;

					pstmt2 = conn.prepareStatement(sql2);
					rs2 = pstmt2.executeQuery();
		
					if(rs2.next()) {
						aCnt[i-1][j-1]=rs2.getInt(1);
					}
					ac[i-1]=j;
				}
			}
		}
	} catch (Exception e) {

	}finally{
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(conn != null) try{conn.close();}catch(SQLException sqle){}
	}
%>
	<div id="form">
			<div id="formBox">
				<div style="font-size:1.5em;"><%=title %></div><hr>
				<br><span style="font-size: 0.7em"> 참여인원수 >> <%=totalCnt %>
				<br> 당첨자 >> <%=winner %></span><br><br>
				<%
				out.println("<input type='hidden' id='total' value='"+totalCnt+"'>");
				out.println("<input type='hidden' id='cnt' value='"+qCnt+"'>");
					for(int i=0;i<qCnt;i++){%>
						<br><br><span style="font-size:1.1em;">Q. <%=q[i] %></span><br><br>
					<%
					out.println("<input type='hidden' id='q"+(i+1)+"' value='"+ac[i]+"'>");
						for(int j=0;j<10;j++){
							if(a[i][j]!=null){
							out.println("<input type='hidden' id='a"+i+"_"+j+"' value='"+aCnt[i][j]+"'>");%>
							<div class="color" style="background-color:<%=color[j]%>"></div> <%=a[i][j] %>
							<span style="color:<%=color[j]%>;font-weight:bold;"><%= (Math.round(10000*aCnt[i][j]/(double)totalCnt)/100.0) %>%</span><br>
							<%}
						}
						%>
						<br><canvas id="graph<%=(i+1) %>" width="500px" height="400px"></canvas>
						<%
					}
				%>
				<br><br>
	</div></div><br><br>
	
	<script>
	
	var color=["#fb7171","#fb9b71","#fbc571","#fbe671","#dffb71","#9ad877","#addef7","#adbdf7","#bfadf7","#f7adea"];
	var i=0;
	var total=Number(document.getElementById("total").value);
	var qC=document.getElementById("cnt").value;
	
	for(i=0;i<qC;i++){
		var c = document.getElementById("graph"+(i+1));
		var ctx = c.getContext("2d");
		var aC=document.getElementById("q"+(i+1)).value;
		var result=new Array();
		var startPoint=1.5*Math.PI;
		for(j=0;j<aC;j++){
			result[j]=Number(document.getElementById("a"+i+"_"+j).value);
			
			ctx.beginPath();
			ctx.moveTo(150,150);
			ctx.arc(150,150,150, startPoint, startPoint + result[j]/total*2*Math.PI);
			ctx.closePath();
			ctx.fillStyle=color[j];
			ctx.fill();
			
			startPoint += result[j]/total*2*Math.PI
		}
	}
</script>
</body>
</html>