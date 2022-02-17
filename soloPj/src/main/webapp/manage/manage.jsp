<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%@ page import="java.util.*"%>
<%
Memb mlogin = (Memb)session.getAttribute("loginUser");
String mbidx =request.getParameter("mbidx");
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
	sql = " select count(*) as total from memb ";
	if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null")){
		if(searchType.equals("membname")){
			sql += " where membname like '%"+searchValue+"%'";
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
	sql += " (select * from memb";
	
	if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null")){
		if(searchType.equals("membname")){
			sql += " where membname like '%"+searchValue+"%'";
		}
		
	}
	sql += " order by mbidx desc ) b)";
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
		<h2>전체글</h2>
		<article>
			<div class="all-top">
				<form action="manage.jsp">
				<select>
					<option value="membname" <%if(searchType !=null && searchType.equals("membname")) out.println("selected"); %>>회원이름</option>
					</select>
			
				<input type="text" name="searchValue" <%if(searchValue !=null && !searchValue.equals("")) out.print("value='"+searchValue+"'"); %>> 
				<input type="submit" value="검색">
				</form>
			</div>
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
				<%
					while(rs.next()){
				%>
					<tr>
						<td><%=num%></td>
						<td><%=rs.getString("membid")%></td>
						<td><%=rs.getString("membpw")%></td>
						<td><%=rs.getString("membaddr")%></td>
						<td><%=rs.getInt("membage")%></td>
						<td><a href="view.jsp?mbidx=<%=rs.getInt("mbidx")%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%=rs.getString("membname")%></a></td>
						<td><%=rs.getString("membph")%><%=rs.getString("membph2")%><%=rs.getString("membph3")%></td> 
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
					<a href="manage.jsp?nowPage=<%=paging.getStartPage()%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&lt;</a>
					
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
					<a href="manage.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%=i %></a>
							
			<% 
				}
			}
			// 엔드페이지가 라스트페이지가 같지않으면 
			if(paging.getEndPage() != paging.getLastPage()){
			%>	
				<a href="manage.jsp?nowPage=<%=paging.getEndPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&gt;</a>
					
			<%
			}
			%>	
				
			</div>
			<%
			if(mlogin != null && mlogin.getMbidx() == 1){
			%>	
			
			<button onclick="location.href='insert.jsp'">등록</button>
			<%} %>
		</article>
		<%@ include file="/footer.jsp"%>
	</section>
<%@ include file="/footer.jsp"%>
</body>
</html>
<%
}catch(Exception e){
	
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
}%>