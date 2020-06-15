<!-- Import Reference Class -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat,java.util.Date" %>
<%
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;


    String id = request.getParameter("dbId");
    String pw = request.getParameter("dbPw");
    String url = request.getParameter("dbURL");
    String sql = "";

    int cntKey = 0; // PRIMARY KEY의 갯수늘리기
    int cnt = 0; // DAO 컬럼작성갯수를 지정하여 사용
    String strKey = ""; // pk String 만들기
    String strTableInit = ""; // 테이블Init명
    String strTableLower = ""; // 테이블명 앞에 소문자
    String strTableNameLower = ""; //테이블 전체 소문자
// 	String strTableUpper = ""; // 테이블명 전체 대문자
    String strTableName = ""; // 테이블명
    String strClassLink = ""; // 클래스파일링크
    String strQuery = ""; // DAO 쿼리문 작성용
    String strTableAlias = ""; // 테이블 Alias
    String strTableComments = "";
    String strPriKey = "";	//prikey
    String strColumnName = ""; // 컬럼명 대문자
    int seqCnt = 0; // 시퀀스 존재 여부 확인용 변수(0이 아니면 있는거임)

    String tableName = request.getParameter("tableName");
    String selectType = request.getParameter("selectType");
    //하위패키지
    String classPath = request.getParameter("classPath");
    String tableAlias = request.getParameter("tableAlias");

    String devnm = request.getParameter("devnm");	//작성자
    devnm = new String(devnm.getBytes("8859_1"),"UTF-8");
    String tableNameComment = null;	//업무명한글

    String commonBox = request.getParameter("commonBox");
    String basicClassPath = request.getParameter("basicClassPath");
    //업무클래스명
    String classNm = request.getParameter("classNm");

    String localPath = request.getParameter("localPath");
    String selectPrj = request.getParameter("selectPrj");

%>
<html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script language="javascript">
    function makeFile(){
        document.frmMain.target = "ifrmFile";
        document.frmMain.action = "${pageContext.request.contextPath}/sourceMakerFile";
        document.frmMain.submit();
    }

</script>
</head>
<body style="margin:0">
<form name="frmMain" method=post>
<input type="hidden" id="selectType" name="selectType" value="<%= selectType %>"/>
<input type="hidden" id="basicClassPath" name="basicClassPath" value="<%= basicClassPath %>"/>
<input type="hidden" id="classPath" name="classPath" value="<%= classPath %>"/>
<input type="hidden" id="classNm" name="classNm" value="<%= classNm %>"/>
<input type="hidden" id="localPath" name="localPath" value="<%= localPath %>"/>
<input type="hidden" id="selectPrj" name="selectPrj" value="<%= selectPrj %>"/>
<input type="hidden" id="tableName" name="tableName" value="<%= tableName %>"/>
<table height="99%" width="100%">
    <tr>
        <td width="100%" height="100%">
            <textarea id="source" name="source" style="width:100%;height:100%;line-height:110%;scrolling:yes;">
