package com.bitcamp.open.member.service;



import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.bitcamp.open.member.dao.LoginDao;
import com.bitcamp.open.member.model.Member;

public class MemberLoginService {

	//@Autowired
	//MemberMyBatisDao dao;
	//MemberDao dao;
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate; // Dao 인터페이로 자동 자동 메퍼 생성을 위해 템플릿 클래스 이용
	
	private LoginDao dao;
	
	public Member loginChk(String id, String pw) {
		
		// 런타임시에(실행중) 메퍼 생성을 위한 처리
		dao = sqlSessionTemplate.getMapper(LoginDao.class);
		
		// member 객체를 dao 통해서 받는다. 
		Member member = dao.selectById(id);
		System.out.println("svc: " + member);
		//비밀번호 체크
		if(member !=null && !member.matchPassword(pw)) {
			member = null;
			
		}
		
		return member;
	}

	public Member selectById(String id) {
		// TODO Auto-generated method stub
		return dao.selectById(id);
	}
}
