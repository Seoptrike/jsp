package model;

import java.util.ArrayList;

public interface CommentDAO {
	
	//댓글 목록 
	public ArrayList<CommentVO> list(int bid, int page, int size);
	
	//댓글 등록
	public void insert(CommentVO vo);
	
	//댓글수정
	public void update(CommentVO vo);
	
	//댓글 삭제
	public void delete(int cid);
	
	//댓글 수
	public int total(int cid);
	
	public CommentVO read(int cid);
}
