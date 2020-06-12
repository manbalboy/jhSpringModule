package com.demo1.biz.pse.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
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

    /*
     * 20.06.11
     * 서은's 데일리 다이어리 등록
     */
    public int insertPSE_DAILYDIARY(Map<String,Object> param) throws Exception{

        logger.info("param : {}", param);

        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        System.out.println("접속 아이디 : "+ user.getUsername());

        param.put("userId", user.getUsername());

        return pseDao.insertPSE_DAILYDIARY(param);

    }

    /*
     * 20.06.12
     * 서은's 데일리 다이어리 수정
     */
    public int updatePSE_DAILYDIARY(Map<String,Object> param) throws Exception{
        logger.info("param : {}", param);

        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        System.out.println("접속 아이디 : "+ user.getUsername());

        param.put("userId", user.getUsername());

        return pseDao.updatePSE_DAILYDIARY(param);
    }

    /*
     * 20.06.12
     * 서은's 데일리 다이어리 삭제
     */
    public int deletePSE_DAILYDIARY(Map<String,Object> param) throws Exception{
        logger.info("param : {}", param);

        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        System.out.println("접속 아이디 : "+ user.getUsername());

        param.put("userId", user.getUsername());

        return pseDao.deletePSE_DAILYDIARY(param);
    }

}
