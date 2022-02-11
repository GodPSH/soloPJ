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


ArrayList<Reply> rList = new ArrayList<>();
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
	
	
	
	sql = " select * from freply r, memb m"
			 +" where r.mbidx = m.mbidx"
			 +" and r.fidx ="+fidx;
	psmtReply = conn.prepareStatement(sql);
	
	rsReply = psmtReply.executeQuery();
	
	while(rsReply.next()){
		Reply reply = new Reply();
		reply.setFidx(rsReply.getInt("fidx"));
		reply.setMbidx(rsReply.getInt("mbidx"));
		reply.setFridx(rsReply.getInt("fridx"));
		reply.setFrcontent(rsReply.getString("frcontent"));
		reply.setRdate(rsReply.getString("rdate"));
		reply.setMembname(rsReply.getString("membname"));
		
		rList.add(reply);
	}
	
} catch (Exception e) {
	e.printStackTrace();
} finally {
	if(conn != null) conn.close();
	if(psmt != null) psmt.close();
	if(rs != null) rs.close();
	if(psmtReply != null)psmtReply.close();
	if(rsReply != null) rsReply.close();
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
<script>
var mbidx = 0;

<%
	if(mlogin != null){
%>
	mbidx = <%=mlogin.getMbidx()%>
<%
	}
%>
/* function saveRe(){
	$.ajax({
		url : "replyInsert.jsp",
		type:"post",
		data : $("form[name='reply']").serialize(),
		success:function(data){
			var json =JSON.parse(data.trim());
			var html = "<tr>"
				html += "<td>"+json[0].membname+"<input type='hidden' name='fridx' value='"+json[0].fridx+"'></td>";
				html += "<td>"+json[0].frcontent+"</td>";
				html += "<td>"
					if(mbidx == json[0].mbidx){
						html += "<input type='button' value='수정' onclick='modify(this)'>";
						html += "<input type='button' value='삭제' onclick='deleteReply(this)'>";	
					}
					
					html += "</td>";
					html += "</tr>";
					
					$("#replayTable>tbody").append(html);
					
					document.reply.reset();
		}
	}); */
}
function saveRe(){
	$.ajax({
		url : "replyInsert.jsp",
		type:"post",
		data : $("form[name='reply']").serialize(),
		success:function(data){
			var json =JSON.parse(data.trim());
			var html = "<div>"
				html += "<div>"+json[0].membname+"<input type='hidden' name='fridx' value='"+json[0].fridx+"'></div>";
				html += "<td>"+json[0].frcontent+"</div>";
				html += "<div>"
					if(mbidx == json[0].mbidx){
						html += "<input type='button' value='수정' onclick='modify(this)'>";
						html += "<input type='button' value='삭제' onclick='deleteReply(this)'>";	
					}
					
					html += "</div>";
					html += "</div>";
					
					$("#replayTable>tbody").append(html);
					
					document.reply.reset();
		}
	});
}
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
						<td colspan="7" class="tabth2"><%=fsubject_%></td>
					</tr>
					<tr class="textarea">
						<td colspan="8" rowspan="3" class="trtd"><%=fcontent_%></td>
					</tr>
				</tbody>
			</table>
			<button
				onclick="location.href='fboard.jsp?searchType=<%=searchType%>&searchValue=<%=searchValue%>'">목록</button>
			<%
			if (mlogin != null && mlogin.getMbidx() == mbidx_) {
			%>
			<button
				onclick="location.href='modif.jsp?fidx=<%=fidx_%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">수정</button>
			<button onclick="deleteFn()">삭제</button>

			<%
			}
			%>
			<form name="frm" action="deleteOk.jsp" method="post">
				<input type="hidden" name="fidx" value="<%=fidx_%>">
			</form>
						
				<div class="replyList">
				<form class="mb-4" name="reply">
					<div class="rediv">
					
					<%for(Reply r : rList){ %>
							
					
								<div class="rediv-1">작성자</div>
								<div class="rediv-2"><%=r.getMembname()%>: <input type="hidden" name="fridx" value="<%=r.getFridx()%>"></div>
								<div class="rediv-2"><%=r.getFrcontent()%></div>
								
								
								<%if(login != null && (login.getMbidx() == r.getMbidx())){ %>
									<div class="rediv-2"><input type="button" value="수정"  onclick='modify(this)'></div>
									<div class="rediv-2"><input type="button" value="삭제" onclick=''></div>
								<%} %>
								
								
							
							
					<%} %>
					</div>
					</form>
				</div>
			<div class="card bg-light" >
				<div class="card-body" >					
					<form class="mb-4" name="reply">
					<input type="hidden" name="fidx" value="<%=fidx_ %>">
					<div class="rewrite">
						<textarea class="form-control" rows="3"
							placeholder="작성해주세요" name="frcontent"></textarea>
						
							<input type="button" value="저장" onclick="saveRe()" class="writesave">
						</div>	
						</form>
												
				</div>
			</div>

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