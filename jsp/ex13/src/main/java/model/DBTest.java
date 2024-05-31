package model;

public class DBTest {

	public static void main(String[] args) {
		OrderDAO dao =new OrderDAO();
		QueryVO vo = new QueryVO();
		vo.setKey("uid");
		vo.setWord("blue");
		vo.setPage(1);
		vo.setSize(3);
		dao.list(vo);
	}

}
