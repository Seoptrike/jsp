package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class CommentDAOImpl implements CommentDAO{
	Connection con = Database.CON;
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@Override
	public ArrayList<CommentVO> list(int bid, int page, int size) {
		ArrayList<CommentVO> array = new ArrayList<CommentVO>();
		try {
			String sql = "select * from view_comments";
			sql+= " where bid=?";
			sql+= " order by cid desc";
			sql+= " limit ?,?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, bid);
			ps.setInt(2, (page-1)*size);
			ps.setInt(3, size);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				CommentVO vo= new CommentVO();
				
				vo.setCid(rs.getInt("cid"));
				vo.setBid(rs.getInt("bid"));
				vo.setCdate(sdf.format(rs.getTimestamp("cdate")));
				vo.setContents(rs.getString("contents"));
				vo.setWriter(rs.getString("writer"));
				vo.setUname(rs.getString("uname"));
				vo.setPhoto(rs.getString("photo"));
				array.add(vo);
//				System.out.println(vo.toString());
			}
		}catch(Exception e) {
			System.out.println("목록:" + e.toString());
		}
		
		return array;
	}

	@Override
	public void insert(CommentVO vo) {
		try {
			String sql="insert into comments(bid,writer,contents) values(?,?,?)";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setInt(1, vo.getBid());
			ps.setString(2, vo.getWriter());
			ps.setString(3, vo.getContents());
			ps.execute();
		}catch(Exception e) {
			System.out.println("입력:" + e.toString());
		}
	}

	@Override
	public void update(CommentVO vo) {
		try {
			 String sql= "update comments set contents=?,cdate=now() where cid=?";
			 PreparedStatement ps = con.prepareStatement(sql);
			 ps.setString(1, vo.getContents());
			 ps.setInt(2, vo.getCid());
			 ps.execute();
		}catch(Exception e) {
			System.out.println( "게시글 수정" + e.toString());
		}
		
	}

	@Override
	public void delete(int cid) {
		try {
			String sql = "delete from comments where cid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, cid);
			ps.execute();
			
		}catch(Exception e){
			System.out.println( "댓글 삭제" + e.toString());
		}
		
	}

	@Override
	public int total(int bid) {
		int total=0;
		try {
			String sql="select count(*) total from comments where bid=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setInt(1, bid);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) total=rs.getInt("total");
			
		}catch(Exception e) {
			System.out.println("토탈:" + e.toString());
		}
		return total;
	}

	@Override
	public CommentVO read(int cid) {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		CommentVO vo= new CommentVO();
		try {
			String sql = "select * from comments where cid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, cid);
			ResultSet rs= ps.executeQuery();
			if(rs.next()) {
				 vo.setCid(rs.getInt("cid"));
				 vo.setBid(rs.getInt("bid"));
				 vo.setWriter(rs.getString("writer"));
				 vo.setCdate(sdf.format(rs.getTimestamp("cdate")));
				 vo.setContents(rs.getString("contents"));
			//	 System.out.println(vo.toString());
			 }
			
		}catch(Exception e){
			System.out.println( "게시글 읽기" + e.toString());
		}
		return vo;
	}

}
