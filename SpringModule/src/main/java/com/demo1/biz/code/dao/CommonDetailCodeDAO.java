package com.demo1.biz.code.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.demo1.biz.code.vo.CommonDetailCodeVO;

@Mapper
public interface CommonDetailCodeDAO {
     List<CommonDetailCodeVO> selectCommonDetailCodeList(CommonDetailCodeVO commonDetailCodeVO) throws Exception;
}
