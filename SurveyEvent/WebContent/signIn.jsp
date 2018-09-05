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
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("user");
	String pw=request.getParameter("password");
	
	try{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;

		try{
			String url = "jdbc:mysql://localhost:3306/surveyEvent";  
			String did = "root";  
			String dpw = "1234";

			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url,did,dpw);  
			
			String sql = "select * from users where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(pw.equals(rs.getString("pw"))){
					session.setAttribute("id", id);
					%><meta http-equiv='refresh' content='0; url=main.jsp'><%
				}else{
					out.println("<script>alert('아이디 혹은 비밀번호가 일치하지 않습니다')</script>");
					%><meta http-equiv='refresh' content='0; url=login.jsp'><%
				}
			}else{
				out.println("<script>alert('없는 계정입니다')</script>");
				%><meta http-equiv='refresh' content='0; url=login.jsp'><%
			}
		
		}catch(Exception e){
			System.out.println(e.toString());
		}finally{
			if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
			if(conn != null) try{conn.close();}catch(SQLException sqle){}
		}
	}catch(Exception e){
		out.println(e.toString());
	}
	%>
</body>
</html>