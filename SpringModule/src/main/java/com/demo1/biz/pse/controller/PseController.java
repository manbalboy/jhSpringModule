package com.demo1.biz.pse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.demo1.biz.pse.service.PseService;

@Controller
@RequestMapping("/demo1/pse")
public class PseController {

    @Autowired
    PseService pseService;

    private static final Logger logger = LoggerFactory.getLogger(PseController.class);

    /*
     * 20.06.10
     * 서은's 데일리 다이어리 리스트 조회 View
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
     * 서은's 데일리 다이어리 상세보기 View
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

    /*
     * 20.06.11
     * 서은's 데일리 다이어리 작성 View
     */
    @RequestMapping("/dailyDiaryWrite")
    public String dailyDiaryWrite(@RequestParam Map<String , Object> param
            , ModelMap model) throws Exception {

        return "demo1.biz.pse.dailyDiaryWrite";
    }

    /*
     * 20.06.11
     * 서은's 데일리 다이어리 작성 Action
     */
    @RequestMapping("/dailyDiaryWriteAction")
    public String dailyDiaryWriteAction(@RequestParam Map<String , Object> param
            , ModelMap model) throws Exception {

        int iCnt = pseService.insertPSE_DAILYDIARY(param);

        logger.info("다이어리 등록 >>>>>>>>>> iCnt : ", iCnt);

        return "redirect:./dailyDiaryList";
    }

    /*
     * 20.06.11
     * 서은's 데일리 다이어리 수정 AJAX
     */
    @RequestMapping("/dailyDiaryUpdate")
    @ResponseBody
    public Map<String, Object> dailyDiaryUpdate(@RequestParam Map<String , Object> param
            , ModelMap model) throws Exception {


        System.out.println("param >>>>>>" + param);

        Map<String , Object> returnMap = new HashMap<String , Object>();

        int iCnt = pseService.updatePSE_DAILYDIARY(param);

        logger.info("다이어리 수정 >>>>>>>>>> iCnt : ", iCnt);

        returnMap.put("success", iCnt);

        return returnMap;
    }

    /*
     * 20.06.11
     * 서은's 데일리 다이어리 삭제 AJAX
     */
    @RequestMapping("/dailyDiaryDelete")
    @ResponseBody
    public Map<String, Object> dailyDiaryDelete(@RequestParam Map<String , Object> param
            , ModelMap model) throws Exception {


        System.out.println("param >>>>>>" + param);

        Map<String , Object> returnMap = new HashMap<String , Object>();

        int iCnt = pseService.deletePSE_DAILYDIARY(param);

        logger.info("다이어리 삭제 >>>>>>>>>> iCnt : ", iCnt);

        returnMap.put("success", iCnt);

        return returnMap;
    }

}
