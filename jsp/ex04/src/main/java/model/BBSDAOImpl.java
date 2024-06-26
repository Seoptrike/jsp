package model;

import java.security.spec.PSSParameterSpec;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.naming.spi.DirStateFactory.Result;

public class BBSDAOImpl implements BBSDAO { //BBSDAO 를 구현한 클래스
	Connection con = Database.CON;
	 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Override
	public ArrayList<BBSVO> list() {
		 ArrayList<BBSVO> array = new ArrayList<BBSVO>();
		
		 
		 try {
			 String sql = "select * from view_bbs order by bid desc";
			 PreparedStatement ps = con.prepareStatement(sql);
			 ResultSet rs= ps.executeQuery();
			 
			 while(rs.next()) {
				 BBSVO vo= new BBSVO();
				 vo.setBid(rs.getInt("bid"));
				 vo.setTitle(rs.getString("title"));
				 vo.setWriter(rs.getString("writer"));
				 vo.setBdate(sdf.format(rs.getTimestamp("bdate")));
				 vo.setUname(rs.getString("uname"));
				 vo.setContents(rs.getString("contents"));
				 vo.setPhoto(rs.getString("photo"));
				 array.add(vo);
				 //System.out.println(vo.toString());
			 }
			 
		 }catch(Exception e) {
			 System.out.println( "게시글 목록" + e.toString());
		 }
		return array;
	}

	@Override
	public void insert(BBSVO vo) {
		try {
			String sql="insert into bbs(title,contents,writer) values(?,?,?)";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, vo.getTitle());
			ps.setString(2, vo.getContents());
			ps.setString(3, vo.getWriter());
			ps.execute();
			
		}catch(Exception e) {
			System.out.println("게시글 등록:" + e.toString());
		}
	}
	@Override
	public BBSVO read(int bid) {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		BBSVO vo= new BBSVO();
		try {
			String sql = "select * from view_bbs where bid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, bid);
			ResultSet rs= ps.executeQuery();
			if(rs.next()) {
				 vo.setBid(rs.getInt("bid"));
				 vo.setTitle(rs.getString("title"));
				 vo.setWriter(rs.getString("writer"));
				 vo.setBdate(sdf.format(rs.getTimestamp("bdate")));
				 vo.setUname(rs.getString("uname"));
				 vo.setContents(rs.getString("contents"));
				 vo.setPhoto(rs.getString("photo")); 
			//	 System.out.println(vo.toString());
			 }
			
		}catch(Exception e){
			System.out.println( "게시글 읽기" + e.toString());
		}
		return vo;
	}

	@Override
	public void update(BBSVO vo) {
		try {
			 String sql= "update bbs set title=?,contents=?,bdate=now() where bid=?";
			 PreparedStatement ps = con.prepareStatement(sql);
			 ps.setString(1, vo.getTitle());
			 ps.setString(2, vo.getContents());
			 ps.setInt(3, vo.getBid());
			 ps.execute();
		}catch(Exception e) {
			System.out.println( "게시글 수정" + e.toString());
		}
		
	}

	@Override
	public void delete(int bid) {
		try {
			String sql = "delete from bbs where bid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, bid);
			ps.execute();
			
		}catch(Exception e){
			System.out.println( "게시글 삭제" + e.toString());
		}
	}

	@Override
	public ArrayList<BBSVO> list(String query, String key, int page, int size) {
		ArrayList<BBSVO> array = new ArrayList<BBSVO>();
		try {
			String sql = "SELECT * FROM view_bbs WHERE " + key + " LIKE CONCAT('%', ?, '%') ORDER BY bid DESC limit ?, ?";
			System.out.println("........." + sql);
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, query);
			pstmt.setInt(2, (page-1)*size);
			pstmt.setInt(3, size);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				BBSVO vo = new BBSVO();
				vo.setBid(rs.getInt("bid"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setBdate(sdf.format(rs.getTimestamp("bdate")));
				vo.setUname(rs.getString("uname"));
				vo.setPhoto(rs.getString("photo"));
				vo.setContents(rs.getString("contents"));
				array.add(vo);
				// System.out.println(vo.toString());
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("게시판 목록 : " + e.toString());
		}
		return array;
	}

	@Override
	public int total(String query, String key) {
		int total=0;
		query = "%" + query + "%";
		try {
			String sql="select count(*) total from bbs WHERE " + key + " like ?";
			System.out.println("sql................." + sql);
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, query);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) total=rs.getInt("total");
		}catch(Exception e) {
			System.out.println("전체갯수:" + e.toString());
		}
		return total;
	}
}
