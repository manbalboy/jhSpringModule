package com.demo1.biz.sourcemaker.contorller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class SourceMaker {
    @RequestMapping(value="sourceMaker" , method = RequestMethod.GET)
    public String sourceMaker()throws Exception{
        return "pages/sourceMaker";
    }


    @RequestMapping(value="sourceMakerContent")
    public String sourceMakerContent()throws Exception{
        System.out.println(">>>>>>>sourceMakerContent");
        return "demo1/sourceMaker/sourceMakerContent";
    }

    @RequestMapping(value="sourceMakerFile")
    public String sourceMakerFile()throws Exception{
        System.out.println(">>>>>>>sourceMakerFile");
        return "demo1/sourceMaker/sourceMakerFile";
    }
}
