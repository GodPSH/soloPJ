<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%
Memb mlogin = (Memb) session.getAttribute("loginUser");
request.setCharacterEncoding("UTF-8");

String searchType = request.getParameter("searchType");
String searchValue = request.getParameter("searchValue");

String mbidx = request.getParameter("mbidx");

Connection conn = null;
PreparedStatement psmt = null;
ResultSet rs = null;
String membid_="";
String membpw_ = "";
String membaddr_ = "";
String membname_ = "";
int membage_ = 0;
int mbidx_ = 0;
String membph_="";
String membph2_="";
String membph3_="";

try {
	conn = DBManager.getConnection();

	String sql = " select * from memb where mbidx= " + mbidx;
	psmt = conn.prepareStatement(sql);
	rs = psmt.executeQuery();

	if (rs.next()) {
		membid_ = rs.getString("membid");
		membpw_ = rs.getString("membpw");
		membaddr_ = rs.getString("membaddr");
		membname_ = rs.getString("membname");
		membage_ = rs.getInt("membage");
		mbidx_ = rs.getInt("mbidx");
		membph_= rs.getString("membph");
		membph2_= rs.getString("membph2");
		membph3_= rs.getString("membph3");
	}

} catch (Exception e) {
	e.printStackTrace();
} finally {
	if (conn != null)
		conn.close();
	if (psmt != null)
		psmt.close();
	if (rs != null)
		rs.close();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link href="<%=request.getContextPath()%>/css/all2.css" rel="stylesheet">
</head>
<body>
	<%@ include file="/header.jsp"%>
	<%@ include file="/side.jsp"%>
	<section>
		<article>
			<form action="modifOk.jsp" method="post">
			<input type="hidden" name="mbidx" value="<%=mbidx_%>">
				<table class="table">
			<thead class="table-dark">
				<tr>
					<th>회원번호</th>
					<th>회원아이디</th>
					<th>회원비밀번호</th>
					<th>회원주소</th>
					<th>회원나이</th>
					<th>회원이름</th>
					<th>회원전화번호</th>
				</tr>
			</thead>
			<tbody>				
				<tr>					
					<td><%=mbidx_%></td>
					<td><%=membid_ %></td>
					<td><input type="text" size="10" name="membpw" value="<%=membpw_%>"></td>
					<td><input type="text" size="10" name="membaddr" value="<%=membaddr_%>"></td>
					<td><%=membage_%></td>
					<td><input type="text" size="10" name="membname" value="<%=membname_%>"></td>
					<td><input type="text" size="3" name="membph" value="<%=membph_%>">
					<input type="text" size="4" name="membph2" value="<%=membph2_%>">
					<input type="text" size="4" name="membph3" value="<%=membph3_%>">
					</td>

				</tr>

			</tbody>
		</table>
				<input type="submit" value="저장">
				<button type="button"
					onclick="location.href='view.jsp?mbidx=<%=mbidx%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">취소</button>
			</form>
		</article>
	</section>
	<%@ include file="/footer.jsp"%>
</body>
</html>