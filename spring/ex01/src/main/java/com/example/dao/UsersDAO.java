package com.example.dao;

import java.util.HashMap;
import java.util.List;

public interface UsersDAO {

	public List<HashMap<String, Object>> list();

	public HashMap<String, Object> read(String uid);
}
