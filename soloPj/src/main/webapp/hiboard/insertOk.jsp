<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@page import="javax.servlet.*"%>
<%@ page import="soloPjWeb.*"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%
	


	Memb login = (Memb)session.getAttribute("loginUser");
	request.setCharacterEncoding("UTF-8");
	
	Connection conn =null;
	PreparedStatement psmt =null;

	String path =  request.getRealPath("/media/");
	
	int size = 1024 * 1024 * 1024;
	String filename = "";
	String oriFile = "";
	MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
	
	String hsubject = multi.getParameter("hsubject");
	String hwriter = multi.getParameter("hwriter");
	String hcontent = multi.getParameter("hcontent");
	try {
		conn = DBManager.getConnection();
	
	
		

		Enumeration files = multi.getFileNames();

		String str = (String) files.nextElement();

		filename = multi.getFilesystemName(str);// 실제 파일 이름

		oriFile = multi.getOriginalFileName(str); // 이전 파일 이름
		String sql=" insert into hiboard(hidx,hsubject,hcontent,hwriter,mbidx,filename)"
				   + " values(tidx_seq.nextval,?,?,?,?,?)";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,hsubject);
		psmt.setString(2,hcontent);
		psmt.setString(3,hwriter);
		psmt.setInt(4,login.getMbidx());
		psmt.setString(5,filename);
	
		int result = psmt.executeUpdate();
		response.sendRedirect("hiboard.jsp");
	} catch (Exception e) {
		e.printStackTrace();
	}finally{
		if(conn !=null) conn.close();
		if(psmt != null)psmt.close();
}
%>




