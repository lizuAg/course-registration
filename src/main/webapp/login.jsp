<%@ page contentType="text/html; charset=UTF-8" %>
<link rel="stylesheet" type="text/css" href="login.css">
<HTML>
<head><title>수강신청 시스템 로그인</title></head>
<BODY>
	<%@ include file="top.jsp" %>
	<br>
			<h1>로그인</h1>
	<FORM method="post" action="login_verify.jsp" >
  <div class="container">
    <label for="uname"><b>ID</b></label>
    <input type="text" placeholder="Enter ID" name="userID" required>

    <label for="psw"><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="userPassword" required>
        
    <button type="submit">Login</button>
  </div>
</form>
	
</BODY>
</HTML>	