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

PreparedStatement psmtReply = null;
ResultSet rsReply = null;

String fsubject_ = "";
String fwriter_ = "";
String fcontent_ = "";
String fwriteday_ = "";
int fhit_ = 0;
int fidx_ = 0;
int mbidx_ = 0;

try {
	conn = DBManager.getConnection();
	String sql = " select * from fboard where fidx =" + fidx;
	psmt = conn.prepareStatement(sql);
	rs = psmt.executeQuery();

	if (rs.next()) {
		fsubject_ = rs.getString("fsubject");
		fwriter_ = rs.getString("fwriter");
		fwriteday_ = rs.getString("fwriteday");
		fcontent_ = rs.getString("fcontent");
		fidx_ = rs.getInt("fidx");
		fhit_ = rs.getInt("fhit");
		mbidx_ = rs.getInt("mbidx");
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

			<table border="1" class="table table-bordered">
				<thead>
					<tr>
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
						<td colspan="5" class="tabth2"><%=fsubject_%></td>
					</tr>
					<tr class="textarea">
						<td colspan="6" rowspan="3" class="trtd"><%=fcontent_%></td>
					</tr>
				</tbody>
			</table>
			<button onclick="location.href='fboard.jsp?searchType=<%=searchType%>&searchValue=<%=searchValue%>'">목록</button>
			<% if(mlogin!=null &&mlogin.getMbidx()==mbidx_){ %>
			<button onclick="location.href='modif.jsp?fidx=<%=fidx_%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">수정</button>
			<button onclick="deleteFn()">삭제</button>
			
			<%
			}
			%>


		</article>
	</section>
	<%@ include file="/footer.jsp"%>


	<script src="../bootstrap/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</html>