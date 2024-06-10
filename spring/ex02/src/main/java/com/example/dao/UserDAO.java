package com.example.dao;

import java.util.HashMap;
import java.util.List;

import com.example.domain.UserVO;

public interface UserDAO {
	public List<HashMap<String, Object>> list();

	public void insert(UserVO vo);
}
