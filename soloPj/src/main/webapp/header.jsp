<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<header>
<div>
	<div><img class="headimg" src="./img/head.png" height=150px width="150px"></div>
	<ul class="menulist">
		<li><a class="active" href="main.jsp">Home</a></li>
		<li><a >전체 글</a></li>
		<li><a>공지사항</a></li>
		<li><a>팀 소개</a></li>
		<li><a>하이라이트/해외축구</a></li>
	</ul>
	<div class="login">

			<a href="<%=request.getContextPath()%>/main.jsp">홈</a>
			|
			<a href="<%=request.getContextPath()%>/login/login.jsp">로그인</a>
			|
			<a href="<%=request.getContextPath()%>/login/login.jsp">회원가입</a>
	</div>
	
</div>
</header>