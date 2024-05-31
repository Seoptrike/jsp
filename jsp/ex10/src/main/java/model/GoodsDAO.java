package model;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class GoodsDAO {
	Connection con = Database.CON;
	SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
	public GoodsVO read(String gid) {
		GoodsVO vo= new GoodsVO();
		try {
			String sql="select * from goods where gid=? ";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, gid);
			ResultSet rs= ps.executeQuery();
			while(rs.next()) {
				vo.setGid(rs.getString("gid"));
				vo.setTitle(rs.getString("title"));
				vo.setPrice(rs.getInt("price"));
				vo.setBrand(rs.getString("brand"));
				vo.setImage(rs.getString("image"));
				vo.setRegDate(sdf.format(rs.getTimestamp("regDate")));
			}
		}catch(Exception e) {
			System.out.println("상품 목록 : "+ e.toString() );
			}
		return vo;
	}
	
	public int total(String word) {
		int total=0;
		try {
			String sql="select count(*) from goods where title like ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "%"+ word +"%");
			ResultSet rs= ps.executeQuery();
			if(rs.next()) {
				total= rs.getInt("count(*)");
			}
		}catch(Exception e) {
			System.out.println("전체상품수 : "+ e.toString() );
			}
		return total;
		}
	
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
	
	public ArrayList<GoodsVO> list(QueryVO query){
		ArrayList<GoodsVO> array = new ArrayList<GoodsVO>();
		try {
			String sql="select * from goods where title like ? order by regDate desc limit ?,?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "%"+query.getWord()+"%");
			ps.setInt(2, (query.getPage()-1)*query.getSize());
			ps.setInt(3, query.getSize());
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
}