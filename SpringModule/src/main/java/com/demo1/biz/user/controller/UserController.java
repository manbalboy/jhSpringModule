package com.demo1.biz.user.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {
    @GetMapping("/login")
    public String login(HttpServletResponse res)throws Exception{
        System.out.println("test>>>>>>>>>>>>>>>" + res);
        return "demo1/common/login";
    }
    @GetMapping("/logout")
    public String logout()throws Exception{
        System.out.println("logout>>>>>>>>>>>>>>>");
        return "demo1/common/logout";
    }
}
