<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="soloPjWeb.*"%>
<%@ page import="java.sql.*" %>
<%
	String nridx =  request.getParameter("nridx");

	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		String sql = " delete from nreply where nridx="+nridx;
		
		psmt = conn.prepareStatement(sql);
	
		psmt.executeUpdate();
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn);
	}
%>