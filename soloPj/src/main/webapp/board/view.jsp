<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%@ page import="java.util.*"%>

<%
int visitSwitch = 0;
String cookiesql = "";   // 쿠키관련 쿼리문

String cookieName = "";

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

if(mlogin != null){   // 조건문 안걸면 오류뜸
    cookieName = fidx + "-" +  mlogin.getMbidx();   // 게시판번호(lidx) - 게시글번호 - 회원번호(midx)로 쿠키이름만 생성
 }
try {
	conn = DBManager.getConnection();
	/* 조회수 */
	 Cookie[] cookies = request.getCookies();
	 if(mlogin != null){
		  if(cookies != null){
			  for(Cookie cook : cookies){
				  if(cook.getName().equals(cookieName) && cook.getValue().equals("viewed")){
					  visitSwitch = 1;
					  break;
				  }
			  }
		  }
	 
	 if(visitSwitch == 0){   // 조회한 이력이 없을 경우
		 cookiesql = " update fboard SET fhit = fhit + 1 WHERE fidx = " + fidx;   // 조회수 1 올려줌
       psmt = conn.prepareStatement(cookiesql);
       int result = psmt.executeUpdate();
       if(result == 1){
          Cookie cookie = new Cookie(cookieName, "viewed");   // 쿠키 이름과 그에대한 값("viewed")을 생성
          cookie.setMaxAge(60 * 60 * 24);   // 24시간으로 설정
          response.addCookie(cookie);      // 생성한걸 쿠키객체에 집어 넣음
       }
    }
    
	 }
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
function saveRe(){
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
					 location.reload();
		}
	}); 
}
function modify(obj){
	var frcontent = $(obj).parent().prev().text();
	var html = "<input type='text' name='frcontent' value='"+frcontent+"' class='remod'><input class='btn' type='hidden' name='origin' value='"+frcontent+"'>";
	
	$(obj).parent().prev().html(html);
	
	html = "<input class='btn' type='button' value='저장' onclick='updateReply(this)'>&nbsp;<input class='btn' type='button' value='취소' onclick='cancleReply(this)'>";
	$(obj).parent().html(html);
}

function cancleReply(obj){
	
	var originContent = $(obj).parent().prev().find("input[name='origin']").val();
	$(obj).parent().prev().html(originContent);
	
	var html = "";
	html += "<input class='btn' type='button' value='수정' onclick='modify(this)'>&nbsp;";
	html += "<input class='btn' type='button' value='삭제' onclick='deleteReply(this)'>";
	
	$(obj).parent().html(html);
}

function updateReply(obj){
	var fridx = $(obj).parent().prev().prev().find("input:hidden").val();
	var frcontent = $(obj).parent().prev().find("input:text").val();
	
	$.ajax({
		url : "updateReply.jsp",
		type : "post",
		data : "fridx="+fridx+"&frcontent="+frcontent,
		success : function(data){
			$(obj).parent().prev().html(frcontent);
			
			// 만약 수정 저장 후 수정,삭제 버튼으로 복구할 때 자신이 쓴글인지 비교가 필요하면
			// 첫 번째 셀에 midx hidden을 추가하여 사용
			var html = "<input class='btn' type='button' value='수정' onclick='modify(this)'>";
			html +="&nbsp;"
			html += "<input class='btn' type='button' value='삭제' onclick='deleteReply(this)'>";
			$(obj).parent().html(html);
		}
	});
}
function deleteReply(obj){
	var YN = confirm("정말 삭제하시겠습니까?");
	
	if(YN){
		var fridx = $(obj).parent().prev().prev().find("input:hidden").val();
		
		$.ajax({
			url:"deleteReply.jsp",
			type:"post",
			data:"fridx="+fridx,
			success: function(){
				$(obj).parent().parent().remove();
			}
			
		});
	}
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
				class="btn" onclick="location.href='fboard.jsp?searchType=<%=searchType%>&searchValue=<%=searchValue%>'">목록</button>
			<%
			if (mlogin != null && mlogin.getMbidx() == mbidx_) {
			%>
			<button
				class="btn" onclick="location.href='modif.jsp?fidx=<%=fidx_%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">수정</button>
			<button class="btn" onclick="deleteFn()">삭제</button>

			<%
			}else if(mlogin.getMbidx()==1){
			%>
			<button
				class="btn" onclick="location.href='modif.jsp?fidx=<%=fidx_%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">수정</button>
			<button class="btn" onclick="deleteFn()">삭제</button>
			<%} %>
			<form name="frm" action="deleteOk.jsp" method="post">
				<input class="btn" type="hidden" name="fidx" value="<%=fidx_%>">
			</form>
						
				<div class="card bg-light">
					<div class="card-body">
						<table class="retable">
							<tbody>
					<%for(Reply r : rList){ %>
								<tr>
								
								<td class="retbwr">작성자</td>
								<td class="retbwr"><%=r.getMembname()%>&nbsp;: <input type="hidden" name="fridx" value="<%=r.getFridx()%>"></td>
								<td><%=r.getFrcontent()%></td>
								
								<td>
								<%if(login != null && login.getMbidx() == r.getMbidx()){ %>
									<input class="btn" type="button" value="수정"  onclick='modify(this)'>
									<input class="btn" type="button" value="삭제" onclick='deleteReply(this)'>
								<%}else if(login.getMbidx()==1){ %>
									<input class="btn" type="button" value="수정"  onclick='modify(this)'>
									<input class="btn" type="button" value="삭제" onclick='deleteReply(this)'>
								<%} %>
								</td>
								</tr>	
								
							
					<%} %>	</tbody>	
						</table>
					</div>
				</div>
			<div class="card bg-light" >
				<div class="card-body" >					
					<form class="mb-4" name="reply">
					<input class="btn" type="hidden" name="fidx" value="<%=fidx_ %>">
					<div class="rewrite">
						<!-- <textarea class="form-control" rows="3"
							placeholder="작성해주세요" name="frcontent" ></textarea> -->
						
						<input type="text" name="frcontent" size="60" placeholder="작성해주세요">
						
							<input  class="btn" type="button" value="저장" onclick="saveRe()" class="writesave">
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