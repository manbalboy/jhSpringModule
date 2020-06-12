package com.demo1.biz.pse.dao;

import java.util.List;

public interface PseDao {

    /*
     * 20.06.10
     * 서은's 데일리 다이어리 리스트 조회
     */
    public List<Object> selectPSE_DAILYDIARY(Object obj);

    /*
     * 20.06.11
     * 서은's 데일리 다이어리 등록
     */
    public int insertPSE_DAILYDIARY(Object obj);

    /*
     * 20.06.12
     * 서은's 데일리 다이어리 수정
     */
    public int updatePSE_DAILYDIARY(Object obj);

    /*
     * 20.06.12
     * 서은's 데일리 다이어리 삭제
     */
    public int deletePSE_DAILYDIARY(Object obj);
}
