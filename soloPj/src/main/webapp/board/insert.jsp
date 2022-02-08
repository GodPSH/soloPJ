<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%
	Memb ilogin = (Memb) session.getAttribute("loginUser");
	String userName = "";
	
	
	Connection conn =null;
	PreparedStatement psmt =null;
	ResultSet rs=null;
	try{
		conn = DBManager.getConnection();
	
	
if (ilogin != null) {
	userName = ilogin.getMembname();
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
<link href="<%=request.getContextPath()%>/css/all.css" rel="stylesheet">
</head>
<body>
	<%@ include file="/header.jsp"%>
	<%@ include file="/side.jsp"%>
	<section>
		<h2>글을 등록하세요</h2>
		<form action="insertOk.jsp">
			<table border="1" class="table table-bordered">
				<thead>
					<tr>
						<th class="tabth">작성자</th>
						<th class="tabth" ><input name="fwriter" value="<%=userName%>"></th>
						<th class="tabth">등록일</th>
						<th class="tabth"></th>
						<th class="tabth">조회수</th>
						<th class="tabth"></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>제목</th>
						<td colspan="5"><input type="text" name="fsubject" class="tbin"></td>
					</tr>
					<tr class="textarea">
						<td colspan="6" rowspan="3" class="trtd">
							<textarea name="fcontent" rows="3"></textarea>
						</td>
					</tr>
					<tr>
					</tr>
					<tr>
					</tr>
				</tbody>
			</table>
			<input type="submit" value="등록">
			<input type="button" value="취소" onclick="location.href='fboard.jsp'">
			
		</form>
	</section>

	<%@ include file="/footer.jsp"%>
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