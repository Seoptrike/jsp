package com.example.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dao.UserDAO;
import com.example.domain.UserVO;

@Controller // 1번째
@RequestMapping("/users") // 2번째 패스지정
public class UserController {
	@Autowired // 3번째 dao 연결
	UserDAO dao;

	// 사용자 목록 페이지 출력
	@GetMapping("/list")
	public String listPage() {
		return "/users/list.html";
	}

	// 사용자 등록 페이지
	@GetMapping("/insert")
	public String insertPage() {
		return "/users/insert.html";
	}

	// 사용자 데이터 등록
	@PostMapping("/insert")
	public void insert(UserVO vo) {
		System.out.println(vo.toString());
		dao.insert(vo);
	}

	// 사용자 목록 데이터 출력
	@GetMapping("")
	@ResponseBody
	public List<HashMap<String, Object>> listData() {
		return dao.list();
	}
}
