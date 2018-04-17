package com.bitcamp.open.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthCheckInterceptor extends HandlerInterceptorAdapter {

		@Override
		public boolean preHandle(
				HttpServletRequest request, 
				HttpServletResponse response, 
				Object handler)
				throws Exception {

			// 세션정보 확인
			HttpSession session = request.getSession(false);

			if (session != null) {
				
				Object authObj = session.getAttribute("loginInfo");
				
				if (authObj != null) {
					// 정상적으로 다음 실행 할 컨트롤러나 인터셉터를 실행한다.
					return true;
				}
			}

			// 로그인 페이지로 리다이렉트 처리
			response.sendRedirect(request.getContextPath() + "/member/login");

			// 이후에 실행할 컨트롤러나 인터셉터가 실행 되지 않는다.
			return false;

}
}
