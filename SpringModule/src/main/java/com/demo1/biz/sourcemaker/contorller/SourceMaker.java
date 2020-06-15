package com.demo1.biz.sourcemaker.contorller;

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
import org.springframework.web.bind.annotation.RequestMethod;

import com.util.CamelMap;

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

    @RequestMapping(value="sourceMaker/tableListAjax")
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
}
