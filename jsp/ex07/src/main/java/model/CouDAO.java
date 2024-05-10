package model;

import java.util.*;

public interface CouDAO {
	
	//강좌목록
	public ArrayList<CouVO> list(QueryVO vo);
	
	//
	public int total(QueryVO vo);
	
	//
	public void insert(CouVO vo);
	
	//새로운 강좌 코드
	public String getCode(QueryVO vo);
}
