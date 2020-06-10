package com.demo1.biz.quiz.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.demo1.biz.quiz.service.QuizService;



/**
 * <pre>
 * SpringModule (After JDK 11)
 * 1. 클래스명 : QuizController.java
 * 2. 작성일 : 2020. 6. 10.
 * 3. 작성자 : 정훈
 * 4. 설명 : 퀴즈 컨트롤러
 * </pre>
 */
@Controller
public class QuizController {


    private static final Logger logger = LoggerFactory.getLogger(QuizController.class);

    @Autowired
    QuizService quizServiceImpl;

    /**
     * <pre>
     * 1. 메소드명 : viewQuiz
     * 2. 작성일 : 2020. 6. 10. 오전 11:21:05
     * 3. 작성자 : manba
     * 4. 설명 : Quiz 목록을 보여준다.
     * </pre>
     * @param param
     * @param modelMap
     * @return String
     * @throws Exception
     */
    @RequestMapping("/viewQuiz")
    public String viewQuiz(@RequestParam Map<String , Object> param , ModelMap modelMap) throws Exception{
        logger.debug("viewQuiz param >>>>>>  {}", param);
        List<Object> list = quizServiceImpl.selectTbQuizList(param);
        modelMap.addAttribute("list", list);
        return "demo1.biz.quiz.quiz"; //타일즈 뷰
    }

    @RequestMapping("/viewInsertQuiz")
    public String viewQuizInsert(@RequestParam Map<String , Object> param , ModelMap modelMap) throws Exception{
        logger.debug("viewInsertQuiz param >>>>>>  {}", param);
        return "demo1.biz.quiz.insertQuiz"; //타일즈 뷰
    }

    @RequestMapping("/insertQuiz")
    public String insertQuiz(@RequestParam Map<String , Object> param , ModelMap modelMap) throws Exception{
        logger.debug("insertQuiz param >>>>>>  {}", param);
        int inserCount = quizServiceImpl.insertTbQuiz(param);
        //TODO AJAX 구현후 바꾸면됨
//        List<Object> list = quizServiceImpl.selectTbQuizList(param);
//        modelMap.addAttribute("list", list);
        return "redirect:/viewQuiz";
    }

}
