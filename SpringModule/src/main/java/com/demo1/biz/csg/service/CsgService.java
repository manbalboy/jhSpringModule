package com.demo1.biz.csg.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo1.biz.csg.dao.CsgDao;
import com.demo1.util.PaginationUtil;
@Service
public class CsgService {

    private static final Logger logger = LoggerFactory.getLogger(CsgService.class);
    @Autowired
    CsgDao csgDao;

    public List<Object> selectDemo1CsgGrowupTodoList(Map<String,Object> param) throws Exception{
        PaginationUtil.setPage(param); //페이징 처리시 해당 코드 삽입
        List<Object> list = csgDao.selectDemo1CsgGrowupTodoList(param);
        return list;
    }
}
