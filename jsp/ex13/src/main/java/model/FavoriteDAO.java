package model;

import java.sql.*;

public class FavoriteDAO {
	Connection con = Database.CON;
	// 좋아요 추가
	public void insert(String uid , String gid) {
		try {
			String sql="insert into favorite(gid,uid) values(?,?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, gid);
			ps.setString(2, uid);
			ps.execute();
		
		}catch(Exception e) {
			System.out.println("좋아요 추가 등록 : "+ e.toString() );
			}
	}
	
	public void delete(String uid , String gid) {
		
		try {
			String sql="delete from favorite where gid=? and uid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, gid);
			ps.setString(2, uid);
			ps.execute();
		
		}catch(Exception e) {
			System.out.println("좋아요 취소 : "+ e.toString() );
			}
		
	}
}
