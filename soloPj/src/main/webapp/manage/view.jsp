<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%@ page import="java.util.*"%>
<%
Memb mlogin = (Memb) session.getAttribute("loginUser");
request.setCharacterEncoding("UTF-8");

String searchType = request.getParameter("searchType");
String searchValue = request.getParameter("searchValue");

String mbidx = request.getParameter("mbidx");

Connection conn = null;
PreparedStatement psmt = null;
ResultSet rs = null;



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

	String sql = " select * from memb where mbidx =" + mbidx;
	psmt = conn.prepareStatement(sql);
	rs = psmt.executeQuery();

	if (rs.next()) {
		
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
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%@ include file="/header.jsp"%>
	<%@ include file="/side.jsp"%>
	<section>

		<table class="table">
			<thead class="table-dark">
				<tr>
					
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
					<td><%=membpw_%></td>
					<td><%=membaddr_%></td>
					<td><%=membage_%></td>
					<td><%=membname_%></td>
					<td><%=membph_%><%=membph2_%><%=membph3_%></td>

				</tr>

			</tbody>
		</table>
		<button
				 onclick="location.href='manage.jsp?searchType=<%=searchType%>&searchValue=<%=searchValue%>'">목록</button>
				 <button
				class="btn" onclick="location.href='modif.jsp?mbidx=<%=mbidx_%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">수정</button>
			<button class="btn" onclick="deleteFn()">삭제</button>
			<form name="frm" action="deleteOk.jsp" method="post">
				<input class="btn" type="hidden" name="mbidx" value="<%=mbidx_%>">
			</form>
	</section>
		<%@ include file="/footer.jsp"%>
</body>
</html>