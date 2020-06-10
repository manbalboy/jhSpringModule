package com.demo1.biz.pse.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.demo1.biz.pse.service.PseService;

@Controller
@RequestMapping("/demo1/pse")
public class PseController {

    @Autowired
    PseService pseService;

    private static final Logger logger = LoggerFactory.getLogger(PseController.class);

    /*
     * 20.06.10
     * 서은's 데일리 다이어리 리스트 조회
     */
    @RequestMapping("/dailyDiaryList")
    public String dailyDiaryList(@RequestParam Map<String , Object> param
            , ModelMap model) throws Exception {

        //페이징 처리 X
        List<Object> list = pseService.selectPSE_DAILYDIARY(param);

        logger.info("dailyDiaryList >>>>>>>>>> ", list);

        model.addAttribute("list", list);

        //return "/demo1/biz/pse/DailyDiaryList"; //타일즈 X
        //return "demo1.pse.dailyDiaryList";
        return "demo1.biz.pse.dailyDiaryList";
    }

    /*
     * 20.06.10
     * 서은's 데일리 다이어리 상세보기
     */
    @RequestMapping("/dailyDiaryView")
    public String dailyDiaryView(@RequestParam Map<String , Object> param
            , ModelMap model) throws Exception {

        //페이징 처리 X
        List<Object> list = pseService.selectPSE_DAILYDIARY(param);

        logger.info("dailyDiaryList >>>>>>>>>> ", list);

        model.addAttribute("list", list);

        //return "/demo1/biz/pse/DailyDiaryList"; //타일즈 X
        //return "demo1.pse.dailyDiaryList";
        return "demo1.biz.pse.dailyDiaryView";
    }
}
