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

String path = session.getServletContext().getRealPath("/");



Memb mlogin = (Memb) session.getAttribute("loginUser");
request.setCharacterEncoding("UTF-8");
String searchType = request.getParameter("searchType");
String searchValue = request.getParameter("searchValue");
String master = "";
String tidx = request.getParameter("tidx");

Connection conn = null;
PreparedStatement psmt = null;
ResultSet rs = null;

String tsubject_ = "";
String twriter_ = "";
String tcontent_ = "";
String twriteday_ = "";
String filename_ ="";
int thit_ = 0;
int tidx_ = 0;
int mbidx_ = 0;

ArrayList<Nreply> reList = new ArrayList<>();

if (mlogin != null) { // 조건문 안걸면 오류뜸
	cookieName = tidx + "-" + mlogin.getMbidx(); // 게시판번호(lidx) - 게시글번호 - 회원번호(midx)로 쿠키이름만 생성
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
	cookiesql = "UPDATE teamboard SET thit = thit + 1 WHERE tidx = " + tidx; // 조회수 1 올려줌
	psmt = conn.prepareStatement(cookiesql);
	int result = psmt.executeUpdate();
	if (result == 1) {
		Cookie cookie = new Cookie(cookieName, "viewed"); // 쿠키 이름과 그에대한 값("viewed")을 생성
		cookie.setMaxAge(60 * 60 * 24); // 24시간으로 설정
		response.addCookie(cookie); // 생성한걸 쿠키객체에 집어 넣음
	}
		}

	}

	String sql = "select * from teamboard" ;
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
						<td colspan="8" rowspan="3" class="trtd">
						<img class="teamimg" src="<%=request.getContextPath()%>/upload/<%=filename_%>"><%=tcontent_%>
						</td>
					</tr>
				</tbody>
			</table>

			<%
			if(mlogin != null && mlogin.getMbidx() == 1){
			%>	
			<button class="teambtn" onclick="location.href='insert.jsp'">등록</button>
			<button class="teambtn"
				onclick="location.href='modif.jsp?tidx=<%=tidx_%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">수정</button>
			<br>
			<%} %>
			<div>
				<button class="btn">
					<span id="more" style="CURSOR: hand;"
						onclick="if(story.style.display=='none') {story.style.display='';more.innerText='구성원 닫기'} else {story.style.display='none';more.innerText='구성원 보기'}">구성원
						보기</span>
				</button>
				<div id="story" style="display: none">
					<table border="1" class="table table-striped">
						<thead class="moreth">
							<tr class="moretr">
								<th class="tth" colspan="4"><img
									src="<%=request.getContextPath()%>/img/kkm.jpg"></th>

							</tr>
						</thead>
						<tbody>
							<tr>
								<th class="tth">닉네임</th>
								<td class="ttd">test1</td>
								<th class="tth">이름</th>
								<td class="ttd">테스터</td>
							</tr>
						</tbody>
					</table>
					<table border="1" class="table table-striped">
						<thead class="moreth">
							<tr class="moretr">
								<th class="tth" colspan="4"><img
									src="<%=request.getContextPath()%>/img/fb1.jpg"></th>

							</tr>
						</thead>
						<tbody>
							<tr>
								<th class="tth">닉네임</th>
								<td class="ttd">test1</td>
								<th class="tth">이름</th>
								<td class="ttd">테스터</td>
							</tr>
						</tbody>
					</table>
					<table border="1" class="table table-striped">
						<thead class="moreth">
							<tr class="moretr">
								<th class="tth" colspan="4"><img
									src="<%=request.getContextPath()%>/img/fb2.jpg"></th>

							</tr>
						</thead>
						<tbody>
							<tr>
								<th class="tth">닉네임</th>
								<td class="ttd">test1</td>
								<th class="tth">이름</th>
								<td class="ttd">테스터</td>
							</tr>
						</tbody>
					</table>
					<table border="1" class="table table-striped">
						<thead class="moreth">
							<tr class="moretr">
								<th class="tth" colspan="4"><img
									src="<%=request.getContextPath()%>/img/fb3.jpg"></th>

							</tr>
						</thead>
						<tbody>
							<tr>
								<th class="tth">닉네임</th>
								<td class="ttd">test1</td>
								<th class="tth">이름</th>
								<td class="ttd">테스터</td>
							</tr>
						</tbody>
					</table>
					<table border="1" class="table table-striped">
						<thead class="moreth">
							<tr class="moretr">
								<th class="tth" colspan="4"><img
									src="<%=request.getContextPath()%>/img/fb4.jpg"></th>

							</tr>
						</thead>
						<tbody>
							<tr>
								<th class="tth">닉네임</th>
								<td class="ttd">test1</td>
								<th class="tth">이름</th>
								<td class="ttd">테스터</td>
							</tr>
						</tbody>
					</table>
					<table border="1" class="table table-striped">
						<thead class="moreth">
							<tr class="moretr">
								<th class="tth" colspan="4"><img
									src="<%=request.getContextPath()%>/img/fb5.jpg"></th>

							</tr>
						</thead>
						<tbody>
							<tr>
								<th class="tth">닉네임</th>
								<td class="ttd">test1</td>
								<th class="tth">이름</th>
								<td class="ttd">테스터</td>
							</tr>
						</tbody>
					</table>
					<table border="1" class="table table-striped">
						<thead class="moreth">
							<tr class="moretr">
								<th class="tth" colspan="4"><img
									src="<%=request.getContextPath()%>/img/fb6.jpg"></th>

							</tr>
						</thead>
						<tbody>
							<tr>
								<th class="tth">닉네임</th>
								<td class="ttd">test1</td>
								<th class="tth">이름</th>
								<td class="ttd">테스터</td>
							</tr>
						</tbody>
					</table>
					<table border="1" class="table table-striped">
						<thead class="moreth">
							<tr class="moretr">
								<th class="tth" colspan="4"><img
									src="<%=request.getContextPath()%>/img/7fb.jpg"></th>

							</tr>
						</thead>
						<tbody>
							<tr>
								<th class="tth">닉네임</th>
								<td class="ttd">test1</td>
								<th class="tth">이름</th>
								<td class="ttd">테스터</td>
							</tr>
						</tbody>
					</table>
					<table border="1" class="table table-striped">
						<thead class="moreth">
							<tr class="moretr">
								<th class="tth" colspan="4"><img
									src="<%=request.getContextPath()%>/img/jg.jpg"></th>

							</tr>
						</thead>
						<tbody>
							<tr>
								<th class="tth">닉네임</th>
								<td class="ttd">test1</td>
								<th class="tth">이름</th>
								<td class="ttd">테스터</td>
							</tr>
						</tbody>
					</table>
					<table border="1" class="table table-striped">
						<thead class="moreth">
							<tr class="moretr">
								<th class="tth" colspan="4"><img
									src="<%=request.getContextPath()%>/img/kkm.jpg"></th>

							</tr>
						</thead>
						<tbody>
							<tr>
								<th class="tth">닉네임</th>
								<td class="ttd">test1</td>
								<th class="tth">이름</th>
								<td class="ttd">테스터</td>
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
