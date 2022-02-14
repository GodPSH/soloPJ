<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%
	Memb login = (Memb)session.getAttribute("loginUser");
	request.setCharacterEncoding("UTF-8");
	String nsubject = request.getParameter("nsubject");
	String nwriter = request.getParameter("nwriter");
	String ncontent = request.getParameter("ncontent");
	
	Connection conn =null;
	PreparedStatement psmt =null;
	
	
	try{ 
		conn = DBManager.getConnection();
		
		String sql="insert into notice(nidx,nsubject,ncontent,nwriter,mbidx)"
				   + " values(nidx_seq.nextval,?,?,?,?)";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,nsubject);
		psmt.setString(2,ncontent);
		psmt.setString(3,nwriter);
		psmt.setInt(4,login.getMbidx());
		
		
		int result = psmt.executeUpdate();
		response.sendRedirect("notice.jsp");
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn !=null) conn.close();
		if(psmt != null)psmt.close();
	}
%>