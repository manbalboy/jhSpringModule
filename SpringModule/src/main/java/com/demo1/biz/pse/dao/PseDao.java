package com.demo1.biz.pse.dao;

import java.util.List;

public interface PseDao {

    /*
     * 20.06.10
     * 서은's 데일리 다이어리 리스트 조회
     */
    public List<Object> selectPSE_DAILYDIARY(Object obj);
}
