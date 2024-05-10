package model;

import java.sql.Connection;

public class TestDB {

	public static void main(String[] args) {
			
		Connection con= Database.CON;
//		StuDAOImpl dao= new StuDAOImpl();
		CouDAOImpl dao = new CouDAOImpl();
		QueryVO vo = new QueryVO();
//		vo.setPage(1);
//		vo.setSize(2);
//		vo.setKey("");
//		vo.setWord("리");
	
		System.out.println(dao.getCode(vo));
		
//	System.out.println("검색수: " + dao.total(vo) );
//	System.out.println("새로운 학번: " + dao.getCode());
//		dao.list(vo);
//		dao.read("92414033");
//		boolean result=dao.delete("96414404");
//		System.out.println("결과" + result) ;
	}
		
}
