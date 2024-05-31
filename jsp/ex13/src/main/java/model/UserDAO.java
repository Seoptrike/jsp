package model;

import java.sql.*;

public class UserDAO {
	Connection con = Database.CON;
	//사용자 정보
	public UserVO read(String uid) {
		UserVO vo= new UserVO();
		try {
			String sql= "select * from users where uid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, uid);
			ResultSet rs =ps.executeQuery();
			if(rs.next()) {
				vo.setUid(rs.getString("uid"));
				vo.setUname(rs.getString("uname"));
				vo.setUpass(rs.getString("upass"));
				vo.setPhone(rs.getString("phone"));
				vo.setRaddress1(rs.getString("raddress1"));
				vo.setRaddress2(rs.getString("raddress2"));
			}
		}catch(Exception e){
			System.out.println( "사용자 정보"+ e.toString());
		}
		return vo;
	}
}
