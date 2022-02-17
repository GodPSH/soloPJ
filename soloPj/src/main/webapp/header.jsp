<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="soloPjWeb.*" %>
<%

	Memb login = (Memb)session.getAttribute("loginUser");
	
	
%>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<script>
	function goMember(){
		var login = '<%=login%>';
		console.log(login);
		console.log(typeof login);
		//location.href ='member/list.jsp';
		
		if(login=='null'){
			alert("로그인 후 접근 가능합니다.");
		}else{
			location.href='main.jsp';
		}
	}
</script>
 <header>
      <div><img  class="headimg" src="<%=request.getContextPath()%>/img/head.png" ></div>
     	
	  <div class="headhi">
	  	<%
			if(login != null){
		%>
	  		<h2><%=login.getMembname()%>EzenFc 오신걸 환영합니다.</h2>
	  	<% 		
			}else{
		%>
			<h2>EzenFc 오신걸 환영합니다.</h2>
		<%
		}
     	
		%>
	  </div>
	  <%
	  	if(login != null){
	  %>
      <ul>
        <li><a href="<%=request.getContextPath()%>/board/fboard.jsp" class="nav-link px-2 link-dark">전체 글</a></li>
        <li><a href="<%=request.getContextPath()%>/notice/notice.jsp" class="nav-link px-2 link-dark">공지사항</a></li>
        <li><a href="<%=request.getContextPath()%>/teamboard/teamboard.jsp" class="nav-link px-2 link-dark">팀 소개</a></li>
        <li><a href="<%=request.getContextPath()%>/hiboard/hiboard.jsp" class="nav-link px-2 link-dark">하이라이트 / 해외축구</a></li>
      </ul>
      <%}else{ %>
      <ul>
        <li><a href="<%=request.getContextPath()%>/board/fboard.jsp" class="nav-link px-2 link-dark">전체 글</a></li>
        <li><a href="javascript:goMember();" class="nav-link px-2 link-dark">공지사항</a></li>
        <li><a href="javascript:goMember();" class="nav-link px-2 link-dark">팀 소개</a></li>
        <li><a href="javascript:goMember();" class="nav-link px-2 link-dark">하이라이트 / 해외축구</a></li>
      </ul>
      <%} %>
		<%if(login==null){ %>
      <div class="headbtn">    
        <button type="button" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/login/sign.jsp'">회원가입</button>
        <button type="button"  class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/login/login.jsp'">로그인</button>
        <button type="button" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/main.jsp'">홈</button>    
      </div>
      <%}else{ %>
      <div class="headbtn">    
       
        <button type="button"  class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/login/logout.jsp'">로그아웃</button>
        <button type="button" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/main.jsp'">홈</button>    
      </div>
      <%} %>
    </header>