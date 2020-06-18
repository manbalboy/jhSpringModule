package com.demo1.biz.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.demo1.biz.member.vo.MemberManagementVO;
import com.util.CamelMap;

@Mapper
public interface MemberManagementDAO {
    List<MemberManagementVO> selectMemberList(MemberManagementVO memberManagementVO) throws Exception;
    int deleteMember(String memberId) throws Exception;
    int insertMember(MemberManagementVO memberManagementVO) throws Exception;
    Map selectMemberIdCheck (Map map) throws Exception;
    CamelMap selectMemberLogin (Map map) throws Exception;

}

