package com.bitcamp.open.member.dao;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import com.bitcamp.open.member.model.Member;

public class MemberDao {
	
	private JdbcTemplate jdbcTemplate;
	
	// 생성자 방식으로 의존 설정
	public MemberDao(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public int insertMember(Member member) {
		
		String sql = "insert into member (member_id, member_name, password, photo ) "
				+ " values ( ?, ?, ?, ? )";
		
		int resultCnt = jdbcTemplate.update(
				sql, 
				member.getMember_id(), 
				member.getMember_name(), 
				member.getPassword(),
				member.getPhoto());
		
		
		return resultCnt;
	}

	public Member selectById(String id) {
		
		String sql = "select * from member where member_id = ?";		
		List<Member> result = jdbcTemplate.query(sql, new MemberRowMapper(),id);
		return result.isEmpty() ? null : result.get(0);
	
	}

	public List<Member> selectMembers() {
		
		String sql = "select * from member";
		List<Member> result = jdbcTemplate.query(sql, new MemberRowMapper());
		
		return result;
	}
	
	
	
	
	
}
