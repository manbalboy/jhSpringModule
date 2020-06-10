package com.demo1.biz.csg.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.demo1.biz.csg.service.CsgService;


@Controller
@RequestMapping("/demo1/csg")
public class CsgController {

    @Autowired
    CsgService csgService;

    private static final Logger logger = LoggerFactory.getLogger(CsgController.class);

    @RequestMapping("/todoList")
    public String sample1(@RequestParam Map<String , Object> param , ModelMap modelMap) throws Exception{
         List<Object> list = csgService.selectDemo1CsgGrowupTodoList(param);
         modelMap.addAttribute("list", list);
        return "demo1.csg.todoList"; //타일즈 뷰
    }

    @RequestMapping("/todoListPaging")
    public String todoListPaging(@RequestParam Map<String , Object> param , ModelMap modelMap) throws Exception{
        logger.info("logger.info");
        List<Object> list = csgService.selectDemo1CsgGrowupTodoList(param);
        modelMap.addAttribute("list", list);
        return "demo1/biz/csg/todoListPaging"; //타일즈 없이 화면뷰
    }
}
