package model;

import java.sql.*;
import java.util.*;

public class GoodsDAO {
	Connection con = Database.CON;
	//상픔 삭제
	public boolean delete(String gid) {
		try {
			String sql="delete from goods where gid =?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, gid);
			ps.execute();
			return true;
		}catch(Exception e) {
			System.out.println("상품 삭제 : "+ e.toString() );
			return false;
			}
	}
	
	//상품등록
	public boolean insert(GoodsVO vo) {
	try {
		String sql="insert into goods(gid,title,price,brand,image) values(?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, vo.getGid());
		ps.setString(2, vo.getTitle());
		ps.setInt(3, vo.getPrice());
		ps.setString(4, vo.getBrand());
		ps.setString(5, vo.getImage());
		ps.execute();
		return true;
	}catch(Exception e) {
		System.out.println("상품 등록 : "+ e.toString() );
		return false;
		}

	}
	
	public ArrayList<GoodsVO> list(){
		ArrayList<GoodsVO> array = new ArrayList<GoodsVO>();
		try {
			String sql="select * from goods order by regDate desc";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs= ps.executeQuery();
			while(rs.next()) {
				GoodsVO vo = new GoodsVO();
				vo.setGid(rs.getString("gid"));
				vo.setTitle(rs.getString("title"));
				vo.setPrice(rs.getInt("price"));
				vo.setBrand(rs.getString("brand"));
				vo.setImage(rs.getString("image"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("상품 목록 : "+ e.toString() );
			}
		return array;
		}
	
	public int total() {
		int total = 0;
		try {
			String sql = "select count(*) as count from goods";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				total= rs.getInt("count(*)");
			}
		}catch(Exception e){
			System.out.println("전체갯수"+ e.toString());
		}
		return total;
	}
	
}