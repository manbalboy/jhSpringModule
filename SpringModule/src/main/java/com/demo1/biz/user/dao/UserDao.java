package com.demo1.biz.user.dao;

import java.util.List;
import java.util.Map;

public interface UserDao {
    public List<Object> selectTbUserLoginList(Object obj);
    public Map<String, Object> selectTbUserLogin(Object obj);
}
