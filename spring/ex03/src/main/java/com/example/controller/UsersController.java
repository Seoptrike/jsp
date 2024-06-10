package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.dao.UsersDAO;
import com.example.domain.UserVO;

@Controller
@RequestMapping("/users")

public class UsersController {
	@Autowired
	UsersDAO dao;

	@GetMapping("/list")
	public String list() {
		return "/users/list.html";
	}

	@GetMapping("/insert")
	public String insert() {
		return "/users/insert.html";
	}

	@GetMapping("/read/{uid}")
	public String read(@PathVariable("uid") String uid, Model model) {
		UserVO user = dao.read(uid);

		if (user != null && user.getRegDate() != null) {
			// Print original date for debugging
			System.out.println("Original regDate from DB: " + user.getRegDate());
		}
		model.addAttribute("user", user);
		return "users/read";
	}

	@GetMapping("/update/{uid}")
	public String update(@PathVariable("uid") String uid, Model model) {
		model.addAttribute("user", dao.read(uid));
		return "/users/update.html";
	}

}
