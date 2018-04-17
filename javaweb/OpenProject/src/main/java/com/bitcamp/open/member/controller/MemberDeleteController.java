package com.bitcamp.open.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitcamp.open.member.service.MemberDeleteService;

@Controller
public class MemberDeleteController {
	
	@Autowired
	private MemberDeleteService service;

	@RequestMapping("/member/memberDelete")
	public String deleteMember(Model model, @RequestParam("id") String id) {
		int resultCnt = service.deleteMember(id);
		
		String msg = "삭제 완료";
		
		if(resultCnt == 0)
			msg = "삭제 실패";
		model.addAttribute("msg", msg);
		
		return "member/memberUpdateOk";
		
	}
}
