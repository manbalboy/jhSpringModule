package com.demo1.biz.quiz.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;

import com.demo1.biz.quiz.dao.QuizDao;
import com.demo1.biz.quiz.service.QuizService;

/**
 * <pre>
 * SpringModule (After JDK 11)
 * 1. 클래스명 : QuizServiceImpl.java
 * 2. 작성일 : 2020. 6. 10.
 * 3. 작성자 : 정훈
 * 4. 설명 : Quiz 비즈니스 로직 구현체
 * </pre>
 */
@Service
public class QuizServiceImpl implements QuizService{
    @Autowired
    QuizDao quizDao;

    @Override
    public List<Object> selectTbQuizList(Map<String, Object> paramMap) throws Exception {
         List<Object> retrunMap = quizDao.selectTbQuizList(paramMap);
         return retrunMap;
    }

    @Override
    public int insertTbQuiz(Map<String, Object> paramMap) throws Exception {
        //TODO 사용자정보 세션에서 가져와야하는걸로 바꿔야함
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        System.out.println(user.getUsername());
        paramMap.put("WRITER_ID", user.getUsername());
        paramMap.put("REGISTER_ID", user.getUsername());
        paramMap.put("UPDATE_USER_ID", user.getUsername());


        return quizDao.insertTbQuiz(paramMap);
    }
}
