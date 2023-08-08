<%@ page contentType="text/html; charset=UTF-8" %>
<link rel="stylesheet" type="text/css" href="timetable.css">
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<html><head><title>수강신청 삭제</title></head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id==null) response.sendRedirect("login.jsp"); 
if (session_id.startsWith("p")) {
%>
      <script>
         alert("학생 전용 페이지입니다.");
         location.href = "main.jsp";
      </script>
<%}

LocalDate today = LocalDate.now();
int currentYear = today.getYear();
int currentMonth = today.getMonthValue();    
String year = null; String semester=null;

if (currentMonth >= 11) currentYear+=1;
year = String.valueOf(currentYear);
if (currentMonth >= 5 && currentMonth <= 10) {
    semester = "1";
} else {
    semester = "2";
}

%>

		<h1>수강신청 삭제</h1>

<table width="75%" align="center" border>
	<br>
		<tr>
			<th>과목번호</th><th>분반</th><th>과목명</th><th>교수명</th><th>전공</th><th>학점</th><th>강의실</th><th>시간</th><th>수강취소</th>
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
	stmt=myConn.createStatement();
} catch(SQLException ex) {
	System.err.println("SQLException: " + ex.getMessage());
}

mySQL = "SELECT c.c_id, c.c_id_no, c_name, c_major, c_unit, c_site, t_time, m.m_name FROM Enroll e"
+ " left join course c on c.c_id=e.c_id and c.c_id_no=e.c_id_no "
+" join teach t on t.c_id=c.c_id and t.c_id_no=c.c_id_no and t.t_year="+year+" and t.t_semester="+semester
+" join member m on c.m_id = m.m_id "
+ " where e.m_id='" + session_id + "' and e.e_year="+year+" and e.e_semester="+semester;
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
	<td align="center"><a href="delete_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= c_id_no %>">삭제</a></td>
<%
}
}
stmt.close(); myConn.close();
%>
</table>
</body></html>
