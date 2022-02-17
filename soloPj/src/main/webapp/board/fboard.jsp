<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%

	Memb mlogin = (Memb)session.getAttribute("loginUser");
	request.setCharacterEncoding("UTF-8");
	
	String searchValue = request.getParameter("searchValue");
	String searchType = request.getParameter("searchType");
	
	
	String nowPage =request.getParameter("nowPage");
	int nowPageI =1;
	if(nowPage != null){
		nowPageI = Integer.parseInt(nowPage);
	}
	
	
	
	Connection conn =null;
	PreparedStatement psmt =null;
	ResultSet rs=null;
	PagingUtil paging =null;
	
	try{ 
		conn = DBManager.getConnection();
		String sql = "";
		
		sql = " select count(*) as total from fboard ";
		if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null")){
			if(searchType.equals("fsubject")){
				sql += " where fsubject like '%"+searchValue+"%'";
			}else if(searchType.equals("fwriter")){
				sql += " where fwriter = '"+searchValue+"'";
			}
			
		}
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		int total = 0;
		
		if(rs.next()){
			total = rs.getInt("total");
		}
		
		paging = new PagingUtil(total,nowPageI,5); // 페이지 5개씩화면에 보이기
		int num = total-(5*(nowPageI-1));
		
		sql =" select * from ";
		sql += " (select rownum r, b.* from"; 
		sql += " (select * from fboard";
		
		if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null")){
			if(searchType.equals("fsubject")){
				sql += " where fsubject like '%"+searchValue+"%'";
			}else if(searchType.equals("fwriter")){
				sql += " where fwriter = '"+searchValue+"'";
			}
			
		}
		
		
		sql += " order by fidx desc ) b)";
		//시작과 끝범위
		sql += " where r >= "+paging.getStart()+" and r <= "+paging.getEnd();
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">	
<link href="<%=request.getContextPath()%>/css/all.css" rel="stylesheet">
<script>
function nologin(){
	var login = '<%=mlogin%>';
	console.log(login);
	console.log(typeof login);
	//location.href ='member/list.jsp';
	
	if(login=='null'){
		alert("로그인 후 접근 가능합니다.");
	}else{
		location.href='main.jsp';
	}
}
</script>
</head>
<body>
	
	<%@ include file="/header.jsp"%>
	<%@ include file="/side.jsp"%>
	<section>
		<h2>전체글</h2>
		<article>
			<div class="all-top">
				<form action="fboard.jsp">
				<select name="searchType">
					<option value="fsubject" <%if(searchType !=null && searchType.equals("fsubject")) out.println("selected"); %>>글제목</option>
					<option value="fwriter" <%if(searchType !=null && searchType.equals("fwriter")) out.println("selected"); %>>작성자</option>
				</select> 
				<input type="text" name="searchValue" <%if(searchValue !=null && !searchValue.equals("")) out.print("value='"+searchValue+"'"); %>> 
				<input type="submit" value="검색">
				</form>
			</div>
			<table class="table">
				<thead class="table-dark">
					<tr>
						<th>No</th>
						<th>제목</th>
						<th>내용</th>
						<th>작성자</th>
						<th>날짜</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
				<%
					while(rs.next()){
				%>
					<tr>
						 <td><%=num%></td>
						<td><a href="view.jsp?fidx=<%=rs.getInt("fidx")%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%=rs.getString("fsubject")%></a></td>
						<td><%=rs.getString("fcontent")%></td>
						<td><%=rs.getString("fwriter")%></td>
						<td><%=rs.getString("fwriteday")%></td>
						<td><%=rs.getInt("fhit")%></td> 
						
					</tr>
					<% 
					num--;
					}
					%> 
					
				
				</tbody>
				
			</table>
			<div id="pagingArea">
				
				<!-- 페이지 1보다크면 이전으로 -->
				<% if(paging.getStartPage() > 1){
			%>	
				<ul>
				<li>
					<a href="fboard.jsp?nowPage=<%=paging.getStartPage()%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&lt;</a>
					
				</li>
				</ul>		
			<%	
			}
			// 현재페이지와 
			for(int i= paging.getStartPage(); i<=paging.getEndPage(); i++){
				//현재페이지와 i같으면 볼드
				if(i == paging.getNowPage()){
			%>
					
						
							<b><%= i %></b>
							
					
			<%//현재페이지와 i같지않으면
				}else{
			%>		
					<a href="fboard.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%=i %></a>
							
			<% 
				}
			}
			// 엔드페이지가 라스트페이지가 같지않으면 
			if(paging.getEndPage() != paging.getLastPage()){
			%>	
				<a href="fboard.jsp?nowPage=<%=paging.getEndPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&gt;</a>
					
			<%	
			}
			%>	
				
			</div>
			<%if(mlogin !=null){ %>
			<button class="btn" onclick="location.href='insert.jsp'">등록</button>
			<%}else if(mlogin==null){ %>
			<button class="btn" onclick="nologin()">등록</button>
			<%} %>
		</article>
		<%@ include file="/footer.jsp"%>
	</section>
	
	<script src="../bootstrap/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null){
			conn.close();
		}
		if(psmt != null){
			psmt.close();
		}
		if(rs != null){
			rs.close();
		}
	}
%>