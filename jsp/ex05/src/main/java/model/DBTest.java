package model;

public class DBTest {

	public static void main(String[] args) {
//		BBSDAOImpl dao = new BBSDAOImpl();
//		dao.list("카리나",1,10);
		
		CommentDAOImpl dao = new CommentDAOImpl();
		dao.list(824, 1, 5);
	}

}