<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
String userID = request.getParameter("userID");
String userPassword = request.getParameter("userPassword");

Connection myConn = null; 
Statement stmt = null; 
String mySQL = null;
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user="c##jueun"; //아이디
String passwd="jueun2023"; // 비밀번호
String dbdriver = "oracle.jdbc.driver.OracleDriver";
Class.forName(dbdriver);
myConn=DriverManager.getConnection(dburl, user, passwd);

stmt = myConn.createStatement();
mySQL = "select m_id from member where m_id='" + userID + "' and m_pwd='" + userPassword + "'";

ResultSet myResultSet = stmt.executeQuery(mySQL);

if(myResultSet.next()){
	session.setAttribute("user",userID);
	response.sendRedirect("main.jsp");
}else {
	%>
	<script>
	alert("사용자 아이디 혹은 암호가 틀렸습니다");
	location.href="login.jsp";
	</script>
	<%
}
stmt.close();
myConn.close();
%>
