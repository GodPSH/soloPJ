<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href="<%=request.getContextPath()%>/css/login.css" rel="stylesheet">
</head>
<body>

<section >
	<form class="login-input" action="loginOk.jsp" method="post">
		<img src="head.png" width="150" height="120">
		<h1 >로그인 해주세요!</h1>
		
		<div class="login-id">
		<input type="text" name="membid" placeholder="아이디를 입력하세요">	
		</div>
		
		<div class="login-pw">
		<input type="password" name="membpw" placeholder="비밀번호를 입력하세요">
		</div>
		
		<div class="login-btn-wrap">
			<input class="login-btn" type="submit" value="로그인">
		</div>
		<a href="<%=request.getContextPath()%>/main.jsp">홈</a>
	</form>
</section>

</body>
</html>