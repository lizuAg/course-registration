<%@ page contentType="text/html; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.sql.*" %>
<html>
<head><title> 수강신청 사용자 정보 수정 </title></head>
<body>
<% 
String s_id = request.getParameter("m_id");
String s_addr = new String(request.getParameter("m_addr"));
String s_pwd = new String(request.getParameter("m_pwd"));
String s_name = new String(request.getParameter("m_name"));

Connection myConn = null; Statement stmt = null; String mySQL = null;
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

try { 
	mySQL ="update Member set m_name='"+s_name+"', m_pwd='"+s_pwd+"', m_addr='"+s_addr+"' where m_id='"+s_id+"'"; 
	stmt.execute(mySQL);
%>
<script>
	alert("회원 정보가 수정 되었습니다. "); 
	location.href="update.jsp";
</script>
<% 
} catch(SQLException ex) {
	System.out.println(ex.getErrorCode()+"");
	String sMessage;
	if (ex.getErrorCode() == 20002) sMessage="암호는4자리 이상이어야 합니다";
	else if (ex.getErrorCode() == 20003) sMessage="암호에 공란은 입력되지 않습니다.";
	else if (ex.getErrorCode() == 20004) sMessage="이름은 2자리 이상이어야 합니다.";
	else sMessage="잠시 후 다시 시도하십시오";
%>
<script>
	alert("<%=sMessage%>"); 
	location.href="update.jsp";
</script>
<%
}
finally{
	if(stmt!=null)try{stmt.close(); myConn.close();}
catch(SQLException ex) { }
}
%> 
</body></html>