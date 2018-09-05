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
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("user");
	String pw=request.getParameter("password");
	String pw2=request.getParameter("password2");
	String memberAll="";
	
	if(pw.equals(pw2)){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;

		try{
			String url = "jdbc:mysql://localhost:3306/surveyEvent?useUnicode=true&characterEncoding=utf-8";  
			String did = "root";  
			String dpw = "1234";

			Class.forName("com.mysql.jdbc.Driver");    
			conn=DriverManager.getConnection(url,did,dpw);  
			
			String sql = "select * from users where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				out.println("<script>alert('이미 존재하는 계정입니다')</script>");
				%><meta http-equiv='refresh' content='0; url=signUp.jsp'><%
			}else{
				pstmt = null;
				String sql2 = "insert into users(id,pw,save) values(?,?,?)";

				pstmt = conn.prepareStatement(sql2);				
				pstmt.setString(1,id);
				pstmt.setString(2,pw);
				pstmt.setInt(3,0);

				pstmt.execute();  
				out.println("<script>alert('계정을 생성했습니다')</script>");
				%><meta http-equiv='refresh' content='0; url=login.jsp'><%
			}
		
		}catch(Exception e){
			System.out.println(e.toString());
		}finally{
			if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
			if(conn != null) try{conn.close();}catch(SQLException sqle){}
		}
	}else{
		out.println("<script>alert('입력한 비밀번호와 비밀번호 확인이 일치하지 않습니다')</script>");
		%><meta http-equiv='refresh' content='0; url=signUp.jsp'><%
	}
	%>
</body>
</html>