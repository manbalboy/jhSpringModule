package com.demo1.biz.jh.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.util.CamelMap;

/**
 * 소스 개발하는데 도우미
 * <p>
 * <수정이력> <br />
 * 1. 수정일: 수정자: 수정사유: <br />
 * <p>
 * @since 2020. 6. 15.
 * @version 1.0
 * @author 정훈
 */
@Controller
@RequestMapping(value="sourceMakerHelper")
public class SourceMakerHelperController {


    @RequestMapping(value="viewSourceMaker")
    public String sourceMaker()throws Exception{
        return "demo1.biz.source.sourceMakerHelper";
    }

    @RequestMapping(value="tableListAjax")
    public Map tableListAjax(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
        CamelMap convertMap = new CamelMap();
        Map paramMap = convertMap.setMap(request);


        String id = paramMap.get("dbId").toString();
        String pw = paramMap.get("dbPw").toString();
        String url = paramMap.get("dbURL").toString();
        String sql = "";

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName(paramMap.get("className").toString());
            System.out.println("id:"+id+", pw: "+pw);
            con = DriverManager.getConnection(url,id,pw);

            //sql = "SELECT T1.TABLE_NAME, T1.NUM_ROWS, T2.COMMENTS FROM USER_TABLES T1 INNER JOIN USER_TAB_COMMENTS T2 ON T1.TABLE_NAME = T2.TABLE_NAME AND T1.TABLE_LOCK = 'ENABLED'";
            sql = "SELECT T1.TABLE_NAME FROM USER_TABLES T1 WHERE 1=1 AND T1.TABLE_LOCK = 'ENABLED'";

            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            paramMap.clear();

            List list = new ArrayList();
            while (rs.next()) {
                Map rsMap = new HashedMap();
                rsMap.put("tableName", rs.getString("TABLE_NAME"));
                list.add(rsMap);
            };


            paramMap.put("tableList", list);

        } catch (Exception e) {
            System.out.println(e);
            e.printStackTrace();
            paramMap.put("success","fail");
            return paramMap;
        } finally {
            try {rs.close();} catch(Exception e) {}
            try {pstmt.close();} catch(Exception e) {}
            con.close();
        }

        paramMap.put("success","success");


