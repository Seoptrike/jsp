package model;

import java.util.*;

public interface BBSDAO {
	//목록
	public ArrayList<BBSVO> list();
		
	
	//입력
	public void insert(BBSVO vo);
	
	
	//읽기
	public BBSVO read(int bid);
	
	
	//수정
	public void update(BBSVO vo);
	
	//삭제
	public void delete(int bid);
	
	//페이징 목록
	public ArrayList<BBSVO> list(String query, String key, int page, int size);
	
	//전체 데이터 갯수
	public int total(String query , String key);

}
