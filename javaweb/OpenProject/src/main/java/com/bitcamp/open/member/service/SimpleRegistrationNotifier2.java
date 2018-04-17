package com.bitcamp.open.member.service;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import com.bitcamp.open.member.model.Member;

public class SimpleRegistrationNotifier2 {
	
	@Autowired
	private JavaMailSender mailSender;
	
	public void sendMail(Member member) {
		// 보내는 정보를 MimeMessage 객체에 담는다.
		
		MimeMessage message = mailSender.createMimeMessage();
		try {
			message.setSubject("회원가입 안내");
			
			String htmlMsg = "<strong>안녕하세요. " 
					+ member.getMember_name() +"님 </strong>, 반갑습니다.";
			message.setText(htmlMsg, "utf-8", "html");
			message.setFrom(new InternetAddress(member.getMember_id()));
			
			
			
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
				
		
	}

}
