package com.demo1.biz.quiz.service;

import java.util.List;
import java.util.Map;

public interface QuizService {
    public List<Object> selectTbQuizList(Map<String, Object> paramMap) throws Exception;
    public int insertTbQuiz(Map<String, Object> paramMap) throws Exception;
}
