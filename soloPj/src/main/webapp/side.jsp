<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%@ page import="java.util.*"%>
<%
	Memb malogin = (Memb) session.getAttribute("loginUser");
		
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="<%=request.getContextPath()%>/css/sidebars.css" rel="stylesheet">
</head>
<aside>
<div id="sidebar-left1">
	<ul class="side">
		<li><a href="<%=request.getContextPath()%>/main.jsp">홈</a></li>
		<li><a href="<%=request.getContextPath()%>/board/fboard.jsp">전체글</a></li>
		<% if(malogin !=null){%>
		<li><a href="<%=request.getContextPath()%>/notice/notice.jsp">공지사항</a></li>
		<li><a href="<%=request.getContextPath()%>/teamboard/teamboard.jsp">팀소개</a></li>
		<li><a href="<%=request.getContextPath()%>/hiboard/hiboard.jsp">하이라이트/해외축구</a></li>
		<%} %>
			<%
			if(malogin != null && malogin.getMbidx() == 1){
			%>	
		<li><a href="#">관리자</a></li>
		<li><a href="<%=request.getContextPath()%>/manage/manage.jsp">회원관리</a></li>
		<%} %>
	</ul>
</div>
<div id="sidebar-left2">
	<ul class="side">
		<li>가입문의</li>
		<li>TEL:010-0000-0000</li>
	</ul>
</div>
</aside>
</html>
