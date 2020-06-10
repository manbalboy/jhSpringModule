package com.demo1.biz.sample.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface SampleDao {
    /*
    사용법 설명
     1 /SpringModule/src/main/resources/mybatis/mappers 하위 폴더에 매퍼를 작성 한다.
     2 mapper namespace는 패키지.인터페이스파일명 ex) com.demo1.biz.dao.sample.SampleDao
     3 mapper 쿼리는 접두어 select{} , insert{} , update{} , delete{} 를 사용한다
     4.1 3내용중 {} 부분은 단일 테이블 일경우 대문자 테이블명 ex) .selectTB_SAMPLE
     4.2 조인이 걸려 있는경우 select{} 불라불라 - selectMain 기타등

     5 인터페이스 매소드 명과 매퍼 id를 동일 하게 만든다.(실행규칙입니다.)

     샘플입니다.
     매퍼 인터페이스 입력 파라미터 샘플을 만든다.(수정 가능!)
    매퍼 네임스페이스에 대한 설명 :

     */
    public List<Object> selectTB_SAMPLE(Object obj);

    public List<Object> selectTB_SAMPLE2(Object obj);
    public List<Object> selectTB_SAMPLE3(Object obj);


    int insertTEST(Object obj);


    /*public interface UserMapper {
       @Select("SELECT id, name FROM users WHERE name = #{name}")
       User selectById(@Param("name") String value);
     }*/
    int insertTEST2(@Param("obj") Object obj,@Param("obj2")Object obj2);

}
