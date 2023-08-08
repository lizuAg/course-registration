<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<link rel="stylesheet" type="text/css" href="timetable.css">
<html><head><title>수강신청 입력</title></head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id==null) response.sendRedirect("login.jsp"); 
else if (session_id.startsWith("p")) {
%>
      <script>
         alert("학생 전용 페이지입니다.");
         location.href = "main.jsp";
      </script>
<%} 
String year = null; String semester=null;
LocalDate today = LocalDate.now();
int currentYear = today.getYear();
int currentMonth = today.getMonthValue();    

if (currentMonth >= 11) currentYear+=1;
year = String.valueOf(currentYear);
if (currentMonth >= 5 && currentMonth <= 10) {
    semester = "1";
} else {
    semester = "2";
}
%>
<h1>수강신청 입력</h1>

<table width="75%" align="center" border>
<br>
<tr>
	<th>과목번호</th><th>분반</th><th>과목명</th><th>교수명</th><th>전공</th><th>학점</th><th>강의실</th><th>시간</th><th>여석</th><th>수강신청</th>
</tr>
<%
Connection myConn = null; Statement stmt = null;
ResultSet myResultSet = null; String mySQL = "";
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user="c##jueun"; String passwd="jueun2023"; // 비밀번호
String dbdriver = "oracle.jdbc.driver.OracleDriver";

try {
Class.forName(dbdriver);
myConn = DriverManager.getConnection (dburl, user, passwd);
stmt = myConn.createStatement();
} catch(SQLException ex) {
System.err.println("SQLException: " + ex.getMessage());
}

mySQL = "select c.c_id, c.c_id_no, c.c_name, c.c_major, c.c_unit, c.c_site, t.t_time, t.t_max, m.m_name, "
+ "(SELECT COUNT(c.c_id) FROM enroll e WHERE e.c_id = c.c_id AND e.c_id_no = c.c_id_no  and e.e_year="+year+" and e.e_semester="+semester+") AS enroll_count"
+ " from course c"
+" join member m on c.m_id = m.m_id "
		+" join teach t on t.c_id=c.c_id and t.c_id_no=c.c_id_no and t.t_year="+year+" and t.t_semester="+semester
+" where c.c_id not in (select c_id from enroll e where m_id='" + session_id + "' and e.e_year="+year+" and e.e_semester="+semester+")"
+" order by c_id";



myResultSet = stmt.executeQuery(mySQL);

if (myResultSet != null) {
	while (myResultSet.next()) {
		String c_id = myResultSet.getString("c_id");
		int c_id_no = myResultSet.getInt("c_id_no");
		String c_name = myResultSet.getString("c_name");
		String c_major = myResultSet.getString("c_major");
		int c_unit = myResultSet.getInt("c_unit");
		String c_site = myResultSet.getString("c_site");
		int t_time = myResultSet.getInt("t_time");
		int t_max = myResultSet.getInt("t_max");
		int enroll_count = myResultSet.getInt("enroll_count");
		String m_name = myResultSet.getString("m_name");
%>
<tr>
	<td align="center"><%= c_id %></td>
	<td align="center"><%= c_id_no %></td> 
	<td align="center"><%= c_name %></td>
	<td align="center"><%= m_name %></td>
	<td align="center"><%= c_major %></td>
	<td align="center"><%= c_unit %></td>
	<td align="center"><%= c_site %></td>
	<td align="center"><%= t_time %></td>
	<td align="center"><%= enroll_count+"/"+t_max %></td>
	<td align="center"><a href="insert_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= c_id_no %>">신청</a></td>
</tr>
<%
}
}
stmt.close(); myConn.close();
%>
</table></body></html>