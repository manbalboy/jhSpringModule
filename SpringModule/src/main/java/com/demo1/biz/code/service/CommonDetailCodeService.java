package com.demo1.biz.code.service;

import java.util.List;

import com.demo1.biz.code.vo.CommonDetailCodeVO;


/**
 * <pre>
 * SpringModule (After JDK 11)
 * 1. 클래스명 : CommonDetailCodeService.java
 * 2. 작성일 : 2020. 6. 13.
 * 3. 작성자 : 정훈
 * 4. 설명 : 공통세부코드 서비스
 * </pre>
 */
public interface CommonDetailCodeService {
    public List<CommonDetailCodeVO> selectCommonDetailCodeList(CommonDetailCodeVO commonDetailCodeVO) throws Exception;
}
