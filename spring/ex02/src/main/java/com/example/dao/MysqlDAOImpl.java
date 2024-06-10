package com.example.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository // 2.Repository 로 @ 언옵테이션 해야함
public class MysqlDAOImpl implements MysqlDAO {

	@Autowired // 3. 자동으로 세션에 inject(주입하라)
	SqlSession session;

	String namespace = "com.example.mapper.MysqlMapper"; // 4. 맵퍼이름 namespace를 지정해준다

	@Override
	public String now() {
		return session.selectOne(namespace + ".now"); // 5 행이 하나이므로 selectOne으로 세션에서 셀렉한다 6." .xxx" xxx는 셀렉트의 id와 동일하게
														// 한다
	}

}
