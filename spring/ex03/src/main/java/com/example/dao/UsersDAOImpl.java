package com.example.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.QueryVO;
import com.example.domain.UserVO;

@Repository
public class UsersDAOImpl implements UsersDAO {
	@Autowired
	SqlSession session;
	String namespace = "com.example.mapper.UsersMapper";

	@Override
	public List<HashMap<String, Object>> list() {
		return session.selectList(namespace + ".list");
	}

	@Override
	public UserVO read(String uid) {
		return session.selectOne(namespace + ".read", uid);
	}

	@Override
	public void insert(UserVO vo) {
		session.insert(namespace + ".insert", vo);
	}

	@Override
	public void update(UserVO vo) {
		session.update(namespace + ".update", vo);

	}

	@Override
	public void delete(String uid) {
		session.delete(namespace + ".delete", uid);

	}

	@Override
	public List<HashMap<String, Object>> plist(QueryVO vo) {
		return session.selectList(namespace + ".plist", vo);
	}

	@Override
	public int total() {
		return session.selectOne(namespace + ".total");
	}

	@Override
	public List<HashMap<String, Object>> slist(QueryVO vo) {
		return session.selectList(namespace + ".slist", vo);
	}

	@Override
	public int total(QueryVO vo) {
		return session.selectOne(namespace + ".stotal", vo);
	}

}
