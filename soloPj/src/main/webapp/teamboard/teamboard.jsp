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
String master = "";
String tidx = request.getParameter("tidx");

String tsubject_ = "";
String twriter_ = "";
String tcontent_ = "";
String twriteday_ = "";
int thit_ = 0;
int tidx_ = 0;
int mbidx_ = 0;
Connection conn = null;
PreparedStatement psmt = null;
ResultSet rs = null;

try {
	conn = DBManager.getConnection();
	String sql = "select * from teamboard";
	psmt = conn.prepareStatement(sql);
	rs = psmt.executeQuery();
	if (rs.next()) {
		tsubject_ = rs.getString("tsubject");
		twriter_ = rs.getString("twriter");
		twriteday_ = rs.getString("twriteday");
		tcontent_ = rs.getString("tcontent");
		tidx_ = rs.getInt("tidx");
		thit_ = rs.getInt("thit");
		mbidx_ = rs.getInt("mbidx");
	}

} catch (Exception e) {
	e.printStackTrace();
} finally {
	if (conn != null) {
		conn.close();
	}
	if (psmt != null) {
		psmt.close();
	}
	if (rs != null) {
		rs.close();
	}
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
<script>
	
</script>
<body>
	<%@ include file="/header.jsp"%>
	<%@ include file="/side.jsp"%>
	<section>
		<article>

			<table border="1" class="table table-bordered">
				<thead>
					<tr>
						<th class="tabth">글번호</th>
						<th class="tabth2"><%=tidx_%></th>
						<th class="tabth">작성자</th>
						<th class="tabth2"><%=twriter_%></th>
						<th class="tabth">등록일</th>
						<th class="tabth2"><%=twriteday_%></th>
						<th class="tabth">조회수</th>
						<th class="tabth2"><%=thit_%></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th class="tabth">제목</th>
						<td colspan="7" class="tabth2"><%=tsubject_%></td>
					</tr>
					<tr class="textarea">
						<td colspan="8" rowspan="3" class="trtd"><ima
								src="$<%=request.getContextPath()%>/wtpwebapps/soloPj/upload/1.png"><%=tcontent_%></td>
					</tr>
				</tbody>
			</table>


			<button onclick="location.href='insert.jsp'">등록</button>
			<button
				onclick="location.href='modif.jsp?tidx=<%=tidx_%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">수정</button>
			<br>
			<div>
				<span id="more" style="CURSOR: hand;"
					onclick="if(story.style.display=='none') {story.style.display='';more.innerText='구성원 닫기'} else {story.style.display='none';more.innerText='구성원 보기'}">구성원
					보기</span>
				<div id="story" style="display: none">
					<table border="1" class="table table-bordered">
						<thead class="moreth">
							<tr>
								<th class="tth">닉네임</th>
								<th class="tth">이름</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th class="tth">test1</th>
								<th class="tth">테스터</th>
							</tr>
						</tbody>
					</table>
				</div>

			</div>

		</article>
	</section>
	<%@ include file="/footer.jsp"%>
	<script src="../bootstrap/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</html>
