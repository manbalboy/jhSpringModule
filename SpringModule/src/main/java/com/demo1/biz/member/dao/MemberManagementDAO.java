package com.demo1.biz.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.demo1.biz.member.vo.MemberManagementVO;

@Mapper
public interface MemberManagementDAO {
    List<MemberManagementVO> selectMemberList(MemberManagementVO memberManagementVO) throws Exception;
    int deleteMember(String memberId) throws Exception;
    Map selectMemberIdCheck (Map map) throws Exception;

}

