package com.demo1.biz.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {
    @GetMapping("/login")
    public String login()throws Exception{
        System.out.println("test>>>>>>>>>>>>>>>");
        return "demo1/common/login";
    }
    @GetMapping("/logout")
    public String logout()throws Exception{
        System.out.println("logout>>>>>>>>>>>>>>>");
        return "demo1/common/logout";
    }
}
