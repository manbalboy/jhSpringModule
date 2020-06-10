package com.demo1.biz.user.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.demo1.biz.user.dao.UserDao;
import com.demo1.biz.user.service.UserService;

@Service
public class UserServiceImpl implements UserDetailsService, UserService{

    @Autowired
    UserDao userDao;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        System.out.println("username >>>>> "+username);
        Map<String, Object> paramMap = new HashMap<String, Object>();
        Map<String, Object> returnMap = new HashMap<String, Object>();
        paramMap.put("userId", username);
        try {
            returnMap = selectUserloginInfo(paramMap);
            if(returnMap.get("USER_PASSWORD") == null) {
                throw new UsernameNotFoundException(username);
            }


        } catch (Exception e) {
            e.printStackTrace();
        }


        return User.builder()
                .username(returnMap.get("USER_ID").toString())
                .password("{noop}"+returnMap.get("USER_PASSWORD").toString())
                .roles(returnMap.get("USER_AUTHORITY").toString())
                .build();
    }

    @Override
    public Map<String, Object> selectUserloginInfo(Map<String, Object> paramMap) throws Exception {
        System.out.println("selectUserloginInfo>>>>>>>>>>>>>");
        Map<String, Object> retrunMap = new HashMap<String, Object>();
        retrunMap = userDao.selectTbUserLogin(paramMap);
        return retrunMap;
    }

}
