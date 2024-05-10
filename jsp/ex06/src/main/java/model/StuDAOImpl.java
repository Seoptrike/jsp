package model;

import java.sql.*;
import java.util.*;

public class StuDAOImpl implements StuDAO {
	Connection con = Database.CON ;
	@Override
	public ArrayList<StuVO> list(QueryVO vo) {
		ArrayList<StuVO> array= new ArrayList<StuVO>();
		try {
			String sql= "select * from view_stu where " + vo.getKey() + " like ? order by scode desc limit ?, ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "%" +vo.getWord()+ "%");
			ps.setInt(2, (vo.getPage()-1)*vo.getSize() );
			ps.setInt(3, vo.getSize());
			ResultSet rs= ps.executeQuery();
			while(rs.next()) {
				StuVO stu= new StuVO();
				stu.setScode(rs.getString("scode"));
				stu.setSname(rs.getString("sname"));
				stu.setBirthday(rs.getString("birthday"));
				stu.setSdept(rs.getString("dept"));
				stu.setPname(rs.getString("pname"));
				stu.setAdvisor(rs.getString("advisor"));
				stu.setYear(rs.getInt("year"));
				array.add(stu);
				//System.out.println(stu.toString());
			}
		} catch(Exception e){
			System.out.println("학생목록:" + e.toString());
		}return array;
	}

	@Override
	public int total(QueryVO vo) {
		int total=0;
		try {
			String sql= "select count(*) as count from view_stu where " + vo.getKey() + " like ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "%" +vo.getWord()+ "%");
			ResultSet rs= ps.executeQuery();
			while(rs.next()) {
				total=rs.getInt("count");
			}
		} catch(Exception e){
			System.out.println("총학생수:" + e.toString());
		}
		return total;
	}

	@Override
	public String getCode() {
		String code="";
		try {
			String sql= "select max(scode)+1 as code from students";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs= ps.executeQuery();
			while(rs.next()) {
				code=rs.getString("code");
			}
		} catch(Exception e){
			System.out.println("새로운 코드:" + e.toString());
		}
		return code;
	}

	@Override
	public void insert(StuVO vo) {
		try {
			String sql= "insert into students(scode,sname,dept,year,birthday,advisor) values(?,?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getScode());
			ps.setString(2, vo.getSname());
			ps.setString(3, vo.getSdept());
			ps.setInt(4, vo.getYear());
			ps.setString(5, vo.getBirthday());
			ps.setString(6, vo.getAdvisor());
			ps.execute();
			
		}catch(Exception e) {
			System.out.println("학생등록: " + e.toString());
		}
		
	}

	@Override
	public StuVO read(String scode) {
		StuVO vo= new StuVO();
		try {
			String sql= "select * from view_stu where scode=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, scode);
			ResultSet rs= ps.executeQuery();
			while(rs.next()) {
				vo.setScode(rs.getString("scode"));
				vo.setSname(rs.getString("sname"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setSdept(rs.getString("dept"));
				vo.setPname(rs.getString("pname"));
				vo.setAdvisor(rs.getString("advisor"));
				vo.setYear(rs.getInt("year"));

				System.out.println(vo.toString());
			}
		} catch(Exception e){
			System.out.println("학생목록:" + e.toString());
		}
		return vo;
	}
	
}
