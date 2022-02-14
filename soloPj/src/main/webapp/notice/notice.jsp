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
	sql = " select count(*) as total from notice ";
	if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null")){
		if(searchType.equals("nsubject")){
			sql += " where nsubject like '%"+searchValue+"%'";
		}else if(searchType.equals("nwriter")){
			sql += " where nwriter = '"+searchValue+"'";
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
	sql += " (select * from notice";
	
	if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null")){
		if(searchType.equals("nsubject")){
			sql += " where nsubject like '%"+searchValue+"%'";
		}else if(searchType.equals("nwriter")){
			sql += " where nwriter = '"+searchValue+"'";
		}
		
	}
	sql += " order by nidx desc ) b)";
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
					<option value="nsubject" <%if(searchType !=null && searchType.equals("nsubject")) out.println("selected"); %>>글제목</option>
					<option value="nwriter" <%if(searchType !=null && searchType.equals("nwriter")) out.println("selected"); %>>작성자</option>
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
						<td><a href="view.jsp?nidx=<%=rs.getInt("nidx")%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%=rs.getString("nsubject")%></a></td>
						<td><%=rs.getString("ncontent")%></td>
						<td><%=rs.getString("nwriter")%></td>
						<td><%=rs.getString("nwriteday")%></td>
						<td><%=rs.getInt("nhit")%></td> 
						
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
					<a href="notice.jsp?nowPage=<%=paging.getStartPage()%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&lt;</a>
					
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
					<a href="notice.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%=i %></a>
							
			<% 
				}
			}
			// 엔드페이지가 라스트페이지가 같지않으면 
			if(paging.getEndPage() != paging.getLastPage()){
			%>	
				<a href="notice.jsp?nowPage=<%=paging.getEndPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&gt;</a>
					
			<%
			}
			%>	
				
			</div>
			<button onclick="location.href='insert.jsp'">등록</button>
			
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