package com.demo1.biz.member.service;

import java.util.List;
import java.util.Map;

import com.demo1.biz.member.vo.MemberManagementVO;

/**
 * <pre>
 * SpringModule (After JDK 11)
 * 1. 클래스명 : MemberManagementService.java
 * 2. 작성일 : 2020. 6. 12.
 * 3. 작성자 : 정훈
 * 4. 설명 : 회원관리 서비스
 * </pre>
 */
public interface MemberManagementService {
    public List<MemberManagementVO> selectMemberList(MemberManagementVO memberManagementVO) throws Exception;
    public int deleteMemberList(String checkedIdForDel) throws Exception;
    public Map selectMemberIdCheck(Map paramMap) throws Exception;
}
