package com.bitcamp.open.member.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.bitcamp.open.member.dao.LoginDao;
import com.bitcamp.open.member.model.Member;

public class MemberListUpdateService {

	@Autowired
	private SqlSessionTemplate sqlSessoinTemplate;
	
	private LoginDao dao;
	
	
	
	public List<Member> getMemberList(){
		
		dao = sqlSessoinTemplate.getMapper(LoginDao.class);
		
		List<Member> list = dao.selectList();
		
		
		return list;
		
		
	}
	
	public Member listView(String id) {
		
		dao = sqlSessoinTemplate.getMapper(LoginDao.class);
		
		Member member = dao.selectById(id);
		
		System.out.println("상세보기 : " + member.toString());
		
		return member;
	}

		
		

}
