<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%
request.setCharacterEncoding("UTF-8");

String nidx = request.getParameter("nidx");
String nsubject = request.getParameter("nsubject");
String ncontent = request.getParameter("ncontent");

Connection conn = null;
PreparedStatement psmt = null;
ResultSet rs = null;

try {
	conn = DBManager.getConnection();


	String sql = " update notice set "
			   + " nsubject= '"+nsubject+"' "
			   + ",ncontent = '"+ncontent+"' "
			   + "where nidx="+nidx;
	
	psmt = conn.prepareStatement(sql);
	int result = psmt.executeUpdate();
	
	if(result>0){
		response.sendRedirect("view.jsp?nidx="+nidx);
		
		out.print("<script>alert('수정완료!');<script>");
	} else{
		out.print("<script>alert('수정실패!');<script>");
		response.sendRedirect("notice.jsp");
	}
} catch (Exception e) {
	e.printStackTrace();
} finally {
	if(conn != null) conn.close();
	if(psmt != null) psmt.close();
}
%>