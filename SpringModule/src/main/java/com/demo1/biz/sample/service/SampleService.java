package com.demo1.biz.sample.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo1.biz.sample.dao.SampleDao;
import com.demo1.model.FileInfo;
import com.demo1.util.PaginationUtil;


@Service
public class SampleService {
    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    @Autowired
    SampleDao sampleDao;
    /*
     * 우선 인터페이스를 작성하지 않고 진행 .. 추후 협의 TBD 그렇게 하는겁니다. 맞아요.
     1 서비스 코드 샘플입니다.
     2 서비스 코드 작성시 익셉션을 던져 주세요 throws Exception{
     */
    private static final Logger logger = LoggerFactory.getLogger(SampleService.class);
    //요놈은 공통에 만들 예정 TBD ....
    public FileInfo getFileInfo(FileInfo fileInfo) throws Exception{
        fileInfo.setPath("/");
        fileInfo.setFileName("text.txt");
        return fileInfo;
    }

    public List<Object> selectTB_SAMPLE(Map<String,Object> param) throws Exception{
        List<Object> list = sampleDao.selectTB_SAMPLE(param);
        logger.info("param ", param);
        return list;
    }

    public List<Object> selectTB_SAMPLE2(Map<String,Object> param) throws Exception{
        param.put("column1", "column1");
        param.put("column2", "column2");
        param.put("column3", "column3");
        param.put("column4", "column4");
        param.put("test1", "column5");
        PaginationUtil.setPage(param); //페이징 처리시 해당 코드 삽입
        logger.info("param --- > %s" , param);

        List<Object> list = sampleDao.selectTB_SAMPLE(param);
        List<Object> list2 = sampleDao.selectTB_SAMPLE2(param);
        List<Object> list3 = sampleDao.selectTB_SAMPLE3(param);
        return list3;
    }


    public void insertTEST(Map<String,Object> param) throws Exception{
        param.put("column1", "column1");
        param.put("column2", "column2");
        param.put("column3", "column3");
        param.put("column4", "column4");
        param.put("test1", "column5");
        sampleDao.insertTEST(param);
        sampleDao.insertTEST(param);
    }

    public void insertTEST2(Map<String,Object> param) throws Exception{
        Map<String,Object> obj1 = new HashMap<String,Object>();
        Map<String,Object> obj2 = new HashMap<String,Object>();
        obj1.put("column1", "column1");
        obj1.put("column2", "column2");
        obj2.put("column3", "column3");
        obj2.put("column4", "column4");
        obj2.put("test1", "column5222222222");
        sampleDao.insertTEST2(obj1,obj2);
    }




}
