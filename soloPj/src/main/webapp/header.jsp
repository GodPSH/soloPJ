<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
 <header>
      <div><img  class="headimg" src="img/head.png" ></div>
	  <div class="headhi">
	  	<h2>EzenFc 오신걸 환영합니다.</h2>
	  </div>
      <ul>
        
        <li><a href="#" class="nav-link px-2 link-dark">전체 글</a></li>
        <li><a href="#" class="nav-link px-2 link-dark">공지사항</a></li>
        <li><a href="#" class="nav-link px-2 link-dark">팀 소개</a></li>
        <li><a href="#" class="nav-link px-2 link-dark">하이라이트 / 해외축구</a></li>
      </ul>

      <div class="headbtn">
        
        <button type="button" class="btn btn-primary" href="/login/sign.jsp">회원가입</button>
        <button type="button"  class="btn btn-primary">로그인</button>
        <button type="button" class="btn btn-primary" href="main.jsp">홈</button>
      </div>
    </header>