package com.demo1.controller;

import java.io.BufferedReader;
import java.security.Principal;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class DemoController {
    @Autowired
    SqlSessionTemplate sqlSessionTemplate;
    @GetMapping("/home")
    public String showHome(Model model, Principal principal) {
        System.out.println("principal >>>>>> "+ principal);
        model.addAttribute("test", "home");
        HashMap<String, Object> map = new HashMap<String, Object>();

        map.put("TEST1", "fdsa");
        List<HashMap> list =  sqlSessionTemplate.selectList("test.test",map);
        model.addAttribute("list", list);

        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        System.out.println(user.getUsername());



        return "home";
    }

    @RequestMapping(value="/home1", method = {RequestMethod.GET, RequestMethod.POST})
    public String showHome1(HttpServletRequest request) {
        Map <String,Object>  map1 = new HashMap<String, Object>();
        try {
            map1=  setMap(request);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        List<Map> test = (List<Map>)map1.get("dog");
        System.out.println(map1);
        if(test  != null) {
            for(int i=0; i < test.size(); i++) {
                Map param = (Map) test.get(i);
                System.out.println(param);
            }
            System.out.println(map1.get("dog"));
        }
        return "home";
    }


    public Map<String,Object> setMap(HttpServletRequest request) throws Exception {

        Map map = new HashMap();

        try {

            String sMethod = request.getMethod();

            Enumeration<?> names = request.getParameterNames();

            // Post 방식으로 넘어온 파라메터만 셋팅
            int iValuesLng = 0;
            String value = null;
            String req = request.getCharacterEncoding();
            String name = null;
            String[] values = null;

            if(req == null){
                req = "";
            }

        String strReqContentType = request.getContentType();

        if (sMethod != null) {

            if(strReqContentType != null && strReqContentType.indexOf("application/json") > -1) {

                BufferedReader br = request.getReader();
                StringBuffer sb = new StringBuffer();
                String strLine = null;

                while((strLine = br.readLine()) != null) {
                    sb.append(strLine);
                }

                br.close();

                ObjectMapper om = new ObjectMapper();
                Map mapJson = om.readValue(sb.toString(), Map.class);
                map.putAll(mapJson);
            }
            else {

                    while (names.hasMoreElements()) {

                        name = (String) names.nextElement();

                        values = request.getParameterValues(name);

                        if (values != null && values.length > 1) {

                            iValuesLng = values.length;

                            //utf-8이 아닐경우 utf-8로 변환
                            if(!req.equals("UTF-8")){
                                for(int i=0;i<iValuesLng;i++){
                                    values[i] = getCharSet(values[i], "8859_1", "UTF-8");
                                }
                            }
                            map.put(name, values);
                        } else {
                            //utf-8이 아닐경우 utf-8로 변환
                            if(!req.equals("UTF-8")){
                                value = getCharSet(request.getParameter(name), "8859_1", "UTF-8");
                            }else{
                                value = request.getParameter(name);
                            }

                            map.put(name, value);
                        }


                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

    public String getCharSet(String sText, String fromCharSet, String toCharSet) {
        String sResult = null;
        try {
            if(sText == null) return sResult;
            sResult = new String(sText.getBytes(fromCharSet),toCharSet);
            return sResult;
        }catch(Exception e) {
            return "";
        }
    }









    // add request mapping for /leaders

    @GetMapping("/leaders")
    public String showLeaders() {

        return "leaders";
    }

    // add request mapping for /systems

    @GetMapping("/systems")
    public String showSystems() {

        return "systems";
    }
}
