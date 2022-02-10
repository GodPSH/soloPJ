<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.*" %>


<%
	request.setCharacterEncoding("UTF-8");


	Memb login = (Memb)session.getAttribute("loginUser");
	

	request.setCharacterEncoding("UTF-8");
	
	
	String fridx =  request.getParameter("fridx");
	String frcontent =  request.getParameter("frcontent");
	//String fidx2 = request.getParameter("fidx");
	int fidx=Integer.parseInt(request.getParameter("fidx"));
	//int fidx=Integer.parseInt(fidx2);
	
	int mbidx = login.getMbidx();
	
	String rdate =  request.getParameter("rdate");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	

	
	try{
		conn = DBManager.getConnection();
		
		String sql = " insert into freply(fridx,frcontent,fidx,mbidx,)"
					+" values(fridx_seq.nextval,?,?,?)";
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,frcontent);
		psmt.setInt(2,fidx);
		psmt.setInt(3,mbidx);
		
		psmt.executeUpdate();
		
		sql = "select * from freply r, memb m where r.mbidx = m.mbidx and r.fridx = (select max(fridx) from freply)";
		psmt =conn.prepareStatement(sql);
		
		rs=psmt.executeQuery();
		
		JSONArray list = new JSONArray();
		if(rs.next()){
			JSONObject obj = new JSONObject();
			obj.put("fidx",rs.getInt("fidx"));
			obj.put("mbidx",rs.getInt("mbidx"));
			obj.put("fridx",rs.getInt("fridx"));
			obj.put("frcontent",rs.getString("frcontent"));
			obj.put("membname",rs.getString("membname"));
			
			list.add(obj);
		}
		out.print(list.toJSONString());
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
%>	