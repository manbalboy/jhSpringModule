package com.demo1.controller;

import java.security.Principal;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

/**
 * <pre>
 * SpringModule (After JDK 11)
 * 1. 클래스명 : GlobalContoller.java
 * 2. 작성일 : 2020. 6. 11.
 * 3. 작성자 :  정훈
 * 4. 설명 : 글로벌 컨트롤러 전역에서 사용할 모델이나 세션 이셉션을 설정하면 전역에 영향을 준다.
 * </pre>
 */
@ControllerAdvice
public class GlobalContoller {
    @ModelAttribute
    public void setUserinfo(Model model, Principal principal) {

        if(principal == null) {
            System.out.println(">>>>>>>>>>> nonono ");

        } else {
               User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
               System.out.println(user.getUsername());
               model.addAttribute("userId", (String)user.getUsername());
        }

    }
}
