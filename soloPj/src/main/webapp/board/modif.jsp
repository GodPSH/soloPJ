<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%
Memb mlogin = (Memb) session.getAttribute("loginUser");
request.setCharacterEncoding("UTF-8");

String searchType = request.getParameter("searchType");
String searchValue = request.getParameter("searchValue");

String fidx = request.getParameter("fidx");

Connection conn = null;
PreparedStatement psmt = null;
ResultSet rs = null;

String fsubject_ = "";
String fwriter_ = "";
String fcontent_ = "";
String fwriteday_ = "";
int fhit_=0;
int fidx_ = 0;

try {
	conn = DBManager.getConnection();

	String sql = " select * from fboard where fidx= " + fidx;
	psmt = conn.prepareStatement(sql);
	rs = psmt.executeQuery();

	if (rs.next()) {
		fsubject_ = rs.getString("fsubject");
		fwriter_ = rs.getString("fwriter");
		fcontent_ = rs.getString("fcontent");
		fwriteday_=rs.getString("fwriteday");
		fidx_ = rs.getInt("fidx");
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
			<input type="hidden" name="fidx" value="<%=fidx_%>">
				<table border="1" class="table table-bordered">
					<thead>
						<tr>
							<th class="tabth">글번호</th>
							<th class="tabth2"><%=fidx_%></th>
							<th class="tabth">작성자</th>
							<th class="tabth2"><%=fwriter_%></th>
							<th class="tabth">등록일</th>
							<th class="tabth2"><%=fwriteday_%></th>
							<th class="tabth">조회수</th>
							<th class="tabth2"><%=fhit_%></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th class="tabth">제목</th>
							<td colspan="7" class="tabth2"><input type="text" size="50" name="fsubject" value="<%=fsubject_%>"></td>
						</tr>
						<tr class="textarea">
							<td colspan="8" rowspan="3" class="trtd"><textarea name="fcontent" rows="3"><%=fcontent_%></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" value="저장">
				<button type="button"
					onclick="location.href='view.jsp?fidx=<%=fidx%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">취소</button>
			</form>
		</article>
	</section>
	<%@ include file="/footer.jsp"%>
</body>
</html>