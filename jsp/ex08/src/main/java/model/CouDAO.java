package model;

import java.util.*;

public interface CouDAO {
	
	//강좌목록
	public ArrayList<CouVO> list(QueryVO vo);
	
	//
	public int total(QueryVO vo);
	
	//강좌등록
	public void insert(CouVO vo);
	
	//새로운 강좌 코드
	public String getCode(QueryVO vo);
	
	//강좌정보
	public CouVO read(String lcode);
	
	//강좌삭제
	public boolean delete(String lcode);
	
	//강좌수정
	public void update(CouVO vo);
}
