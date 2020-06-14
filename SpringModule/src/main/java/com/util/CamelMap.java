package com.util;

import java.io.BufferedReader;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.jdbc.support.JdbcUtils;

import com.fasterxml.jackson.databind.ObjectMapper;

public class CamelMap extends HashMap {
    private static final long serialVersionUID = -7700790403928325865L;

    @SuppressWarnings("unchecked")
    @Override
    public Object put(Object key, Object value) {
        return super.put( JdbcUtils.convertUnderscoreNameToPropertyName((String)key), value);
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
}
