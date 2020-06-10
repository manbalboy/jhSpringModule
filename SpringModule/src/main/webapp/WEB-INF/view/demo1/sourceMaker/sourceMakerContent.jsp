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


    String id = "hr";
    String pw = "hr";
    String url = "jdbc:oracle:thin:@java-coder.co.kr:18903:orcl";
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
    String jobnm = null;	//업무명한글

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
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection(url,id,pw);

        int millisPerHour = 60 * 60 * 1000;
        SimpleDateFormat fmt= new SimpleDateFormat("yyyy.MM.dd");

        // TimeZone timeZone = TimeZone.getTimeZone( "UTC" );
        SimpleTimeZone timeZone = new SimpleTimeZone(9*millisPerHour,"KST");

        fmt.setTimeZone(timeZone);
        String sTimeStr = fmt.format(new Date(System.currentTimeMillis()));
        sql = "SELECT T2.COMMENTS AS DESCRIPTION FROM USER_TAB_COMMENTS T2 WHERE 1=1 AND T2.TABLE_NAME = ?";

        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, tableName);
        rs = pstmt.executeQuery();

        rs.next();

        jobnm = rs.getString("DESCRIPTION");

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
            out.println("import "+commonBox+";");
            out.println("");
            out.println("/**");
            out.println(" * "+jobnm+" 인터페이스");
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
            out.println("     * "+jobnm+" 조회");
            out.println("     * @since "+sTimeStr);
            out.println("     * @param commMap");
            out.println("     * @return");
            out.println("     * @throws Exception ");
            out.println("     */");
            out.println("    public CommMap select"+strTableLower+"(CommMap commMap) throws Exception;");
            out.println("");
            out.println("    /**");
            out.println("     * "+jobnm+" 상세");
            out.println("     * @since "+sTimeStr);
            out.println("     * @param commMap");
            out.println("     * @return");
            out.println("     * @throws Exception ");
            out.println("     */");
            out.println("    public CommMap selectDetail"+strTableLower+"(CommMap commMap) throws Exception;");
            out.println("");
            out.println("    /**");
            out.println("     * "+jobnm+" 등록");
            out.println("     * @since "+sTimeStr);
            out.println("     * @param commMap");
            out.println("     * @return");
            out.println("     * @throws Exception ");
            out.println("     */");
            out.println("    public int insert"+strTableLower+"(CommMap commMap) throws Exception;");
            out.println("");
            out.println("    /**");
            out.println("     * "+jobnm+" 수정");
            out.println("     * @since "+sTimeStr);
            out.println("     * @param commMap");
            out.println("     * @throws Exception ");
            out.println("     */");
            out.println("    public int update"+strTableLower+"(CommMap commMap) throws Exception;");
            out.println("");
            out.println("    /**");
            out.println("     * "+jobnm+" 삭제");
            out.println("     * @since "+sTimeStr);
            out.println("     * @param commMap");
            out.println("     * @throws Exception ");
            out.println("     */");
            out.println("    public CommMap delete"+strTableLower+"(CommMap commMap) throws Exception;");
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
            out.println("import marketingMgr.cmmn.constant.CommConstants;");
            out.println("import marketingMgr.cmmn.dataaccess.CommDAO;");
            out.println("import marketingMgr.cmmn.annotation.Paging;");
            out.println("import marketingMgr.cmmn.exception.CommException;");
            out.println("import "+commonBox+";");
            out.println("import "+basicClassPath+"."+classPath+".service."+classNm+"Service;");
            out.println("");
            out.println("/** ");
            out.println(" * "+jobnm+" 인터페이스 구현");
            out.println(" * <p>");
            out.println(" * <수정이력> <br />");
            out.println(" * 1. 수정일: 수정자: 수정사유: <br />");
            out.println(" * <p>");
            out.println(" * @since "+sTimeStr);
            out.println(" * @version 1.0");
            out.println(" * @author "+devnm);
            out.println(" */");
            out.println("@Service(\""+classNm.substring(0,1).toLowerCase()+classNm.substring(1,classNm.length())+"Service"+"\")");
            out.println("public class "+classNm+"ServiceImpl implements "+classNm+"Service{");
            out.println("");
            out.println("     private static final Logger logger = LoggerFactory.getLogger("+classNm+"ServiceImpl.class);");
            out.println("");
            out.println("     @Resource(name=\""+"commDAO"+"\")");
            out.println("     private CommDAO commDao;");
            out.println("");
            out.println("    /*");
            out.println("     * "+jobnm+" 조회");
            out.println("     * @since "+sTimeStr);
            out.println("     * @see "+basicClassPath+"."+classPath+".domain."+classNm+"Service#select"+strTableLower+"("+commonBox+")");
            out.println("     * @param commMap");
            out.println("     * @return");
            out.println("     * @throws Exception");
            out.println("     */");
            out.println("    public CommMap select"+strTableLower+"(CommMap commMap)throws Exception {");
            out.println("");
            out.println("        CommMap cmapReturn = new CommMap();");
            out.println("        cmapReturn.put(\"resultCd\", CommConstants.SUCCESS_CODE);");
            out.println("");
            out.println("        //전체 카운트");
            out.println("        int iListTotCnt = (int) commDao.selectByPk(\""+classPath + "."+strTableNameLower+".select_"+strTableNameLower+"_cnt\", commMap);");
            out.println("");
            out.println("        List<CommMap> listResult = commDao.selectList(\""+classPath + "."+strTableNameLower+".select_"+strTableNameLower+"\", commMap);");
            out.println("");
            out.println("        cmapReturn.put(\"listResult\", listResult);");
            out.println("");
            out.println("        return cmapReturn;");
            out.println("    }");
            out.println("");
            out.println("    /*");
            out.println("     * "+jobnm+" 상세.");
            out.println("     * @since "+sTimeStr);
            out.println("     * @see "+basicClassPath+"."+classPath+".domain."+classNm+"Service#selectDetail"+strTableLower+"("+commonBox+")");
            out.println("     * @param commMap");
            out.println("     * @return");
            out.println("     * @throws Exception");
            out.println("     */");
            out.println("    public CommMap selectDetail"+strTableLower+"(CommMap commMap)throws Exception {");
            out.println("        return commDao.selectByCommMap(\""+classPath + "."+strTableNameLower+".select_detail_"+strTableNameLower+"\", commMap);");
            out.println("    }");
            out.println("");
            out.println("    /*");
            out.println("     * "+jobnm+" 등록.");
            out.println("     * @since "+sTimeStr);
            out.println("     * @see "+basicClassPath+"."+classPath+".domain."+classNm+"Service#insert"+strTableLower+"("+commonBox+")");
            out.println("     * @param commMap");
            out.println("     * @return	");
            out.println("     * @throws Exception");
            out.println("     */");
            out.println("    public int insert"+strTableLower+"(CommMap commMap) throws Exception {");
            out.println("        return commDao.insert(\""+classPath + "."+strTableNameLower+".insert_"+strTableNameLower+"\", commMap);");
            out.println("    }");
            out.println("");
            out.println("    /* ");
            out.println("     * "+jobnm+" 수정.");
            out.println("     * @since "+sTimeStr);
            out.println("     * @see "+basicClassPath+"."+classPath+".domain."+strTableLower+"Service#update"+strTableLower+"("+commonBox+")");
            out.println("     * @param commMap");
            out.println("     * @throws Exception");
            out.println("     */");
            out.println("    public int update"+strTableLower+"(CommMap commMap) throws Exception {");
            out.println("        return commDao.update(\""+classPath + "."+strTableNameLower+".update_"+strTableNameLower+"\", commMap);");
            out.println("    }");
            out.println("");
            out.println("    /*");
            out.println("     * "+jobnm+" 삭제.");
            out.println("     * @since "+sTimeStr);
            out.println("     * @see "+basicClassPath+"."+classPath+".domain."+strTableLower+"Service#delete"+strTableLower+"("+commonBox+")");
            out.println("     * @param commMap");
            out.println("     * @throws Exception");
            out.println("     */");
            out.println("    public CommMap delete"+strTableLower+"(CommMap commMap) throws Exception {");
            out.println("");
            out.println("        CommMap cmapReturn = new CommMap();");
            out.println("");
            out.println("        cmapReturn.put(\"resultCd\", CommConstants.SUCCESS_CODE);");
            out.println("");
            out.println("        commDao.delete(\""+classPath + "."+strTableNameLower+".delete_"+strTableNameLower+"\", commMap);");
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
                out.println("    <!-- 업무내용 : " + jobnm + " 등록							-->");
                out.println("    <!-- 작성자   : " + devnm + "								     -->");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <insert id=\"insert_"+strTableNameLower+"\" parameterType=\"commMap\">");
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
                out.println("    <!-- 업무내용 : " + jobnm + " 수정							-->");
                out.println("    <!-- 작성자   : " + devnm + "								     -->");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <update id=\"update_"+strTableNameLower+"\" parameterType=\"commMap\">");
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
                out.println("    <!-- 업무내용 : " + jobnm + " 삭제							-->");
                out.println("    <!-- 작성자   : " + devnm + "								     -->");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <delete id=\"delete_"+strTableNameLower+"\" parameterType=\"commMap\">");
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
                out.println("    <!-- 업무내용 : " + jobnm + " 조회							-->");
                out.println("    <!-- 작성자   : " + devnm + "								     -->");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <select id=\"select_"+strTableLower+"\" parameterType=\"commMap\" resultType=\"commMap\">");
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
                out.println("    <!-- 업무내용 : " + jobnm + " 총수							-->");
                out.println("    <!-- 작성자   : " + devnm + "								     -->");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <select id=\"select_"+strTableLower+"_cnt\" parameterType=\"commMap\" resultType=\"int\">");
                out.println("    /* " + classPath+ "." + strTableNameLower + "." + "select_"+strTableLower  +"_cnt" + " */");

                out.println("        SELECT COUNT(1) CNT");

                out.println("          FROM " + strTableName);
                out.println("         WHERE 1 = 1");

                out.println("    </select>");

                /* 상세조회 */
                out.println("    ");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <!-- 업무내용 : " + jobnm + " 상세조회							-->");
                out.println("    <!-- 작성자   : " + devnm + "								     -->");
                out.println("    <!-- ================================================================================== -->");
                out.println("    <select id=\"select_detail_"+strTableLower+"\" parameterType=\"commMap\" resultType=\"commMap\">");
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