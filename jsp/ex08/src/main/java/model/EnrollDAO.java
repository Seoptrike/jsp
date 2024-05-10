package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class EnrollDAO {
	Connection con = Database.CON;
	//수강취소
	public boolean delete(String scode,String lcode) {
		try {
			String sql="delete from enrollments where scode=? and lcode=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, scode);
			ps.setString(2, lcode);
			ps.execute();
			
			sql="update courses set persons=persons-1 where lcode=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, lcode);
			ps.execute();
			
			return true;
		}catch(Exception e) {
			System.out.println( " 수강취소: " +e.toString());
			return false;
		}
	}
	
	//수강신청
	public boolean insert(String scode,String lcode) {
		try {
			String sql="insert into enrollments(scode,lcode,edate,grade) values(?,?,now(),0)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, scode);
			ps.setString(2, lcode);
			ps.execute();
			
			sql="update courses set persons=persons+1 where lcode=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, lcode);
			ps.execute();
			
			return true;
		}catch(Exception e) {
			System.out.println( " 수강신청: " +e.toString());
			return false;
		}
	}
	
	// 특정 강좌의 수강신청 목록
	public ArrayList<GradeVO> slist(String lcode){
		ArrayList<GradeVO> array=new ArrayList<GradeVO>();
		try {
			String sql= "select * from view_enr_stu where lcode=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, lcode);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				GradeVO vo = new GradeVO();
				vo.setLcode(rs.getString("lcode"));
				vo.setScode(rs.getString("scode"));
				vo.setSname(rs.getString("sname"));
				vo.setSdept(rs.getString("dept"));
				vo.setGrade(rs.getInt("grade"));
				vo.setEdate(rs.getString("edate"));
				vo.setYear(rs.getInt("year"));

				//System.out.println(vo.toString());
				array.add(vo);
				}
		}catch(Exception e) {
			System.out.println( " 수강신청학생목록: " +e.toString());
		}
		return array;
	}
	
	public ArrayList<EnrollVO> list(String scode) {
		ArrayList<EnrollVO> array = new ArrayList<EnrollVO>();
		try {
			String sql= "select * from view_enr_cou where scode=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, scode);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				EnrollVO vo = new EnrollVO();
				vo.setLcode(rs.getString("lcode"));
				vo.setHours(rs.getInt("hours"));
				vo.setRoom(rs.getString("room"));
				vo.setCapacity(rs.getInt("capacity"));
				vo.setPersons(rs.getInt("persons"));
				vo.setPname(rs.getString("pname"));
				vo.setGrade(rs.getInt("grade"));
				vo.setPcode(rs.getString("instructor"));
				vo.setEdate(rs.getString("edate"));
				vo.setScode(rs.getString("scode"));
				vo.setDept(rs.getString("dept"));
				vo.setLname(rs.getString("lname"));
				//System.out.println(vo.toString());
				array.add(vo);
				}
		}catch(Exception e) {
			System.out.println( " 수강신청목록: " +e.toString());
		}
		return array;
	}
}
