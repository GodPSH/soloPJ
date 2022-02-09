<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%
request.setCharacterEncoding("UTF-8");

String fidx = request.getParameter("fidx");
String fsubject = request.getParameter("fsubject");
String fcontent = request.getParameter("fcontent");

Connection conn = null;
PreparedStatement psmt = null;
ResultSet rs = null;

try {
	conn = DBManager.getConnection();

	String sql =  " update fboard set"
			+ " fsubject='"+fsubject+"'"
			+ ",fcontent = '"+fcontent+"'"
			+ "where fidx="+fidx;
	psmt = conn.prepareStatement(sql);
	int result = psmt.executeUpdate();
	
	if(result>0){
		response.sendRedirect("view.jsp?fidx="+fidx);
		
		out.print("<script>alert('수정완료!');<script>");
	} else{
		out.print("<script>alert('수정실패!');<script>");
		response.sendRedirect("fboard.jsp");
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