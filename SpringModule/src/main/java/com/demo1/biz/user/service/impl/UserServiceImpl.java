package com.demo1.biz.user.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.demo1.biz.member.dao.MemberManagementDAO;
import com.demo1.biz.user.dao.UserDao;
import com.demo1.biz.user.service.UserService;
import com.util.CamelMap;

@Service
public class UserServiceImpl implements UserDetailsService, UserService{

    @Autowired
    UserDao userDao;

    @Autowired
    MemberManagementDAO memberManagementDAO;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        System.out.println("username >>>>> "+username);
        Map<String, Object> paramMap = new HashMap<String, Object>();
        Map returnMap = new CamelMap();
        paramMap.put("memberId", username);
        try {
            returnMap = selectUserloginInfo(paramMap);
            if(returnMap.get("password") == null) {
                throw new UsernameNotFoundException(username);
            }


        } catch (Exception e) {
            e.printStackTrace();
        }


        return User.builder()
                .username(returnMap.get("memberId").toString())
                .password("{bcypt}"+returnMap.get("password").toString())
                .roles("MANAGER")
                .build();
    }

    @Override
    public Map selectUserloginInfo(Map<String, Object> paramMap) throws Exception {
        System.out.println("selectUserloginInfo>>>>>>>>>>>>>");
        Map retrunMap = new CamelMap();
        retrunMap = memberManagementDAO.selectMemberLogin(paramMap);
        return retrunMap;
    }

}
