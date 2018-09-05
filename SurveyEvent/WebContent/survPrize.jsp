<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String result="";
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
		
		String user[]=new String[total];
		
		sql = "select userId from q"+sId;
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		int i=0;
		while(rs.next()){
			user[i]=rs.getString("userId");
			i++;
		}
		if(type.equals("random")){
			int randNum=(int)(Math.random()*total);
			String winner=user[randNum];
			
			String sql2 =  "insert into eventInfo(id,winner) values(?,?)";

			PreparedStatement pstmt2 = conn.prepareStatement(sql2);				
			pstmt2.setString(1,sId);
			pstmt2.setString(2,winner);

			pstmt2.execute();

			out.println("<script>alert('당첨자인 "+winner+"님에게 상품이 전송되었습니다');</script>");
		}else{
			int num=Integer.parseInt(request.getParameter("select"));
			String winner=user[num-1];
			System.out.println(winner);
			
			String sql2 = "insert into eventInfo(id,winner) values(?,?)";

			PreparedStatement pstmt2 = conn.prepareStatement(sql2);				
			pstmt2.setString(1,sId);
			pstmt2.setString(2,winner);

			pstmt2.execute();
			out.println("<script>alert('당첨자인 "+winner+"님에게 상품이 전송되었습니다');</script>");
		}
	}catch(Exception e){
		System.out.println(e.toString());
	}finally{
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(conn != null) try{conn.close();}catch(SQLException sqle){}
	}
%><meta http-equiv='refresh' content='0; url=myPage.jsp?type=1'>
</body>
</html>