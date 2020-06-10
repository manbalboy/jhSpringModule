package com.demo1.biz.pse.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo1.biz.pse.dao.PseDao;

@Service
public class PseService {

    private static final Logger logger = LoggerFactory.getLogger(PseService.class);

    @Autowired
    PseDao pseDao;

    /*
     * 20.06.10
     * 서은's 데일리 다이어리 리스트 조회
     */
    public List<Object> selectPSE_DAILYDIARY(Map<String,Object> param) throws Exception{
        List<Object> list = pseDao.selectPSE_DAILYDIARY(param);
        logger.info("param : {}", param);
        return list;
    }
}
