package com.bitcamp.open.member.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.bitcamp.open.member.dao.LoginDao;

public class MemberDeleteService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	private LoginDao dao;
	
	public int deleteMember(String id) {
		
		dao = sqlSessionTemplate.getMapper(LoginDao.class);
		
		int result = dao.deleteMember(id);
		
		return result;
	}

}
