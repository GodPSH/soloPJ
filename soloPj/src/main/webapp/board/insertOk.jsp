<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%
	Memb login = (Memb)session.getAttribute("loginUser");
	request.setCharacterEncoding("UTF-8");
	String fsubject = request.getParameter("fsubject");
	String fwriter = request.getParameter("fwriter");
	String fcontent = request.getParameter("fcontent");
	
	Connection conn =null;
	PreparedStatement psmt =null;
	
	
	try{ 
		conn = DBManager.getConnection();
		
		String sql=" insert into fboard(fidx,fwriteday,fsubject,fwriter,fcontent,mbidx)"
				   + "values(fidx_seq.nextval,,?,?,?,?)";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,fsubject);
		psmt.setString(2,fwriter);
		psmt.setString(3,fcontent);
		psmt.setInt(4,login.getMbidx());
		
		
		int result = psmt.executeUpdate();
		response.sendRedirect("fboard.jsp");
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn !=null) conn.close();
		if(psmt != null)psmt.close();
	}
%>