<%

    if (classPath.equals("")) {
        classPath = "/*  작성 */";
    }

    try {
        Class.forName(request.getParameter("className"));
        con = DriverManager.getConnection(url,id,pw);

        int millisPerHour = 60 * 60 * 1000;
        SimpleDateFormat fmt= new SimpleDateFormat("yyyy.MM.dd");

        // TimeZone timeZone = TimeZone.getTimeZone( "UTC" );
        SimpleTimeZone timeZone = new SimpleTimeZone(9*millisPerHour,"KST");

        fmt.setTimeZone(timeZone);
        String sTimeStr = fmt.format(new Date(System.currentTimeMillis()));
        sql = "SELECT COMMENTS AS DESCRIPTION ";
        sql +="  FROM USER_TAB_COMMENTS ";
        sql +=" WHERE 1=1 AND TABLE_NAME = ? ";

        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, tableName);
        rs = pstmt.executeQuery();

        rs.next();

        tableNameComment = rs.getString("DESCRIPTION");

        try {rs.close();} catch(Exception e) {}

        /* 인터페이스 */
        if (selectType.equals("interface")) {

            sql ="SELECT LOWER(TABLE_NAME) AS TABLE_NAME_LOWER, "
                +"       LOWER(TABLE_NAME) AS TABLE_LOWER, "
                +"       UPPER(TABLE_NAME) AS TABLE_NAME "
                +"  FROM USER_TABLES T1  "
                +" WHERE 1=1 AND T1.TABLE_LOCK = 'ENABLED'  "
                +"   AND TABLE_NAME=? ";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, tableName);
            rs = pstmt.executeQuery();

            if (!rs.next()) return;

            cnt = 0;
            strQuery = "";
            strTableLower = getInitCap(rs.getString("TABLE_LOWER"));

            out.println("package "+basicClassPath+"."+classPath+".service;");
            out.println("");
            out.println("import java.util.HashMap;");
            out.println("import java.util.List;");
            out.println("");
            out.println("/**");
            out.println(" * "+tableNameComment+" 인터페이스");
            out.println(" * <p>");
            out.println(" * <수정이력> <br />");
            out.println(" * 1. 수정일: 수정자: 수정사유: <br />");
            out.println(" * <p>");
            out.println(" * @since "+sTimeStr);
            out.println(" * @version 1.0");
            out.println(" * @author "+devnm);
            out.println(" */");
            out.println("public interface "+classNm+"Service {");
            out.println("");
            out.println("    /**");
            out.println("     * "+tableNameComment+" 조회");
            out.println("     * @since "+sTimeStr);
            out.println("     * @param");
            out.println("     * @return");
            out.println("     * @throws Exception ");
            out.println("     * @discription ");
            out.println("     */");
            out.println("    public Map select"+strTableLower+"(Map paramMap) throws Exception;");
            out.println("");
            out.println("    /**");
            out.println("     * "+tableNameComment+" 상세");
            out.println("     * @since "+sTimeStr);
            out.println("     * @param");
            out.println("     * @return");
            out.println("     * @throws Exception ");
            out.println("     * @discription ");
            out.println("     */");
            out.println("    public Map selectDetail"+strTableLower+"(Map paramMap) throws Exception;");
            out.println("");
            out.println("    /**");
            out.println("     * "+tableNameComment+" 등록");
            out.println("     * @since "+sTimeStr);
            out.println("     * @param");
            out.println("     * @return");
            out.println("     * @throws Exception ");
            out.println("     * @discription ");
            out.println("     */");
            out.println("    public int insert"+strTableLower+"(Map paramMap) throws Exception;");
            out.println("");
            out.println("    /**");
            out.println("     * "+tableNameComment+" 수정");
            out.println("     * @since "+sTimeStr);
            out.println("     * @param");
            out.println("     * @throws Exception ");
            out.println("     * @discription ");
            out.println("     */");
            out.println("    public int update"+strTableLower+"(Map paramMap) throws Exception;");
            out.println("");
            out.println("    /**");
            out.println("     * "+tableNameComment+" 삭제");
            out.println("     * @since "+sTimeStr);
            out.println("     * @param");
            out.println("     * @throws Exception ");
            out.println("     * @discription ");
            out.println("     */");
            out.println("    public Map delete"+strTableLower+"(Map paramMap) throws Exception;");
            out.println("}");
        }
        else if(selectType.equals("Impl")){
            sql ="SELECT LOWER(TABLE_NAME) AS TABLE_NAME_LOWER, "
                +"       LOWER(TABLE_NAME) AS TABLE_LOWER, "
                +"       UPPER(TABLE_NAME) AS TABLE_NAME "
                +"  FROM USER_TABLES T1  "
                +" WHERE 1=1 AND T1.TABLE_LOCK = 'ENABLED'  "
                +"   AND TABLE_NAME=? ";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, tableName);
            rs = pstmt.executeQuery();

            if (!rs.next()) return;

            cnt = 0;
            strQuery = "";
            strTableLower = getInitCap(rs.getString("TABLE_LOWER"));

            String strTableCamel = strTableLower.substring(0, 1).toLowerCase() + strTableLower.substring(1);

            strTableNameLower = rs.getString("TABLE_NAME_LOWER");

            out.println("package "+basicClassPath+"."+classPath+".service.impl;");
            out.println("");
            out.println("import java.util.List;");
            out.println("import javax.annotation.Resource;");
            out.println("");
            out.println("import org.slf4j.Logger;");
            out.println("import org.slf4j.LoggerFactory;");
            out.println("import org.springframework.stereotype.Service;");
            out.println("");
            out.println("import "+commonBox+";");
            out.println("import "+basicClassPath+"."+classPath+".service."+strTableLower+"Service;");
            out.println("");
            out.println("/** ");
            out.println(" * "+tableNameComment+" 인터페이스 구현");
            out.println(" * <p>");
            out.println(" * <수정이력> <br />");
            out.println(" * 1. 수정일: 수정자: 수정사유: <br />");
            out.println(" * <p>");
            out.println(" * @since "+sTimeStr);
            out.println(" * @version 1.0");
            out.println(" * @author "+devnm);
            out.println(" */");
            out.println("@Service(\""+strTableCamel+"Service"+"\")");
            out.println("public class "+strTableLower+"ServiceImpl implements "+strTableLower+"Service{");
            out.println("");
            out.println("     private static final Logger logger = LoggerFactory.getLogger("+classNm+"ServiceImpl.class);");
            out.println("");
            out.println("    /*");
            out.println("     * "+tableNameComment+" 조회");
            out.println("     * @since "+sTimeStr);
            out.println("     * @param map");
            out.println("     * @return");
            out.println("     * @throws Exception");
            out.println("     */");
            out.println("    public Map select"+strTableLower+"(Map paramMap)throws Exception {");
            out.println("");
            out.println("        Map cmapReturn = new Map();");
            out.println("        cmapReturn.put(\"resultCd\", CommConstants.SUCCESS_CODE);");
            out.println("");
            out.println("        //전체 카운트");
            out.println("        int iListTotCnt = (int) commDao.selectByPk(\""+classPath + "."+strTableNameLower+".select_"+strTableNameLower+"_cnt\", paramMap);");
            out.println("");
            out.println("        List<Map> listResult = commDao.selectList(\""+classPath + "."+strTableNameLower+".select_"+strTableNameLower+"\", paramMap);");
            out.println("");
            out.println("        cmapReturn.put(\"listResult\", listResult);");
            out.println("");
            out.println("        return cmapReturn;");
            out.println("    }");
            out.println("");
            out.println("    /*");
            out.println("     * "+tableNameComment+" 상세.");
            out.println("     * @since "+sTimeStr);
            out.println("     * @see "+basicClassPath+"."+classPath+".domain."+classNm+"Service#selectDetail"+strTableLower+"("+commonBox+")");
            out.println("     * @param paramMap");
            out.println("     * @return");
            out.println("     * @throws Exception");
            out.println("     */");
            out.println("    public Map selectDetail"+strTableLower+"(Map paramMap)throws Exception {");
            out.println("        return commDao.selectByMap(\""+classPath + "."+strTableNameLower+".select_detail_"+strTableNameLower+"\", paramMap);");
            out.println("    }");
            out.println("");
            out.println("    /*");
            out.println("     * "+tableNameComment+" 등록.");
            out.println("     * @since "+sTimeStr);
            out.println("     * @see "+basicClassPath+"."+classPath+".domain."+classNm+"Service#insert"+strTableLower+"("+commonBox+")");
            out.println("     * @param paramMap");
            out.println("     * @return	");
            out.println("     * @throws Exception");
            out.println("     */");
            out.println("    public int insert"+strTableLower+"(Map paramMap) throws Exception {");
            out.println("        return commDao.insert(\""+classPath + "."+strTableNameLower+".insert_"+strTableNameLower+"\", paramMap);");
            out.println("    }");
            out.println("");
            out.println("    /* ");
            out.println("     * "+tableNameComment+" 수정.");
            out.println("     * @since "+sTimeStr);
            out.println("     * @see "+basicClassPath+"."+classPath+".domain."+strTableLower+"Service#update"+strTableLower+"("+commonBox+")");
            out.println("     * @param paramMap");
            out.println("     * @throws Exception");
            out.println("     */");
            out.println("    public int update"+strTableLower+"(Map paramMap) throws Exception {");
            out.println("        return commDao.update(\""+classPath + "."+strTableNameLower+".update_"+strTableNameLower+"\", paramMap);");
            out.println("    }");
            out.println("");
            out.println("    /*");
            out.println("     * "+tableNameComment+" 삭제.");
            out.println("     * @since "+sTimeStr);
            out.println("     * @see "+basicClassPath+"."+classPath+".domain."+strTableLower+"Service#delete"+strTableLower+"("+commonBox+")");
            out.println("     * @param paramMap");
            out.println("     * @throws Exception");
            out.println("     */");
            out.println("    public Map delete"+strTableLower+"(Map paramMap) throws Exception {");
            out.println("");
            out.println("        Map cmapReturn = new Map();");
            out.println("");
            out.println("        cmapReturn.put(\"resultCd\", CommConstants.SUCCESS_CODE);");
            out.println("");
            out.println("        commDao.delete(\""+classPath + "."+strTableNameLower+".delete_"+strTableNameLower+"\", paramMap);");
            out.println("");
            out.println("        return cmapReturn;");
            out.println("    }");
            out.println("}");

        }
        else if(selectType.equals("saveMaps")){
            /* 시퀀스 존재 여부 확인용 쿼리 실행 S */
            sql =" SELECT COUNT(1) AS CNT "
                +"   FROM USER_TABLES T1 "
                +"  WHERE 1=1 AND T1.TABLE_LOCK = 'ENABLED'  "
                +"    AND TABLE_NAME=? ";

          pstmt = con.prepareStatement(sql);
          pstmt.setString(1, tableName+"_SEQ");
          rs = pstmt.executeQuery();
          if (!rs.next()) return;
          seqCnt = rs.getInt("CNT");
          /* 시퀀스 존재 여부 확인용 쿼리 실행 E */

            sql ="SELECT LOWER(T1.TABLE_NAME) AS TABLE_NAME_LOWER, "
                +"       LOWER(T1.TABLE_NAME) AS TABLE_LOWER, "
                +"       UPPER(T1.TABLE_NAME) AS TABLE_NAME, "
                +"       LOWER(T1.COLUMN_NAME) AS COLUMN_LOWER, "
                +"       UPPER(T1.COLUMN_NAME) AS COLUMN_NAME, "
                +"       T2.CONSTRAINT_NAME "
                +"FROM USER_TAB_COLUMNS T1 "
                +"LEFT OUTER JOIN ( "
                +"    SELECT A.TABLE_NAME "
                +"         , A.CONSTRAINT_NAME "
                +"         , B.COLUMN_NAME      "
                +"         , B.POSITION "
                +"      FROM USER_CONSTRAINTS  A "
                +"         , USER_CONS_COLUMNS B "
                +"     WHERE 1=1 "
                +"       AND A.CONSTRAINT_TYPE = 'P'  "
                +"       AND A.OWNER           = B.OWNER "
                +"       AND A.CONSTRAINT_NAME = B.CONSTRAINT_NAME "
                +") T2 ON T1.TABLE_NAME = T2.TABLE_NAME AND T1.COLUMN_NAME = T2.COLUMN_NAME "
                +"WHERE 1=1 "
                +"AND T1.TABLE_NAME = ? "
                +"ORDER BY COLUMN_ID ";

                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, tableName);
                rs = pstmt.executeQuery();

                if (!rs.next()) return;

                cnt = 0;
                strQuery = "";
                strTableName = rs.getString("TABLE_NAME");
                strTableNameLower = rs.getString("TABLE_NAME_LOWER");
                strTableLower = rs.getString("TABLE_LOWER");

                out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                out.println("<!DOCTYPE mapper   PUBLIC \"-//mybatis.org//DTD Mapper 3.0//EN\" \"http://mybatis.org/dtd/mybatis-3-mapper.dtd\">");
                out.println("    ");
                out.println("<mapper namespace=\"" + classPath + "."+strTableNameLower+"\">");

                /* 등록 */
                out.println("    ");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <!-- 업무내용 : " + tableNameComment + " 등록							-->");
                out.println("    <!-- 작성자   : " + devnm + "								     -->");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <insert id=\"insert_"+strTableNameLower+"\" parameterType=\"paramMap\">");
                out.println("    /* " + classPath + "." + strTableNameLower + "." + "insert_" + strTableNameLower + " */");


                do {
                    if (cnt == 0) {
                        strQuery = "INSERT INTO " + strTableName + "(";
                        strQuery += "\n                            ";
                    } else {
                        //out.println("            " + strQuery + " ");
                        strQuery = "                   ";
                    }

                    strPriKey = rs.getString("CONSTRAINT_NAME");

                    if(strPriKey == "" || strPriKey == null){

                        System.out.println("COLUMN_LOWER==>" + getCap(rs.getString("COLUMN_LOWER")));
                        strQuery += "<if test='" + getCap(rs.getString("COLUMN_LOWER")) + " != null and " + getCap(rs.getString("COLUMN_LOWER")) + " != \"\"'>";
                        strQuery += "\n                           ";

                    }

                    if(cnt > 0){
                        strQuery += ",";
                    }

                    strQuery += rs.getString("COLUMN_NAME");

                    if(strPriKey == "" || strPriKey == null){
                        strQuery += "\n                           </if>";
                    }
                    out.println("        " + strQuery);

                    cnt++;
                } while (rs.next());

                out.println("                           )");

                try {rs.close();} catch(Exception e) {}
                rs = pstmt.executeQuery();

                if (!rs.next()) return;
                cnt = 0;

                do {
                    if (cnt == 0) {
                        strQuery = "            VALUES (";
                        strQuery += "\n                            ";
                    } else {
                        //out.println("            " + strQuery + " ");
                        strQuery = "                   ";
                    }

                    strPriKey = rs.getString("CONSTRAINT_NAME");

                    if(strPriKey == "" || strPriKey == null){
                        strQuery += "<if test='" + getCap(rs.getString("COLUMN_LOWER")) + " != null and " + getCap(rs.getString("COLUMN_LOWER")) + " != \"\"'>";
                        strQuery += "\n                           ";
                    }

                    if(cnt > 0){
                        strQuery += ",";
                    }


                    strColumnName = rs.getString("COLUMN_NAME");
                    System.out.println(strColumnName + " : strColumnName.endsWith(SEQ) ===> " + strColumnName.endsWith("SEQ"));
                    if(strPriKey != "" && strPriKey != null) {
                        System.out.println(tableName+"_SEQ CNT ===> "+seqCnt);

                      if(seqCnt > 0) {
                            strQuery += "(SELECT "+strTableName+"_SEQ.NEXTVAL) FROM DUAL)";
                      }
                      else {
                              strQuery += "#{"+getCap(rs.getString("COLUMN_LOWER"))+"}";
                      }
                    }
                      else {
                          strQuery += "#{"+getCap(rs.getString("COLUMN_LOWER"))+"}";
                      }
                    /*
                    if(strPriKey.equals("PRI") && ) {
                        strQuery += "(SELECT "+strTableName+"_SEQ.NEXTVAL FROM DUAL)";
                    }
                      else {
                          strQuery += "#{"+getCap(rs.getString("COLUMN_LOWER"))+"}";
                      }
                      */

                    if(strPriKey == "" || strPriKey == null){
                        strQuery += "\n                           </if>";
                    }

                    out.println("        " + strQuery);

                    cnt++;
                } while (rs.next());

                out.println("                           )");
                out.println("    </insert>");

                try {rs.close();} catch(Exception e) {}
                rs = pstmt.executeQuery();

                if (!rs.next()) return;
                cnt = 0;

                /* 수정 */
                out.println("    ");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <!-- 업무내용 : " + tableNameComment + " 수정							-->");
                out.println("    <!-- 작성자   : " + devnm + "								     -->");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <update id=\"update_"+strTableNameLower+"\" parameterType=\"paramMap\">");
                out.println("    /* " + classPath + "." + strTableNameLower + "." + "update_" + strTableNameLower + " */");

                do {
                    strPriKey = rs.getString("CONSTRAINT_NAME");

                    if (cnt == 0) {
                        strQuery = "UPDATE " + strTableName + " SET";
                        strQuery += "\n               ";
                    } else {
                        strQuery = "      ";
                    }

                    strPriKey = rs.getString("CONSTRAINT_NAME");

                    if(strPriKey == "" || strPriKey == null){
                        strQuery += "<if test='" + getCap(rs.getString("COLUMN_LOWER")) + " != null and " + getCap(rs.getString("COLUMN_LOWER")) + " != \"\"'>";
                        strQuery += "\n              ";
                    }

                    if(cnt > 0){
                        strQuery += ",";
                    }

                    strQuery += rs.getString("COLUMN_NAME");

                    if(strPriKey == "" || strPriKey == null){
                        strQuery += " = #{" + getCap(rs.getString("COLUMN_LOWER")) + "}";
                        strQuery += "\n              </if>";
                        out.println("        " + strQuery);
                    }else{
                        strQuery += " = #{" + getCap(rs.getString("COLUMN_LOWER")) + "}";
                        out.println("        " + strQuery);
                    }

                    cnt++;
                } while (rs.next());

                try {rs.close();} catch(Exception e) {}
                rs = pstmt.executeQuery();

                if (!rs.next()) return;
                cnt = 0;

                do {
                    if (cnt == 0) {
                        strQuery = "WHERE ";
                        //strQuery += "\n                            ";
                    } else {
                        //out.println("            " + strQuery + " ");
                        strQuery = "  AND ";
                    }

                    strPriKey = rs.getString("CONSTRAINT_NAME");

                    if(strPriKey != "" && strPriKey != null){
                        strQuery += rs.getString("COLUMN_NAME") + " = #{"+getCap(rs.getString("COLUMN_LOWER"))+"}";
                        out.println("        " + strQuery);
                    }
                    cnt++;
                } while (rs.next());

                out.println("    </update>");

                try {rs.close();} catch(Exception e) {}
                rs = pstmt.executeQuery();

                if (!rs.next()) return;
                cnt = 0;

                /* 삭제 */
                out.println("    ");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <!-- 업무내용 : " + tableNameComment + " 삭제							-->");
                out.println("    <!-- 작성자   : " + devnm + "								     -->");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <delete id=\"delete_"+strTableNameLower+"\" parameterType=\"paramMap\">");
                out.println("    /* " + classPath + "." + strTableNameLower + "." + "delete_" + strTableNameLower + " */");

                out.println("        DELETE FROM " + strTableName);

                do {
                    if (cnt == 0) {
                        strQuery = " WHERE ";
                        //strQuery += "\n                            ";
                    } else {
                        //out.println("            " + strQuery + " ");
                        strQuery = "   AND ";
                    }

                    strPriKey = rs.getString("CONSTRAINT_NAME");

                    if(strPriKey != "" && strPriKey != null){
                        strQuery += rs.getString("COLUMN_NAME") + " = #{"+getCap(rs.getString("COLUMN_LOWER"))+"}";
                        out.println("        " + strQuery);
                    }

                    cnt++;
                } while (rs.next());

                out.println("    </delete>");

                //out.println("</mapper>");

        /*
        }
        else if(selectType.equals("selcetMaps")){
            sql ="SELECT LOWER(T1.TABLE_NAME) AS TABLE_NAME_LOWER, "
                +"       LOWER(T1.TABLE_NAME) AS TABLE_LOWER, "
                +"       UPPER(T1.TABLE_NAME) AS TABLE_NAME, "
                +"       LOWER(T1.COLUMN_NAME) AS COLUMN_LOWER, "
                +"       UPPER(T1.COLUMN_NAME) AS COLUMN_NAME "
                +"FROM USER_TAB_COLUMNS T1 "
                +"WHERE 1=1 "
                +"AND T1.TABLE_NAME = ? ";

                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, tableName);
                rs = pstmt.executeQuery();

                if (!rs.next()) return;
        */

                try {rs.close();} catch(Exception e) {}
                rs = pstmt.executeQuery();

                if (!rs.next()) return;
                cnt = 0;

                strQuery = "";
                strTableName = rs.getString("TABLE_NAME");
                strTableNameLower = rs.getString("TABLE_NAME_LOWER");
                strTableLower = rs.getString("TABLE_LOWER");

                //out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                //out.println("<!DOCTYPE mapper   PUBLIC \"-//mybatis.org//DTD Mapper 3.0//EN\" \"http://mybatis.org/dtd/mybatis-3-mapper.dtd\">");
                //out.println("    ");
                //out.println("<mapper namespace=\"" + classPath + "."+classNm+"\">");

                /* 조회 */
                out.println("    ");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <!-- 업무내용 : " + tableNameComment + " 조회							-->");
                out.println("    <!-- 작성자   : " + devnm + "								     -->");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <select id=\"select_"+strTableLower+"\" parameterType=\"paramMap\" resultType=\"paramMap\">");
                out.println("    /* " + classPath+ "." + strTableNameLower + "." + "select_"+strTableLower + " */");

                do {
                    if (cnt == 0) {
                        strQuery = "SELECT ";
                    } else {
                        //out.println("            " + strQuery + " ");
                        strQuery = "      ,";
                    }

                    strQuery += rs.getString("COLUMN_NAME");
                    out.println("        " + strQuery);

                    cnt++;
                } while (rs.next());

                out.println("          FROM " + strTableName);
                out.println("         WHERE 1 = 1");

                out.println("    </select>");

                try {rs.close();} catch(Exception e) {}
                rs = pstmt.executeQuery();

                if (!rs.next()) return;
                cnt = 0;

                /* 갯수 */
                out.println("    ");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <!-- 업무내용 : " + tableNameComment + " 총수							-->");
                out.println("    <!-- 작성자   : " + devnm + "								     -->");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <select id=\"select_"+strTableLower+"_cnt\" parameterType=\"paramMap\" resultType=\"int\">");
                out.println("    /* " + classPath+ "." + strTableNameLower + "." + "select_"+strTableLower  +"_cnt" + " */");

                out.println("        SELECT COUNT(1) CNT");

                out.println("          FROM " + strTableName);
                out.println("         WHERE 1 = 1");

                out.println("    </select>");

                /* 상세조회 */
                out.println("    ");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <!-- 업무내용 : " + tableNameComment + " 상세조회							-->");
                out.println("    <!-- 작성자   : " + devnm + "								     -->");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <select id=\"select_detail_"+strTableLower+"\" parameterType=\"paramMap\" resultType=\"paramMap\">");
                out.println("    /* " + classPath+ "." + strTableNameLower + "." + "select_detail_"+strTableLower + " */");

                do {
                    if (cnt == 0) {
                        strQuery = "SELECT ";
                    } else {
                        //out.println("            " + strQuery + " ");
                        strQuery = "      ,";
                    }

                    strQuery += rs.getString("COLUMN_NAME");
                    out.println("        " + strQuery);

                    cnt++;
                } while (rs.next());

                out.println("          FROM " + strTableName);
                out.println("         WHERE 1 = 1");

                out.println("    </select>");

                try {rs.close();} catch(Exception e) {}
                rs = pstmt.executeQuery();

                if (!rs.next()) return;
                cnt = 0;

                out.println("</mapper>");

        } else if(selectType.equals("html")) {
            sql ="SELECT COL "
                +"     , LOWER(SUBSTR(REPLACE(INITCAP(COL),'_',''), 0, 1)) || SUBSTR(REPLACE(INITCAP(COL),'_',''), 2) AS CAMEL"
                +"     , '#{' || LOWER(SUBSTR(REPLACE(INITCAP(COL),'_',''), 0, 1)) || SUBSTR(REPLACE(INITCAP(COL),'_',''), 2) ||'}' AS MYBATISFROM"
                +"     , NULLABLE , DATA_TYPE , DATA_LENGTH  , TABLE_NAME  , TABLE_COMMENTS"
                +"  FROM ( SELECT A.TABLE_NAME "
                +"              , B.COMMENTS AS TABLE_COMMENTS "
                +"              , A.COLUMN_ID AS COL_SEQ "
                +"              , A.COLUMN_NAME AS COL "
                +"              , C.COMMENTS AS COL_NAME "
                +"              , A.DATA_TYPE || "
                +"                               DECODE(A.DATA_TYPE, 'DATE', '', "
                +"                                     DECODE(A.DATA_TYPE,'NUMBER', "
                +"                                         DECODE(DATA_SCALE,0,'(' || DATA_PRECISION || ')','(' || "
                +"                                         DATA_PRECISION || ',' || DATA_SCALE || ')'),'(' || DATA_LENGTH || ')') ) AS DATA_TYPE"
                +"              , DECODE(A.DATA_TYPE, 'DATE', '', DECODE(A.DATA_TYPE,'NUMBER', A.DATA_PRECISION, DECODE(A.DATA_TYPE,'CLOB', '' ,DATA_LENGTH ))) AS DATA_LENGTH "
                +"              , DECODE(A.NULLABLE,'Y','','required') AS NULLABLE "
                +"              , D.COLUMN_POSITION "
                +"              , A.DATA_DEFAULT "
                +"        FROM USER_TAB_COLUMNS A, "
                +"         USER_TAB_COMMENTS B, "
                +"        USER_COL_COMMENTS C, "
                +"        USER_IND_COLUMNS D "
                +"        WHERE A.TABLE_NAME = B.TABLE_NAME "
                +"        AND A.TABLE_NAME = C.TABLE_NAME "
                +"        AND A.COLUMN_NAME = C.COLUMN_NAME "
                +"        AND A.TABLE_NAME =D.TABLE_NAME(+) "
                +"        AND A.COLUMN_NAME =D.COLUMN_NAME(+) "
                +"        AND A.TABLE_NAME = ? "
                +"         ORDER BY 1, 3 "
                +"        )"
                +"      ORDER BY COL_SEQ";


                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, tableName);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                     out.println("<input type='text' name='" + rs.getString("CAMEL") +"'"
                     + (rs.getString("DATA_LENGTH") == null ? "" : " data-maxbyte='"+ rs.getString("DATA_LENGTH") +"'")+ "/>");
                     out.println("");
                }


                while (rs.next()) {
                    out.println("<textarea type='text' name='" + rs.getString("CAMEL") +"'"
                    + (rs.getString("DATA_LENGTH") == null ? "" : " data-maxbyte='"+ rs.getString("DATA_LENGTH") +"'")+ ">"
                    +  rs.getString("MYBATISFROM")
                    + "</textarea>");
                    out.println("");
               }

        }

    } catch (Exception e) {
        System.out.println(e);
    } finally {
        try {rs.close();} catch(Exception e) {}
        try {pstmt.close();} catch(Exception e) {}
        con.close();
    }