        return paramMap;
    }

    @RequestMapping(value="viewSourceMakerContent")
    public String viewSourceMakerContent(HttpServletRequest request, HttpServletResponse response, ModelMap model, @RequestParam Map reqParamMap)throws Exception{
        CamelMap convertMap = new CamelMap();
        Map paramMap = convertMap.setMap(request);


        String id = paramMap.get("dbId").toString();
        String pw = paramMap.get("dbPw").toString();
        String url = paramMap.get("dbURL").toString();
        String sql = "";

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName(paramMap.get("className").toString());
            con = DriverManager.getConnection(url,id,pw);

            sql = "SELECT COL  , LOWER(col) LOWER_COL"
                + ", '#{' || LOWER(SUBSTR(REPLACE(INITCAP(COL),'_',''), 0, 1)) || SUBSTR(REPLACE(INITCAP(COL),'_',''), 2) ||'}' AS MYBATISFROM"
                + ", '${' || LOWER(SUBSTR(REPLACE(INITCAP(COL),'_',''), 0, 1)) || SUBSTR(REPLACE(INITCAP(COL),'_',''), 2) ||'}' AS MYBATISFROM2  "
                + ", '/* '||COL_NAME||' */' AS XMLCOMMENT  "
                + ",  MAX(LENGTH (TRIM(NO_UNDER_LINE_COL))) OVER()AS MAX_NO_LINE_COL_LENGTH "
                + ",  MAX(LENGTH (TRIM(COL))) OVER()AS MAX_COL_LENGTH "
                + ",  MAX(LENGTH (TRIM(COL_NAME))) OVER() AS MAX_COL_NAME_LENGTH "
                + ",  MAX(LENGTH (TRIM(DATA_TYPE))) OVER() AS MAX_DATA_TYPE_LENGTH "
                + ", LENGTH (TRIM(NO_UNDER_LINE_COL)) AS NO_LINE_COL_LENGTH "
                + ", LENGTH (TRIM(COL)) AS COL_LENGTH "
                + ", LENGTH (TRIM(COL_NAME))  AS COL_NAME_LENGTH"
                + ", LENGTH (TRIM(DATA_TYPE)) AS DATA_TYPE_LENGTH"


                + ", LOWER(SUBSTR(REPLACE(INITCAP(COL),'_',''), 0, 1)) || SUBSTR(REPLACE(INITCAP(COL),'_',''), 2) AS CAMEL  "
                + ", NULLABLE , DATA_TYPE , DATA_LENGTH, DATA_DEFAULT ,TAB, TAB_NAME, COL_SEQ , COL_NAME, NO_UNDER_LINE_COL "
                + "FROM (  "
                + " SELECT A.TABLE_NAME  TAB, "
                + "   B.COMMENTS  TAB_NAME,"
                + "   REPLACE(A.COLUMN_NAME,'_','') AS NO_UNDER_LINE_COL,"
                + "   A.COLUMN_ID COL_SEQ,"
                + "  A.COLUMN_NAME COL,"
                + "  C.COMMENTS COL_NAME,"
                + "  A.DATA_TYPE ||"
                + "  DECODE(A.DATA_TYPE, 'DATE', '',"
                + "  DECODE(A.DATA_TYPE,'NUMBER',"
                + "  DECODE(DATA_SCALE,0,'(' || DATA_PRECISION || ')','(' ||"
                + "  DATA_PRECISION || ',' || DATA_SCALE || ')'),'(' || DATA_LENGTH || ')') ) DATA_TYPE,"
                + "  DECODE(A.DATA_TYPE, 'DATE', '', DECODE(A.DATA_TYPE,'NUMBER', A.DATA_PRECISION, DECODE(A.DATA_TYPE,'CLOB', '' ,DATA_LENGTH )))  DATA_LENGTH,"
                + "  DECODE(A.NULLABLE,'Y','','required') NULLABLE,"
                + "  D.COLUMN_POSITION,"
                + "  A.DATA_DEFAULT"
                + " FROM USER_TAB_COLUMNS A, "
                + "  USER_TAB_COMMENTS B,"
                + "  USER_COL_COMMENTS C,"
                + "  USER_IND_COLUMNS D"
                + "  WHERE A.TABLE_NAME = B.TABLE_NAME"
                + "  AND A.TABLE_NAME = C.TABLE_NAME"
                + "  AND A.COLUMN_NAME = C.COLUMN_NAME"
                + "  AND A.TABLE_NAME =D.TABLE_NAME(+)"
                + "  AND A.COLUMN_NAME =D.COLUMN_NAME(+)"
                + "  AND A.TABLE_NAME = ?"
                + "  ORDER BY 1, 3"
                + " ) "
                + " ORDER BY COL_SEQ ";



            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, paramMap.get("tableName").toString());
            rs = pstmt.executeQuery();


            List list = new ArrayList();
            while (rs.next()) {
                Map rsMap = new HashedMap();
                rsMap.put("col", rs.getString("COL"));
                rsMap.put("colName", rs.getString("COL_NAME"));
                rsMap.put("lowerCol", rs.getString("LOWER_COL"));
                rsMap.put("mybatisForm", rs.getString("MYBATISFROM"));
                rsMap.put("mybatisForm2", rs.getString("MYBATISFROM2"));
                rsMap.put("xmlComment", rs.getString("XMLCOMMENT"));
                rsMap.put("camel", rs.getString("CAMEL"));
                rsMap.put("nullable", rs.getString("NULLABLE"));
                rsMap.put("dataType", rs.getString("DATA_TYPE"));
                rsMap.put("dataLength", rs.getString("DATA_LENGTH"));
                rsMap.put("dataDefault", rs.getString("DATA_DEFAULT"));
                rsMap.put("tab", rs.getString("tab"));
                rsMap.put("tabName", rs.getString("TAB_NAME"));
                rsMap.put("colSeq", rs.getString("COL_SEQ"));
                rsMap.put("noUnderLineCol", rs.getString("NO_UNDER_LINE_COL"));

                rsMap.put("maxColLength", rs.getInt("MAX_COL_LENGTH"));
                rsMap.put("maxColNameLength", rs.getInt("MAX_COL_NAME_LENGTH"));
                rsMap.put("maxDataTypeLength", rs.getInt("MAX_DATA_TYPE_LENGTH"));
                rsMap.put("colLength", rs.getInt("COL_LENGTH"));
                rsMap.put("colNameLength", rs.getInt("COL_NAME_LENGTH"));
                rsMap.put("dataTypeLength", rs.getInt("DATA_TYPE_LENGTH"));
                rsMap.put("maxNoLineColLength", rs.getInt("MAX_NO_LINE_COL_LENGTH"));
                rsMap.put("noLineColLength", rs.getInt("NO_LINE_COL_LENGTH"));
                list.add(rsMap);
            };


            paramMap.put("tableList", list);

        } catch (Exception e) {
            System.out.println(e);
            e.printStackTrace();
            paramMap.put("success","fail");
        } finally {
            try {rs.close();} catch(Exception e) {}
            try {pstmt.close();} catch(Exception e) {}
            con.close();
        }

        paramMap.put("success","success");
        String json = new ObjectMapper().writeValueAsString(paramMap);

        model.addAttribute("content", paramMap);
        model.addAttribute("jsonModel", json);


        return "demo1/biz/source/sourceMakerContent";
    }
}
