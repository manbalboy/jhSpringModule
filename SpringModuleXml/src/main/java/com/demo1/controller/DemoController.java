package com.demo1.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DemoController {
    @Autowired
    SqlSessionTemplate sqlSessionTemplate;
    @GetMapping("/home")
    public String showHome(Model model, Principal principal) {


        System.out.println("principal >>>>>> "+ principal);
        model.addAttribute("test", "home");
        HashMap<String, Object> map = new HashMap<String, Object>();

        map.put("TEST1", "column5222222222");
        List<HashMap> list =  sqlSessionTemplate.selectList("test.test",map);

        System.out.println(list.toString());
        model.addAttribute("list", list);
        return "home";
    }

    // add request mapping for /leaders

    @GetMapping("/leaders")
    public String showLeaders() {

        return "leaders";
    }

    // add request mapping for /systems

    @GetMapping("/systems")
    public String showSystems() {

        return "systems";
    }
}
