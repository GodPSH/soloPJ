<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%
String fidx = request.getParameter("fidx");

Connection conn = null;
PreparedStatement psmt = null;

try {
	conn = DBManager.getConnection();
	String sql = " delete from fboard where fidx= "+fidx;
	
	psmt = conn.prepareStatement(sql);
	
	int result = psmt.executeUpdate();
	
	response.sendRedirect("fboard.jsp");
	
} catch (Exception e) {
	e.printStackTrace();
} finally {
	if (conn != null)
		conn.close();
	if (psmt != null)
		psmt.close();
}
%>
