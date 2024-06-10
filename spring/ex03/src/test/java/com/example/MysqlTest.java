package com.example;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.example.dao.UsersDAO;
import com.example.domain.QueryVO;

@SpringBootTest // 1번째로
public class MysqlTest {

	@Autowired
	UsersDAO udao;

	@Test
	public void plist() {
		QueryVO vo = new QueryVO();
		vo.setPage(2);
		vo.setSize(5);
		udao.plist(vo);
	}

}
