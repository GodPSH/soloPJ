<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%

	Memb mlogin = (Memb)session.getAttribute("loginUser");
	request.setCharacterEncoding("UTF-8");
	
	String searchValue = request.getParameter("searchValue");
	String searchType = request.getParameter("searchType");
	
	Connection conn =null;
	PreparedStatement psmt =null;
	ResultSet rs=null;
	
	
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
		
		sql =" select * from fboard";
		rs = psmt.executeQuery(sql);
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
						 <td><%=rs.getInt("fidx")%></td>
						<td><%=rs.getString("fsubject")%></td>
						<td><%=rs.getString("fcontent")%></td>
						<td><%=rs.getString("fwriter")%></td>
						<td><%=rs.getString("fwriteday")%></td>
						<td><%=rs.getInt("fhit")%></td> 
						
					</tr>
					<% 
					}
					%> 
					
				
				</tbody>
				
			</table>
			
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