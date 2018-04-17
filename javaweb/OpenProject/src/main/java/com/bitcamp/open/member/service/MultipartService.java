package com.bitcamp.open.member.service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import com.bitcamp.open.member.model.Member;

public class MultipartService {

	public Member multipart(Member member, HttpServletRequest request) throws IllegalStateException, IOException {
		
		String uploadURI = "/uploadfile/memberphoto";
		
		String dir = request.getSession().getServletContext().getRealPath(uploadURI);
		
		System.out.println(dir);
		
		if(!member.getPhotofile().isEmpty()) {
			
			String fileName = member.getMember_id()+"_"+member.getPhotofile().getOriginalFilename();
			
			member.getPhotofile().transferTo(new File(dir, fileName));
			
		}
		
		
		return member;
		// TODO Auto-generated method stub
		
	}

}
