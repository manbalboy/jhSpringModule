package com.demo1.util;

import java.util.Map;

import org.springframework.util.StringUtils;

public class PaginationUtil {
	public static int cntPerBlock = 10;
	public static int cntPerPage = 10;
	
	public PaginationUtil(int currentPage) {
		
	}
	
	public static Map<String,Object> setPage(Map<String,Object> param) {
		//begin end
		if(StringUtils.isEmpty(param.get("currentPage"))) {
			param.put("currentPage" , "1");
		}
		
		int currentPageTmp = Integer.parseInt((String)param.get("currentPage"));
		param.put("begin", PaginationUtil.getBegin(currentPageTmp));
		param.put("end", PaginationUtil.getEnd(currentPageTmp));
		
		param.put("offset", PaginationUtil.cntPerPage);
		return param;
	}
	
	public static int getBegin(int n) {
		return 1 + (n-1) * PaginationUtil.cntPerPage;
	}
	
	public static int getEnd(int n) {
		return PaginationUtil.cntPerPage + (n-1) * PaginationUtil.cntPerPage;
	}
	

}
