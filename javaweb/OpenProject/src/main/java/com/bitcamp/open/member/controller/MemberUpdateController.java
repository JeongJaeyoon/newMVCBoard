package com.bitcamp.open.member.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitcamp.open.member.model.Member;
import com.bitcamp.open.member.service.MemberListService;
import com.bitcamp.open.member.service.MemberUpdateService;

@Controller
@RequestMapping("/member/memberUpdate")
public class MemberUpdateController {
	
	@Autowired
	private MemberListService service;
	
	@Autowired
	private MemberUpdateService uservice;

	@RequestMapping(method = RequestMethod.GET)
	public String updateMember(Model model, @RequestParam("id") String id) {
		
		Member member = service.listView(id);
		
		model.addAttribute("member", member);
		
		return "member/memberUpdate";
		
		
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String updateOk(Member member, Model model, HttpServletRequest request) throws IllegalStateException, IOException {
		
		int resultCnt = uservice.memberUpdate(member, request);
		
		String msg = "정보수정완료";
		
		if(resultCnt == 0)
			
			msg = "정보수정 실패";
		
		model.addAttribute("msg", msg);
				
		
		return "member/memberUpdateOk";
		
	}
	
}
