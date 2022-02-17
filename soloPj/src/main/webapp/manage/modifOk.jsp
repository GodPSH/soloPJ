<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%
request.setCharacterEncoding("UTF-8");

String mbidx = request.getParameter("mbidx");
String membpw = request.getParameter("membpw");
String membaddr = request.getParameter("membaddr");
String membname = request.getParameter("membname");
String membph = request.getParameter("membph");
String membph2 = request.getParameter("membph2");
String membph3 = request.getParameter("membph3");

Connection conn = null;
PreparedStatement psmt = null;
ResultSet rs = null;

try {
	conn = DBManager.getConnection();


	String sql = " update memb set "
			   + " membpw= '"+membpw+"' "
			   + ",membaddr = '"+membaddr+"' "
			   + ",membname = '"+membname+"' "
			   + ",membph = '"+membph+"' "
			   + ",membph2 = '"+membph2+"' "
			   + ",membph3 = '"+membph3+"' "
			   + "where mbidx="+mbidx;
	
	psmt = conn.prepareStatement(sql);
	int result = psmt.executeUpdate();
	
	if(result>0){
		response.sendRedirect("view.jsp?mbidx="+mbidx);
		
		out.print("<script>alert('수정완료!');<script>");
	} else{
		out.print("<script>alert('수정실패!');<script>");
		response.sendRedirect("manage.jsp");
	}
} catch (Exception e) {
	e.printStackTrace();
} finally {
	if(conn != null) conn.close();
	if(psmt != null) psmt.close();
}
%>