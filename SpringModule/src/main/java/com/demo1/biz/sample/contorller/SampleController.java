package com.demo1.biz.sample.contorller;

import java.util.List;
import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import com.demo1.biz.sample.service.SampleService;
import com.demo1.model.FileInfo;
import com.demo1.model.Pizza;



@Controller
@RequestMapping("/demo1/sample")
public class SampleController {

    /*
     * url 네이밍은 정해지지 않음  TBD
     * 메소드 명은 반드시 마지막 패스명으로 작성
     * 마지막 패스가 패스 파람일경우 메소드 명은 list , info로 한다.
     *
     */
    @Autowired
    SampleService sampleService;

    private static final Logger logger = LoggerFactory.getLogger(SampleController.class);

    //야는 모르겄습니다. downloadView , downloadViewResolver 두개다 되는디 이걸 알아내야 합니다.
    //com.config.AppConfig 에 @Bean 으로 등록 했음 빈내임이 어떻게 생기는지
    @Autowired
    private View downloadView;

    @RequestMapping("/sampleDownload")
    public ModelAndView sampleDownload(FileInfo fileInfo , ModelMap modelMap) throws Exception{
        FileInfo result = sampleService.getFileInfo(fileInfo);
        modelMap.put("fileInfo", result);
        return new ModelAndView(this.downloadView, modelMap);
    }

    @RequestMapping("/sample1")
    public String sample1(@RequestParam Map<String , Object> param , ModelMap modelMap) throws Exception{
        logger.debug("logger.debug");
        logger.info("logger.info");
        logger.error("logger.error");
        logger.info("logger.info");
        List<Object> list = sampleService.selectTB_SAMPLE(param);
        List<Object> list2 = sampleService.selectTB_SAMPLE2(param);

        sampleService.insertTEST(param);
        sampleService.insertTEST2(param);

        modelMap.addAttribute("list", list);
        modelMap.addAttribute("list2", list2);

        return "demo1.sample.sample1"; //타일즈 뷰
    }

    @RequestMapping("/sample2")
    public String sample2(@RequestParam Map<String , Object> param , ModelMap modelMap) throws Exception{
        logger.info("logger.info");
        List<Object> list2 = sampleService.selectTB_SAMPLE2(param);
        modelMap.addAttribute("list2", list2);

        return "demo1/sample/sample2"; //타일즈 없이 화면뷰
    }

    //파라미터 콘트롤러 학습
    @RequestMapping(value="/sample3/{info}", method = RequestMethod.GET) //gubun은 임의 정의 화면을 각기 다르게 제작 하지 않는 것을 추천
	public String getPizza(@PathVariable String info,Model model) {


		model.addAttribute("info", "info");

		return "pizza";

	}



}
