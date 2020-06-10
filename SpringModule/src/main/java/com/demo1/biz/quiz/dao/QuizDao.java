package com.demo1.biz.quiz.dao;

import java.util.List;

public interface QuizDao {
    public List<Object> selectTbQuizList(Object obj);

    public int insertTbQuiz(Object obj);
}
