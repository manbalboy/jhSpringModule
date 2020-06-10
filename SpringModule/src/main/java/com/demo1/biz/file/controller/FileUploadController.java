package com.demo1.biz.file.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileUploadController {
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public String upload(@RequestParam("file") MultipartFile multipartFile) {
        // Save mediaFile on system
           if (!multipartFile.getOriginalFilename().isEmpty()) {
               try {
                String sPath = "D:/upload/test";
                //폴더생성
                File fPath  = new File(sPath);
                fPath.mkdirs();
                multipartFile.transferTo(new File(sPath, multipartFile.getOriginalFilename()));
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
               System.out.println("File uploaded successfully.");
           } else {
               System.out.println( "Please select a valid mediaFile..");
           }
        return "redirect:/viewTestFile";
    }
}
