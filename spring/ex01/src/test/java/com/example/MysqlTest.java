package com.example;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.example.dao.UsersDAO;

@SpringBootTest
public class MysqlTest {

//	@Autowired
//	MysqlDAO dao;
//
//	@Test
//	public void now() {
//		System.out.println("현재날짜시간: " + dao.now());
//	}

	@Autowired
	UsersDAO udao;

	@Test
	public void list() {
		udao.list();
	}

	@Test
	public void read() {
		udao.read("blue");
	}
}