%>
            </textarea>
        </td>
    </tr>
<table>
<iframe name="ifrmFile" src="" style="width:0;height:0" border=0></iframe>
</body>
</html>
<%!

private String getInitCap(String str) {

    String first = str.substring(0,1).toUpperCase();
    //String first = str.substring(0,1).toLowerCase();
    str = str.substring(1);
    str = str.toLowerCase();

    boolean under = false;
    String strone = null;
    String sResultStr = "";

    for(int i=0;i < str.length();i++){

        strone = str.substring(i,i+1);

        if(!strone.equals("_") && !under){
            under = false;
            sResultStr = sResultStr + strone;
            continue;
        }else if(under){
            under = false;

        }else{
            under = true;
            continue;
        }


        char h = strone.charAt(0);

        if(h >= 'a' && h <= 'z')
        {
            sResultStr = sResultStr + String.valueOf((char) (h - 32));
        }
    }

    return first + sResultStr;

}

private String getCap(String str) {

    //String first = str.substring(0,1).toUpperCase();
    String first = str.substring(0,1).toLowerCase();
    str = str.substring(1);
    str = str.toLowerCase();

    boolean under = false;
    String strone = null;
    String sResultStr = "";

    for(int i=0;i < str.length();i++){

        strone = str.substring(i,i+1);

        if(!strone.equals("_") && !under){
            under = false;
            sResultStr = sResultStr + strone;
            continue;
        }else if(under){
            under = false;

        }else{
            under = true;
            continue;
        }


        char h = strone.charAt(0);

        if(h >= 'a' && h <= 'z')
        {
            sResultStr = sResultStr + String.valueOf((char) (h - 32));
        }
    }

    return first + sResultStr;

}

%>