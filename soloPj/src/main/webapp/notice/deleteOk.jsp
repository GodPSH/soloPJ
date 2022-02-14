<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%
String nidx = request.getParameter("nidx");

Connection conn = null;
PreparedStatement psmt = null;

try {
	conn = DBManager.getConnection();
	String sql = " delete from notice where nidx= "+nidx;
	
	psmt = conn.prepareStatement(sql);
	
	int result = psmt.executeUpdate();
	
	response.sendRedirect("notice.jsp");
	
} catch (Exception e) {
	e.printStackTrace();
} finally {
	if (conn != null)
		conn.close();
	if (psmt != null)
		psmt.close();
}
%>
