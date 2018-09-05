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
	int pId=Integer.parseInt(request.getParameter("id"));
	String id = (String) session.getAttribute("id");
	
	String info[]={"[롯데리아]핫크리스피세트","[BHC]BHC 양념치킨 + 콜라 1.25L","[롯데리아]와일드쉬림프버거세트","[도미노피자]페퍼로니M+콜라1.25L"};
	int price[]={6300,17500,6500,15390};
	
	int save=0;
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs=null;

	try{
		String url = "jdbc:mysql://localhost:3306/surveyEvent?useUnicode=true&characterEncoding=utf-8";  
		String did = "root";  
		String dpw = "1234";

		Class.forName("com.mysql.jdbc.Driver");    
		conn=DriverManager.getConnection(url,did,dpw);  
		
		String sql = "select * from users where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			save=rs.getInt("save");
		}
		
		if(save-price[pId-1]>=0){
			save-=price[pId-1];
			sql =  "insert into buyProduct(id,clientid,productName,productPic) values(?,?,?,?)";
			
			long qId = System.currentTimeMillis();
			
			pstmt = conn.prepareStatement(sql);				
			pstmt.setString(1,qId+"");
			pstmt.setString(2,id);
			pstmt.setString(3,info[pId-1]);
			pstmt.setString(4,"resources/product/"+pId+".jpg");

			pstmt.execute(); 
			
			sql="update users set save=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,save);
			pstmt.setString(2, id);
			int b = pstmt.executeUpdate();
			%><meta http-equiv='refresh' content='0; url=main.jsp'><%
		}else{
			out.println("<script>alert('포인트가 부족합니다');</script>");
			%><meta http-equiv='refresh' content='0; url=main.jsp'><%
		}
	
	}catch(Exception e){
		System.out.println(e.toString());
	}finally{
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(conn != null) try{conn.close();}catch(SQLException sqle){}
	}
%>
</body>
</html>