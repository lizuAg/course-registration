<%@ page contentType="text/html; charset=UTF-8" %>
<link rel="stylesheet" type="text/css" href="top.css">
<%
String session_id = (String)session.getAttribute("user");
String log;
if (session_id==null) {log="<a href=login.jsp>로그인</a>";
	%>
	<table width="75%" align="center" bgcolor="#FFFF99" border id="top">
	<tr>
	<td align="center"><b><%=log%></b></td>
	<td align="center"><b><a href="update.jsp">사용자 정보 수정</b></td>
	<td align="center"><b><a href="insert.jsp">수강신청 입력</b></td>
	<td align="center"><b><a href="delete.jsp">수강신청 삭제</b></td>
	<td align="center"><b><a href="select.jsp">수강신청 조회</b></td>
	</tr>
	</table>
	<%
}
else if ((session_id.startsWith("s"))) { log="<a href=login.jsp>로그아웃</a>";
	%>
	<table width="75%" align="center" bgcolor="#FFFF99" border id="top">
	<tr>
	<td align="center"><b><%=log%></b></td>
	<td align="center"><b><a href="update.jsp">사용자 정보 수정</b></td>
	<td align="center"><b><a href="insert.jsp">수강신청 입력</b></td>
	<td align="center"><b><a href="delete.jsp">수강신청 삭제</b></td>
	<td align="center"><b><a href="select.jsp">수강신청 조회</b></td>
	</tr>
	</table>
	<%
}
else if((session_id.startsWith("p"))) { log="<a href=logout.jsp>로그아웃</a>";
	%>
	<table width="75%" align="center" bgcolor="#FFFF99" border  id="top">
<tr>
<td align="center"><b><%=log%></b></td>
<td align="center"><b><a href="update.jsp">사용자 정보 수정</b></td>
<td align="center"><b><a href="new_insert.jsp">강의 입력</b></td>
</tr>
</table>
<%
}
%>