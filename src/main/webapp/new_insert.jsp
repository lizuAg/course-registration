<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<link rel="stylesheet" type="text/css" href="timetable.css">
<html><head><title>수강신청 입력</title></head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id==null) response.sendRedirect("login.jsp"); 
else if (session_id.startsWith("s")) {
%>
      <script>
         alert("교수 전용 페이지입니다.");
         location.href = "main.jsp";
      </script>
<%} %>

<table width="75%" align="center" border>
<br>
<tr><th>과목번호</th><th>분반</th><th>과목명</th><th>학점</th><th>전공</th><th>시간</th><th>장소</th><th>교수</th><th>최대수강인원</th></tr>
<%

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
<h1><%= year %>년도 <%= semester %>학기 개설 강의 목록</h1>
<%

Connection myConn = null; Statement stmt = null;
ResultSet myResultSet = null; String mySQL = "";
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user="c##jueun"; String passwd="jueun2023";
String dbdriver = "oracle.jdbc.driver.OracleDriver"; 
try {
Class.forName(dbdriver);
myConn = DriverManager.getConnection(dburl, user, passwd);
stmt = myConn.createStatement();
} catch(SQLException ex) {
System.err.println("SQLException: " + ex.getMessage());
}
mySQL = "SELECT c.c_id, c.c_id_no, c.c_name, c.c_unit, c.c_major, c.c_site, m.m_name, t.t_time, t.t_max from course c"
+ " join teach t on c.c_id = t.c_id and c.c_id_no = t.c_id_no and t_year="+year+" and t_semester="+semester
+" join member m on c.m_id = m.m_id "
		+ " where t.t_year="+year+" and t.t_semester="+semester
+" order by c.c_id";

System.out.println(mySQL);

myResultSet = stmt.executeQuery(mySQL);
if (myResultSet != null) {
	while (myResultSet.next()) {
		String c_id = myResultSet.getString("c_id");
		int c_id_no = myResultSet.getInt("c_id_no");
		String c_name = myResultSet.getString("c_name");
		int c_unit = myResultSet.getInt("c_unit");
		String c_major = myResultSet.getString("c_major");
		int t_time = myResultSet.getInt("t_time");
		String c_site = myResultSet.getString("c_site");
		String m_name = myResultSet.getString("m_name");
		int t_max = myResultSet.getInt("t_max");
%>

<tr>
<td align="center"><%= c_id %></td> <td align="center"><%= c_id_no %></td> 
<td align="center"><%= c_name %></td><td align="center"><%= c_unit %></td>
<td align="center"><%= c_major %></td> <td align="center"><%= t_time %></td> 
<td align="center"><%= c_site %></td><td align="center"><%= m_name %></td>
<td align="center"><%= t_max %></td>
</tr>


<%
	} }
	stmt.close(); myConn.close();
%>

</table>

<br><br>

<h3 align="center">새로 개설할 강의 정보를 입력해주세요.</h3>


<FORM method="post" action="new_insert_verify.jsp" >
<div align="center">
<table width="75%"  border id="insert"> 
<tr>
<td><div align="center">과목번호</div></td>
<td><input type="text" name="c_id" required></td>
<td><div align="center">분반</div></td>
<td><input type="text" name="c_id_no" required></td>
<td><div align="center">과목명</div></td>
<td><input type="text" name="c_name" required></td>
<td><div align="center">학점</div></td>
<td><input type="text" name="c_unit" required></td>
</tr>
<tr>
<td><div align="center">전공</div></td>
<td><div align="center"><input type="text" name="c_major" required></div></td>
<td><div align="center">시간</div></td>
<td><div align="center"><input type="text" name="t_time" required></div></td>
<td><div align="center">장소</div></td>
<td><div align="center"><input type="text" name="c_site" required></div></td>
<td><div align="center">최대 수강 인원</div></td>
<td><div align="center"><input type="text" name="t_max" required></div></td>
</tr>

</table>
<br>
<INPUT TYPE="SUBMIT" NAME="Submit" VALUE="입력">
</div>

</FORM>


</body></html>