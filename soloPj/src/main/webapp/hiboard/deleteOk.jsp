<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%
String hidx = request.getParameter("hidx");

Connection conn = null;
PreparedStatement psmt = null;

try {
	conn = DBManager.getConnection();
	String sql = " delete from hiboard where hidx= "+hidx;
	
	psmt = conn.prepareStatement(sql);
	
	int result = psmt.executeUpdate();
	
	response.sendRedirect("hiboard.jsp");
	
} catch (Exception e) {
	e.printStackTrace();
} finally {
	if (conn != null)
		conn.close();
	if (psmt != null)
		psmt.close();
}
%>
