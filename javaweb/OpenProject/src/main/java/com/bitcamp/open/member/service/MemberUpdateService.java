package com.bitcamp.open.member.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.bitcamp.open.member.dao.LoginDao;
import com.bitcamp.open.member.model.Member;

public class MemberUpdateService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	private LoginDao dao;
	
	@Autowired
	MultipartService service;
	
	public int memberUpdate(Member member, HttpServletRequest request) throws IllegalStateException, IOException {
		
		dao = sqlSessionTemplate.getMapper(LoginDao.class);
		
		service.multipart(member, request);
		
		System.out.println("실행전 : " + member.getIdx());
		
		int resultCnt = dao.updateMember(member);
		
		System.out.println("실행후 : " + member.getIdx());
		
		
		return resultCnt;
		
		
	}
	
	

}
