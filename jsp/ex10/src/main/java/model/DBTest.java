package model;

public class DBTest {

	public static void main(String[] args) {
		UserVO vo= new UserVO();	
		CartDAO dao= new CartDAO();
		dao.list("red");
	}

}
