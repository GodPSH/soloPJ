<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%@ page import="java.util.*"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%
int visitSwitch = 0;
String cookiesql = ""; // 쿠키관련 쿼리문

String cookieName = "";



Memb mlogin = (Memb) session.getAttribute("loginUser");
request.setCharacterEncoding("UTF-8");

String searchType = request.getParameter("searchType");
String searchValue = request.getParameter("searchValue");

String hidx = request.getParameter("hidx");

Connection conn = null;
PreparedStatement psmt = null;
ResultSet rs = null;

String hsubject_ = "";
String hwriter_ = "";
String hcontent_ = "";
String hwriteday_ = "";
String filename_ ="";
int hhit_ = 0;
int hidx_ = 0;
int mbidx_ = 0;



if (mlogin != null) { // 조건문 안걸면 오류뜸
	cookieName = hidx + "-" + mlogin.getMbidx(); // 게시판번호(lidx) - 게시글번호 - 회원번호(midx)로 쿠키이름만 생성
}

try {
	conn = DBManager.getConnection();

	Cookie[] cookies = request.getCookies();
	if (mlogin != null) {
		if (cookies != null) {
	for (Cookie cook : cookies) {
		if (cook.getName().equals(cookieName) && cook.getValue().equals("viewed")) {
			visitSwitch = 1;
			break;
		}
	}
		}

		if (visitSwitch == 0) { // 조회한 이력이 없을 경우
	cookiesql = " update hiboard SET hhit = hhit + 1 WHERE hidx = " + hidx; // 조회수 1 올려줌
	psmt = conn.prepareStatement(cookiesql);
	int result = psmt.executeUpdate();
	if (result == 1) {
		Cookie cookie = new Cookie(cookieName, "viewed"); // 쿠키 이름과 그에대한 값("viewed")을 생성
		cookie.setMaxAge(60 * 60 * 24); // 24시간으로 설정
		response.addCookie(cookie); // 생성한걸 쿠키객체에 집어 넣음
	}
		}

	}

	String sql = "select * from hiboard where hidx = "+hidx ;
	psmt = conn.prepareStatement(sql);
	rs = psmt.executeQuery();
	if (rs.next()) {
		hsubject_ = rs.getString("hsubject");
		hwriter_ = rs.getString("hwriter");
		hwriteday_ = rs.getString("hwriteday");
		hcontent_ = rs.getString("hcontent");
		hidx_ = rs.getInt("hidx");
		hhit_ = rs.getInt("hhit");
		mbidx_ = rs.getInt("mbidx");
		filename_ =rs.getString("filename");
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
		<h2>팀소개글</h2>
		<article>

			<table border="1" class="table table-bordered" enctype="multipart/form-data">
				<thead>
					<tr>
						<th class="tabth">글번호</th>
						<th class="tabth2"><%=hidx_%></th>
						<th class="tabth">작성자</th>
						<th class="tabth2"><%=hwriter_%></th>
						<th class="tabth">등록일</th>
						<th class="tabth2"><%=hwriteday_%></th>
						<th class="tabth">조회수</th>
						<th class="tabth2"><%=hhit_%></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th class="tabth">제목</th>
						<td colspan="7" class="tabth2"><%=hsubject_%></td>
					</tr>
					<tr class="textarea">
						<td colspan="8" rowspan="3" class="trtd">
						<video controls="controls" src="<%=request.getContextPath()%>/media/<%=filename_%>"></video>
						<%=hcontent_%>
						</td>
					</tr>
				</tbody>
			</table>
			<button
				class="teambtn" onclick="location.href='hiboard.jsp?searchType=<%=searchType%>&searchValue=<%=searchValue%>'">목록</button>
			<%
			if(mlogin != null && mlogin.getMbidx()==mbidx_){
			%>	
			<button
				class="teambtn" onclick="location.href='modif.jsp?hidx=<%=hidx_%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">수정</button>
			<button class="teambtn" onclick="deleteFn()">삭제</button>
			<%}else if(mlogin.getMbidx()==1){ %>
			<button
				class="teambtn" onclick="location.href='modif.jsp?hidx=<%=hidx_%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">수정</button>
			<button class="teambtn" onclick="deleteFn()">삭제</button>
			<%} %>
			<form name="frm" action="deleteOk.jsp" method="post">
				<input class="btn" type="hidden" name="hidx" value="<%=hidx_%>">
			</form>
		</article>
	</section>
	<%@ include file="/footer.jsp"%>
	<script src="../bootstrap/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
<script>
		function deleteFn() {
			if (confirm("정말 삭제하시겠습니까?") == true) {
				alert("삭제되었습니다.");
				document.frm.submit();
			} else {
				alert("취소되었습니다");
				return false;
			}

		}
</script>
</body>
</html>
