package com.demo1.biz.jh.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestFileUploadController {
    @RequestMapping(value = "/viewTestFile")
    public String viewTestFile() {
        return  "demo1.biz.jh.testFile"; //타일즈 뷰;
    }
}
