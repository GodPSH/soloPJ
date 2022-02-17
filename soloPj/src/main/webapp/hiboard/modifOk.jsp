<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%
request.setCharacterEncoding("UTF-8");

String hidx = request.getParameter("hidx");
String hsubject = request.getParameter("hsubject");
String hcontent = request.getParameter("hcontent");

Connection conn = null;
PreparedStatement psmt = null;
ResultSet rs = null;

try {
	conn = DBManager.getConnection();


	String sql = " update hiboard set "
			   + " hsubject= '"+hsubject+"' "
			   + ",hcontent = '"+hcontent+"' "
			   + "where hidx="+hidx;
	
	psmt = conn.prepareStatement(sql);
	int result = psmt.executeUpdate();
	
	if(result>0){
		response.sendRedirect("view.jsp?hidx="+hidx);
		
		out.print("<script>alert('수정완료!');<script>");
	} else{
		out.print("<script>alert('수정실패!');<script>");
		response.sendRedirect("hiboard.jsp");
	}
} catch (Exception e) {
	e.printStackTrace();
} finally {
	if(conn != null) conn.close();
	if(psmt != null) psmt.close();
}
%>