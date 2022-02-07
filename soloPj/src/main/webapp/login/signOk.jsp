<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="soloPjWeb.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String  membid = request.getParameter("membid");
	String  membpw = request.getParameter("membpw");
	String  membaddr = request.getParameter("membaddr");
	String  membage = request.getParameter("membage");
	String  membph = request.getParameter("membph");
	String  membname = request.getParameter("membname");
	String  membph2 = request.getParameter("membph2");
	String  membph3 = request.getParameter("membph3");
	
	String url ="jdbc:oracle:thin:@localhost:1522:xe";
	String user="system";
	String pass="1234";
	
	Connection conn =null;
	PreparedStatement psmt =null;
	
	String sql = " insert into memb(mbidx,membid,membpw,membaddr,membage,membph,membph2,membph3,membname)"
			+" values(mbidx_seq.nextval,?,?,?,?,?,?,?,?)";
	
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,membid);
		psmt.setString(2,membpw);
		psmt.setString(3,membaddr);
		psmt.setString(4,membage);
		psmt.setString(5,membph);
		psmt.setString(6,membph2);
		psmt.setString(7,membph3);
		psmt.setString(8,membname);
		
		int result = psmt.executeUpdate();
		
		response.sendRedirect("../main.jsp");
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn !=null) conn.close();
		if(psmt != null)psmt.close();
	}
%>