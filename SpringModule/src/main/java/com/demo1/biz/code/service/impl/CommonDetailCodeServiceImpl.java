package com.demo1.biz.code.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo1.biz.code.dao.CommonDetailCodeDAO;
import com.demo1.biz.code.service.CommonDetailCodeService;
import com.demo1.biz.code.vo.CommonDetailCodeVO;



/**
 * <pre>
 * SpringModule (After JDK 11)
 * 1. 클래스명 : CommonDetailCodeServiceImpl.java
 * 2. 작성일 : 2020. 6. 13.
 * 3. 작성자 : 정훈
 * 4. 설명 : 공통세부코드 서비스 구현체
 * </pre>
 */
@Service("commonDetailCodeServiceImpl")
public class CommonDetailCodeServiceImpl implements CommonDetailCodeService{

    @Autowired
    private CommonDetailCodeDAO commonDetailCodeDAO;

    /**
     * 공통코드 리스트 조회
     */
    @Override
    public List<CommonDetailCodeVO> selectCommonDetailCodeList(CommonDetailCodeVO commonDetailCodeVO) throws Exception {
        return commonDetailCodeDAO.selectCommonDetailCodeList(commonDetailCodeVO);
    }


}
