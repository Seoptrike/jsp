package model;

public class DBTest {

	public static void main(String[] args) {
//		BBSDAOImpl dao = new BBSDAOImpl();
//		dao.total("자바", "title");
		
		CommentDAOImpl dao = new CommentDAOImpl();
//		dao.list(824, 1, 5);

		CommentVO vo = new CommentVO();
//		vo.setBid(824);
//		vo.setWriter("red");
//		vo.setContents("새로운 댓글입니다.");
//		dao.insert(vo);	
		
//		vo.setCid(504);
//		vo.setContents("수정한 댓글입니다");
//		dao.update(vo);
		dao.read(507);
		System.out.println("갯수..........." + dao.read(507));
		}
}
