<%@ page contentType="text/html; charset=UTF-8" %>
<link rel="stylesheet" type="text/css" href="login.css">
<%@ page import="java.sql.*" %>
<html>
<head><title>수강신청 사용자 정보 수정</title></head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id==null) response.sendRedirect("login.jsp"); %>
<%
Connection myConn = null; Statement stmt = null;
ResultSet myResultSet = null; String mySQL = "";
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user="c##jueun"; String passwd="jueun2023";
String dbdriver = "oracle.jdbc.driver.OracleDriver"; 

try {
	Class.forName("oracle.jdbc.driver.OracleDriver");
	myConn = DriverManager.getConnection(dburl,user,passwd );
	stmt = myConn.createStatement();
} catch(SQLException ex) {
	System.err.println("SQLException: " + ex.getMessage());
}
	mySQL = "select m_name, m_addr, m_pwd from member where m_id='" + session_id + "'";
	myResultSet = stmt.executeQuery(mySQL);
if (myResultSet != null) {
	while (myResultSet.next()) {
		String m_name = myResultSet.getString("m_name");
		String m_addr = myResultSet.getString("m_addr");
		String m_pwd = myResultSet.getString("m_pwd");
		
		%>
		<h1>회원정보 수정</h1>
		<form method="post" action="update_verify.jsp">
		<div class="container">
		
			<input type="hidden" value="<%=session_id%>" name="m_id">
			
			<label for="mname"><b>이름</b></label>
		    <input type="text" value="<%=m_name%>" name="m_name" required>
		    
		    <label for="addr"><b>주소</b></label>
		    <input type="text" value="<%=m_addr%>" name="m_addr" required>
		    
		    <label for="psw"><b>비밀번호</b></label>
		    <input type="password" value="<%=m_pwd%>" name="m_pwd" required>

		<%
}
	}
stmt.close(); myConn.close();
%>
    <button type="submit">수정</button>
  </div>
</form></body></html>
