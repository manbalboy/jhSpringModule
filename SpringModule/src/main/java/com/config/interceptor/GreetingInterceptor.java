package com.config.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author      : 정훈
 * @Version     : 0.1
 * @Date        : 2020. 6. 1. 오전 12:10:58
 * @NAME        : GreetingInterceptor
 * @Description : 인터셉터
 */
public class GreetingInterceptor implements HandlerInterceptor{
	/**
	 * 컨트롤러가 호출되기전
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

//		System.out.println("preHandle1");
		return true;
	}
	
	/**
	 * 컨트롤러가 호출된후
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
//		System.out.println("postHandle 1");
	}
	
	/**
	 * 뷰랜더링후
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
//		System.out.println("afterCompletion 1");
	}
	
}
