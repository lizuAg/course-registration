<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<html><head><title> 강의 입력 </title></head>
<body>
<%
String s_id = (String)session.getAttribute("user");
String c_id = request.getParameter("c_id");
int c_id_no = Integer.parseInt(request.getParameter("c_id_no"));
String c_name = request.getParameter("c_name");
int c_unit = Integer.parseInt(request.getParameter("c_unit"));
String c_major = request.getParameter("c_major");
int t_time = Integer.parseInt(request.getParameter("t_time"));
String c_site = request.getParameter("c_site");
int t_max = Integer.parseInt(request.getParameter("t_max"));
%>

<div><%=s_id %></div>

<%
Connection myConn = null; String result = null;
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user="c##jueun"; //아이디
String passwd="jueun2023"; // 비밀번호
String dbdriver = "oracle.jdbc.driver.OracleDriver";
try {
Class.forName(dbdriver);
myConn = DriverManager.getConnection (dburl, user, passwd);
} catch(SQLException ex) {
System.err.println("SQLException: " + ex.getMessage());
}

CallableStatement cstmt = myConn.prepareCall("{call InsertCourse(?,?,?,?,?,?,?,?,?,?)}");
cstmt.setString(1, s_id);
cstmt.setString(2, c_id);
cstmt.setInt(3, c_id_no);
cstmt.setString(4, c_name);
cstmt.setInt(5, c_unit);
cstmt.setString(6,c_major);
cstmt.setInt(7,t_time);
cstmt.setString(8, c_site);
cstmt.setInt(9,t_max);
cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
try { 
cstmt.execute();
result = cstmt.getString(10);
%>
<script>
alert("<%= result%>"); 
location.href="new_insert.jsp";
</script>
<%
} catch(SQLException ex) {
System.err.println("SQLException: " + ex.getMessage());
} 
finally {
if (cstmt != null) 
try { myConn.commit(); cstmt.close(); myConn.close(); }
catch(SQLException ex) { }
}
%>
</form></body></html>