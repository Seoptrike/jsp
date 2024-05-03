package model;

import java.sql.*;
import java.util.*;

public class UserDAO { //Database Access Object
	
	Connection con = Database.CON;
//	public List<UserVO> searchList(String key, String query) {
//        // 검색 키와 검색어에 따라 SQL 쿼리를 준비합니다.
//        String sql = "SELECT * FROM user";
//        if (key != null && !key.isEmpty()) {
//            sql += " WHERE " + key + " LIKE '%" + query + "%'";
//        }
//
//        // 쿼리를 실행하고 결과를 가져옵니다.
//        List<UserVO> list = new ArrayList<>();
//        try (
//             PreparedStatement ps = con.prepareStatement(sql);
//             ResultSet rs = ps.executeQuery()) {
//            while (rs.next()) {
//                UserVO vo = new UserVO();
//                vo.setUid(rs.getString("uid"));
//                vo.setUpass(rs.getString("upass"));
//                vo.setUname(rs.getString("uname"));
//                vo.setPhone(rs.getString("phone"));
//                vo.setAddress1(rs.getString("address1"));
//                vo.setAddress2(rs.getString("address2"));
//                vo.setPhoto(rs.getString("photo"));
//                list.add(vo);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//
//        return list;
//    }
//	
	public ArrayList<UserVO> list(){
		ArrayList<UserVO> array = new ArrayList<UserVO>();
		try {
			String sql = "select * from users order by jdate desc";
			PreparedStatement ps =con.prepareStatement(sql);
			ResultSet rs= ps.executeQuery();
			while(rs.next()) {
				UserVO vo =new UserVO();
				vo.setUid(rs.getString("uid"));
				vo.setUname(rs.getString("uname"));
				vo.setUpass(rs.getString("upass"));
				vo.setPhone(rs.getString("phone"));
				vo.setAddress1(rs.getString("address1"));
				vo.setAddress2(rs.getString("address2"));
				vo.setPhoto(rs.getString("photo"));
				vo.setJdate(rs.getTimestamp("jdate"));
				
				array.add(vo);
				
			}
		}catch(Exception e) {
			System.out.println("사용자 목록"+ e.toString());
		}
		return array;
	};
	
	
	public void insert(UserVO vo) {
		try {
		String sql = "insert into users(uid,upass,uname) values(?,?,?)" ;
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, vo.getUid());
		ps.setString(2, vo.getUpass());
		ps.setString(3, vo.getUname());
		ps.execute();
		
		}catch(Exception e){
			System.out.println("회원가입"+ e.toString());
			}
		
	}
	
	public void updatePhoto(String uid, String photo) {
		try {
			 String sql = "update users set photo=? where uid=?";
			 PreparedStatement ps = con.prepareStatement(sql);
			 ps.setString(1, photo);
			 ps.setString(2, uid);
			 ps.execute();
			
		}catch(Exception e) {
			System.out.println("사진 수정"+ e.toString());
		}
	}
	
	public void update(String uid, String npass) {
		try {
			String sql= "update users set upass=? where uid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, npass);
			ps.setString(2, uid);
			ps.execute();
			
		}catch(Exception e){
			System.out.println("비밀번호 수정"+ e.toString());
		}
	}
	
	public void update(UserVO vo) {
		try {
			String sql="update users set udate=now(),uname=?,phone=?,address1=?,address2=? where uid=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, vo.getUname());
			ps.setString(2, vo.getPhone());
			ps.setString(3, vo.getAddress1());
			ps.setString(4, vo.getAddress2());
			ps.setString(5, vo.getUid());
			ps.execute();
			
		}catch(Exception e) {
			System.out.println("update"+ e.toString());
		}
	}
	
	public UserVO read(String uid) {
		UserVO vo =new UserVO();
		try {
			String sql = "select * from users where uid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, uid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				vo.setUid(rs.getString("uid"));
				vo.setUname(rs.getString("uname"));
				vo.setUpass(rs.getString("upass"));
				vo.setPhone(rs.getString("phone"));
				vo.setAddress1(rs.getString("address1"));
				vo.setAddress2(rs.getString("address2"));
				vo.setPhoto(rs.getString("photo"));
				vo.setJdate(rs.getTimestamp("jdate"));
				vo.setUdate(rs.getTimestamp("udate"));
			}
			
		}catch(Exception e) {
			System.out.println("read"+ e.toString());
		}
		
		return vo;
	} 

}
