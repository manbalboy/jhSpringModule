package com.demo1.biz.member.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo1.biz.member.dao.MemberManagementDAO;
import com.demo1.biz.member.service.MemberManagementService;
import com.demo1.biz.member.vo.MemberManagementVO;


/**
 * <pre>
 * SpringModule (After JDK 11)
 * 1. 클래스명 : MemberManagementServiceImpl.java
 * 2. 작성일 : 2020. 6. 12.
 * 3. 작성자 : 정훈
 * 4. 설명 : 회원관리 서비스 구현체
 * </pre>
 */
@Service("memberManagementServiceImpl")
public class MemberManagementServiceImpl implements MemberManagementService{

    @Autowired
    private MemberManagementDAO memberManagementDAO;
    /**
     * 회원리스트 조회
     */
    @Override
    public List<MemberManagementVO> selectMemberList(MemberManagementVO memberManagementVO) throws Exception {
        // TODO Auto-generated method stub
        return memberManagementDAO.selectMemberList(memberManagementVO);
    }

    @Override
    public int deleteMemberList(String checkedIdForDel) throws Exception {
        int deleteCount = 0;
        String [] delId = checkedIdForDel.split(",");
        for (int i=0; i<delId.length ; i++){
            deleteCount += memberManagementDAO.deleteMember(delId[i]);
        }

        return deleteCount;
    }

    @Override
    public Map selectMemberIdCheck(Map paramMap) throws Exception {
        Map map = memberManagementDAO.selectMemberIdCheck(paramMap);
        return map;
    }


}
