package model;

import java.util.*;

public interface StuDAO {
	
	//목록
	public ArrayList<StuVO> list(QueryVO vo);
	
	//검색수
	public int total(QueryVO vo);
	
	//새로운 학번 구하기
	public String getCode();
	
	//학생 등록
	public void insert(StuVO vo);
	
	//학생 정보
	public StuVO read(String scode);
}
