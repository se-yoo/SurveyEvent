<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page
	import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title></title>
</head>
<%
	String userid = (String) session.getAttribute("id");
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	int qCnt = 0;

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		String url = "jdbc:mysql://localhost:3306/surveyEvent?useUnicode=true&characterEncoding=utf-8";
		String did = "root";
		String dpw = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, did, dpw);

		String sql2 = "select * from q" + id + " where userId=?";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, userid);
		rs = pstmt.executeQuery();

		if (rs.next()) {
			out.println("<script>alert('이미 참여하셨습니다')</script>");
		} else {
			String sql = "select * from surveys where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				qCnt = rs.getInt("qCnt");
			}

			int a[] = new int[qCnt];
			for (int i = 0; i < qCnt; i++) {
				a[i] = Integer.parseInt(request.getParameter("q" + (i + 1)));
			}

			sql = "insert into q" + id + "(num,userId";
			for (int i = 1; i <= qCnt; i++)
				sql += (",q" + i);
			sql += ") values(?,?";
			for (int i = 1; i <= qCnt; i++)
				sql += ",?";
			sql += ")";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 0);
			pstmt.setString(2, userid);
			for (int i = 0; i < qCnt; i++)
				pstmt.setInt(i + 3, a[i]);

			pstmt.execute();
			
			sql = "select * from users where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			int save=10;
			
			if(rs.next())save+=rs.getInt("save");
			
			sql="update users set save=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,save);
			pstmt.setString(2, userid);
			int b = pstmt.executeUpdate();
		}

	} catch (Exception e) {
		System.out.println(e.toString());
	}
%>
<body>
	<meta http-equiv='refresh' content='0; url=main.jsp'>
</body>