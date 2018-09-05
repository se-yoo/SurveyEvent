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
button{
	background-color:white;
	color:#bfb0dd;
	border:0px;
	padding:10px 0px;
	margin: 10px;
	width:45%;
}
input[type='submit']{
	background-color:white;
	color:#bfb0dd;
	border:0px;
	padding:10px 0px;
	margin: 10px;
	width:80%;
}
</style>
<script>
	function random(){
		document.getElementById("type").value="random";
		document.getElementById("prize").submit();
	}
	function custom(){
		document.getElementById("type").value="custom";
		document.getElementById("h").innerHTML="";
		var h=document.getElementById("h");
		var total=document.getElementById("total").value;
		for(i=0;i<total;i++){
			var e=document.createElement("div");
			e.innerHTML="<input type='radio' name='select' value='"+(i+1)+"' required> "+(i+1)+"번";
			h.appendChild(e);
		}
		var s=document.createElement("div");
		s.innerHTML="<input type='submit' value='선택된 번호를 당첨시키기'>";
		h.appendChild(s);
	}
</script>
</head>
<body>
	<% 
		request.setCharacterEncoding("UTF-8");
		String sId=request.getParameter("id");
		
		String type=request.getParameter("type");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		
		int total=0;

		try{
			String url = "jdbc:mysql://localhost:3306/surveyEvent?useUnicode=true&characterEncoding=utf-8";  
			String did = "root";  
			String dpw = "1234";

			Class.forName("com.mysql.jdbc.Driver");    
			conn=DriverManager.getConnection(url,did,dpw);  
			
			String sql = "select count(*) from q"+sId;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				total=rs.getInt(1);
			}
			out.println("<input type='hidden' id='total' value="+total+">");
		}catch(Exception e){
			System.out.println(e.toString());
		}finally{
			if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
			if(conn != null) try{conn.close();}catch(SQLException sqle){}
		}
	%>
	<br><br><form action="survPrize.jsp?id=<%=sId%>" method="post" id="prize">
	<input type="hidden" name="type" id="type">
	<div style="width:50%;margin:auto"><button onclick="random()">랜덤 뽑기</button>
	<button onclick="custom()">직접 뽑기(숫자로만 보여집니다)</button>
	<br><br><div id="h"><br></div><br></div>
	</form>
	<br><br>
</body>
</html>