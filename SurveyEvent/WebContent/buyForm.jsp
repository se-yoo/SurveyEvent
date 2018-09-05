<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String id = (String) session.getAttribute("id");
	if (id == null) {
		response.sendRedirect("login.jsp");
	} else {
%><jsp:forward page="templateTest.jsp">
<jsp:param name="CONTENTPAGE" value="buyFormProc.jsp" />
</jsp:forward>
<%
	}
%>