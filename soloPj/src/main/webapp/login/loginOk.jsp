<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="soloPjWeb.*" %>
<%
	String  membid = request.getParameter("membid");
	String  membpw = request.getParameter("membpw");

	
	Connection conn =null;
	PreparedStatement psmt =null;
	ResultSet rs=null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = " select * from memb where membid=? and membpw=?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,membid);
		psmt.setString(2,membpw);
		
		rs = psmt.executeQuery();
		Memb m =null;
		if(rs.next()){
			m = new Memb();
			m.setMbidx(rs.getInt("mbidx"));
			m.setMembid(rs.getString("membid"));
			m.setMembname(rs.getString("membname"));

			
			session.setAttribute("loginUser",m);
			
		}
		if(m !=null){
			response.sendRedirect(request.getContextPath()+"/main.jsp");
		}else{
			response.sendRedirect("login.jsp");
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt, conn, rs);
	}
%>