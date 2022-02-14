<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="soloPjWeb.*"%>
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.*" %>


<%
	request.setCharacterEncoding("UTF-8");


	Memb login = (Memb)session.getAttribute("loginUser");
	

	
	String nridx =  request.getParameter("nridx");
	String nrcontent =  request.getParameter("nrcontent");
	//String fidx2 = request.getParameter("fidx");
	//int fidx=Integer.parseInt(fidx2);
	int nidx=Integer.parseInt(request.getParameter("nidx"));
	int mbidx = login.getMbidx();
	
	String ndate =  request.getParameter("ndate");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	

	
	try{
		conn = DBManager.getConnection();
		
		String sql = " insert into nreply(nridx,nrcontent,nidx,mbidx)"
					+" values(nridx_seq.nextval,?,?,?)";
		psmt = conn.prepareStatement(sql);	
		psmt.setString(1,nrcontent);
		psmt.setInt(2,nidx);
		psmt.setInt(3,mbidx);
		
		psmt.executeUpdate();
		//sql = " select * from freply where fridx= (select max(fridx) from freply)";
		sql = "select * from nreply r, memb m where r.mbidx = m.mbidx and r.nridx = (select max(nridx) from nreply)";
		psmt =conn.prepareStatement(sql);
		
		rs=psmt.executeQuery();
		
		JSONArray lists = new JSONArray();
		if(rs.next()){
			JSONObject obj = new JSONObject();
			obj.put("nidx",rs.getInt("nidx"));
			obj.put("mbidx",rs.getInt("mbidx"));
			obj.put("nridx",rs.getInt("nridx"));
			obj.put("nrcontent",rs.getString("nrcontent"));
			obj.put("membname",rs.getString("membname"));
			
			lists.add(obj);
		}
		out.print(lists.toJSONString());
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
%>	