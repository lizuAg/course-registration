<%@ page contentType="text/html; charset=UTF-8" %>
<link rel="stylesheet" type="text/css" href="timetable.css">
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<html><head><title>수강신청 조회</title></head>
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

try{
	year = new String(request.getParameter("year"));
	semester = new String(request.getParameter("semester"));
}catch(NullPointerException e){
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
}

%>

		<h1><%= year %>년도 <%= semester %>학기 수강내역</h1>

<table width="75%" align="center" border>
	<br>
		<tr>
			<th>과목번호</th><th>분반</th><th>과목명</th><th>전공</th><th>학점</th><th>강의실</th><th>시간</th><th>교수명</th>
		</tr>
<%
Connection myConn = null; Statement stmt = null;
ResultSet myResultSet = null; String mySQL = "";
int nTotalCourse = 0; int nTotalUnit = 0;
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
		System.out.println(mySQL);
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
	<td align="center"><%= c_major %></td>
	<td align="center"><%= c_unit %></td>
	<td align="center"><%= c_site %></td>
	<td align="center"><%= t_time %></td>
	<td align="center"><%= m_name %></td>
<%
	}
}

int i_year = Integer.parseInt(year);
int i_semester = Integer.parseInt(semester);

CallableStatement cstmt = myConn.prepareCall("{call SelectTimeTable(?,?,?,?,?)}");
cstmt.setString(1, session_id);
cstmt.setInt(2, i_year);
cstmt.setInt(3, i_semester);
cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

try {
	cstmt.execute();
	nTotalUnit = cstmt.getInt(4);
	nTotalCourse = cstmt.getInt(5);
} catch(SQLException ex) {
	System.err.println("SQLException: " + ex.getMessage());
}
stmt.close(); myConn.close();
%>
</table>

<br>
<div id = "CountInfo" align="center" style="font-weight: bold;">수강신청한 강의 수 :  <%=nTotalCourse%>개   &nbsp;&nbsp;&nbsp;  누적 학점 :  <%=nTotalUnit%>학점</div>
</body>
<br>

<div align="center">
	<form action="select.jsp" id=search>
	<br>
	  <input type="text" id="year" name="year">
	    <label for="year">연도</label>
	
		<select name="semester">
		    <option value="1">1</option>
		    <option value="2">2</option>
		  </select>
	    <label for="semester">학기</label>
	  <input type="submit" value="조회">
	  <br>
	</form>
</div>
</body>
</html>