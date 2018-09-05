<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	String id = (String) session.getAttribute("id");
	String uploadPath = application.getRealPath("resources/"+id);
	request.setCharacterEncoding("UTF-8");
	
	File findDir=new File(uploadPath);
	
	if(!findDir.exists())findDir.mkdirs();

	int size = 10 * 1024 * 1024;
	String title = "";
	String prize = "";
	String connect = "";
	String img = "";
	String eDate = "";
	int qCnt=0;

	try {
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8",new DefaultFileRenamePolicy());

		qCnt = Integer.parseInt(multi.getParameter("qCnt"));
		title = multi.getParameter("title");
		prize = multi.getParameter("prize");
		connect = multi.getParameter("connect");
		img = multi.getParameter("img");
		eDate = multi.getParameter("eDate");

		Enumeration files = multi.getFileNames();
		String file1 = (String) files.nextElement();
		img = multi.getFilesystemName(file1);
		
		long qId = System.currentTimeMillis();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;

		try{
			String url = "jdbc:mysql://localhost:3306/surveyEvent?useUnicode=true&characterEncoding=utf-8";  
			String did = "root";  
			String dpw = "1234";

			Class.forName("com.mysql.jdbc.Driver");    
			conn=DriverManager.getConnection(url,did,dpw);  
			
			String sql =  "insert into surveys(id,writer,connect,title,pName,pPic,endDate,qCnt) values(?,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);				
			pstmt.setString(1,qId+"");
			pstmt.setString(2,id);
			pstmt.setString(3,connect);
			pstmt.setString(4,title);
			pstmt.setString(5,prize);
			pstmt.setString(6,"resources/"+id+"/"+img);
			pstmt.setString(7,eDate);
			pstmt.setInt(8,qCnt);

			pstmt.execute(); 
			
			Statement stmt = conn.createStatement();
			
		    sql = "create table q"+qId+"(num int auto_increment PRIMARY KEY,userId varchar(50),";
		    for(int i=1;i<=qCnt;i++){
		    	sql+=("q"+i)+" int";
		    	if(i!=qCnt)sql+=",";
		    }
		    sql+=",FOREIGN KEY (userId) REFERENCES users(id))";

		    stmt.executeUpdate(sql);
			
		}catch(Exception e){
			System.out.println(e.toString());
		}
		
		int aCnt[]=new int[qCnt];
		
		for(int i=1;i<=qCnt;i++){
			aCnt[i-1]=Integer.parseInt(multi.getParameter("q"+i+"ACnt"));
		}
		
		String filePath = application.getRealPath("/WEB-INF/question/" + qId + ".txt");
		PrintWriter wr = new PrintWriter(new FileWriter(filePath));
		BufferedWriter bw = new BufferedWriter(wr);
		
		for(int i=1;i<=qCnt;i++){
			bw.write(multi.getParameter("q"+i));
			for(int j=0;j<aCnt[i-1];j++){
				bw.write("`"+multi.getParameter("a"+i+"_"+(j+1)));
			}
			bw.newLine();
		}
		bw.close();
		wr.flush();
		
	} catch (Exception e) {
		System.out.println(e.toString());
	}
%>
<body>
	<meta http-equiv='refresh' content='0; url=main.jsp'>
</body>