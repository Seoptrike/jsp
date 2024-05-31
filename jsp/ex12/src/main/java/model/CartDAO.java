package model;

import java.sql.*;
import java.util.*;

public class CartDAO {
	Connection con = Database.CON;
	
	public void update(CartVO vo) {
		try {
			String sql="update cart set qnt=? where gid=? and uid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, vo.getQnt());
			ps.setString(3, vo.getUid());
			ps.setString(2, vo.getGid());
			ps.execute();		
		}
		catch(Exception e) {
			System.out.println("수량수정" + e.toString());
		}
		
	}
	
	public boolean delete(String gid,String uid) {
		try {
			String sql="delete from cart where gid=? and uid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, gid);
			ps.setString(2, uid);
			ps.execute();
			return true;
		}catch(Exception e) {
			System.out.println("장바구니상품 삭제 : "+ e.toString() );
			return false;
			}
	}
	
	//장바구니 목록
	public ArrayList<CartVO> list(String uid){
		ArrayList<CartVO> array = new ArrayList<CartVO>();
		try {
			String sql="select * from view_cart where uid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, uid);
			ResultSet rs= ps.executeQuery();
			while(rs.next()) {
				CartVO vo = new CartVO();
				vo.setGid(rs.getString("gid"));
				vo.setUid(rs.getString("uid"));
				vo.setTitle(rs.getString("title"));
				vo.setImage(rs.getString("image"));
				vo.setPrice(rs.getInt("price"));
				vo.setQnt(rs.getInt("qnt"));
				array.add(vo);
				//System.out.println(vo.toString());
			}
		}
		catch(Exception e) {
			System.out.println("장바구니목록" + e.toString());
		}
		return array;
	}
	
	//장바구니에 넣기
	public boolean insert(CartVO vo) {
		try {
			String sql="insert into cart(uid,gid,qnt) value(?,?,1)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getUid());
			ps.setString(2, vo.getGid());
			ps.execute();
			return true;
		}
		catch(Exception e) {
			System.out.println("장바구니담기" + e.toString());
			return false;
		}
	}
}
