package com.config.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;


public class TestFilter implements Filter {
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("init      Testfilter");
		
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("doFilter      Testfilter");
		// TODO Auto-generated method stub
		chain.doFilter(request, response);
		
	}

	@Override
	public void destroy() {
		System.out.println("destroy      Testfilter");
		// TODO Auto-generated method stub
		
	}

}
