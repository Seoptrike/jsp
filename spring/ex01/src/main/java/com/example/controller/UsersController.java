package com.example.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dao.UsersDAO;
import com.example.domain.UserVO;

@Controller
@RequestMapping("/users")
public class UsersController {
	@Autowired
	UsersDAO dao;

	// 사용자 등록 화면
	@GetMapping("/insert")
	public String insert() {
		return "/users/insert.html";
	}

	// 사용자 등록
	@PostMapping("/insert")
	public String insert(UserVO vo) {
		System.out.println(vo.toString());
		return "redirect:/";
	}

	// 사용자목록 데이터
	@GetMapping("")
	@ResponseBody
	public List<HashMap<String, Object>> list() {
		return dao.list();
	}
}
