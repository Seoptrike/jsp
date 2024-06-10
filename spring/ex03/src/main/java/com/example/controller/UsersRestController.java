package com.example.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.dao.UsersDAO;
import com.example.domain.QueryVO;
import com.example.domain.UserVO;

@RestController
@RequestMapping("/users")
public class UsersRestController {
	@Autowired
	UsersDAO dao;

	@GetMapping("/plist.json") // 테스트 /users/plist.json?page=1&size=5
	public HashMap<String, Object> plistJSON(QueryVO vo) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("documents", dao.plist(vo));
		map.put("total", dao.total());
		return map;
	}

	@GetMapping("/slist.json") // 테스트 /users/slist.json?page=1&size=5&key=address1&word=인천
	public HashMap<String, Object> slistJSON(QueryVO vo) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("documents", dao.slist(vo));
		map.put("total", dao.total(vo));
		return map;
	}

	@GetMapping("/list.json")
	public List<HashMap<String, Object>> listJSON() {
		return dao.list();
	}

	@GetMapping("/{uid}")
	public UserVO read(@PathVariable("uid") String uid) {
		return dao.read(uid);
	}

	@PostMapping("/insert")
	public int insert(@RequestBody UserVO vo) {
		if (dao.read(vo.getUid()) == null) {
			dao.insert(vo);
			return 1;
		}
		return 0;
	}

	@PostMapping("/update")
	public void update(@RequestBody UserVO vo) {
		System.out.println(vo.toString());
		dao.update(vo);
	}

	@PostMapping("/delete/{uid}")
	public void delete(@PathVariable("uid") String uid) {
		dao.delete(uid);
	}
}
