<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.*, java.sql.*"%>
<%

    //String id = "zindev";
    //String pw = "zindev12";
    //String url = "jdbc:oracle:thin:@192.168.1.105:1521:XE";
    //String sql = "";

    String id = "hr";
    String pw = "hr";
    String url = "jdbc:oracle:thin:@java-coder.co.kr:18903:orcl";
    String sql = "";

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    System.out.println("111");

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        System.out.println("id:"+id+", pw: "+pw);
        con = DriverManager.getConnection(url,id,pw);

        //sql = "SELECT T1.TABLE_NAME, T1.NUM_ROWS, T2.COMMENTS FROM USER_TABLES T1 INNER JOIN USER_TAB_COMMENTS T2 ON T1.TABLE_NAME = T2.TABLE_NAME AND T1.TABLE_LOCK = 'ENABLED'";
        sql = "SELECT T1.TABLE_NAME FROM USER_TABLES T1 WHERE 1=1 AND T1.TABLE_LOCK = 'ENABLED'";

        pstmt = con.prepareStatement(sql);
        rs = pstmt.executeQuery();

%>


 <div class="container-fluid">
    <h1>@ 표시가 붙은 항목은 사용자가 직접 수정해야 하는 부분입니다.</h1>
<form name="frmMain" method=post onSubmit="tblGen();">
<table border=1 cellspecing=0>
    <tr>
    <td align="right">@설치위치</td>
        <td align="left">
            <input type="text" name="localPath" id="localPath" size="20" maxLength="200" value="D://source">
            <select name="selectPrj">
                <option value="SpringModule">스프링모듈</option>
            </select>
        </td>
        <td align="right">@테이블명</td>
        <td align="left">
            <select name="tableName" style="width:300;" onChange="javascript:tblGen();">
            <%
                while (rs.next()) {
            %>
                <option value="<%=rs.getString("TABLE_NAME")%>"><%=rs.getString("TABLE_NAME")%></option>
            <%
                };
            %>
            </select>
        </td>
        <td align="right">@선택</td>
        <td align="left">
            <select name="selectType" style="width:100;" onChange="javascript:tblGen();">
                <option value="interface">interface</option>
                <option value="Impl">Impl</option>
                <option value="saveMaps">mapper</option>
                <!-- <option value="saveMaps">저장용maps</option> -->
                <!-- <option value="selcetMaps">조회용maps</option> -->
            </select>
        </td>
        <td align="right">작성자</td>
        <td align="left"><input type="text" id="devnm" name="devnm" size="20" maxLength="20" value="" placeholder="이름을 입력하세요."></td>
        <td align="center" width="*"><input type="button" name="btnGen" value="코드작성" onClick="javascript:tblGen()"></td>
    </tr>
    <tr>
        <td align="right">공통클래스</td>
        <td align="left">
            <input type="text" name="commonBox" size="30" maxLength="200" value="marketingMgr.cmmn.util.CommMap">

        </td>
        <td align="right">기본패키지</td>
        <td align="left">
            <input type="text" name="basicClassPath" size="30" maxLength="200" value="marketingMgr">(기본 패키지)

        </td>
        <td align="right">@하위패키지</td>
        <td align="left">
            <input type="text" id="classPath" name="classPath" size="30" maxLength="200" value="" placeholder="예) biz.sample">(marketingMgr하위패키지-service패키지제외)

        </td>
        <td align="right">@클래스</td>
        <td align="left">
            <input type="text" id="classNm" name="classNm" size="20" maxLength="200" value="">(service클래스명)

        </td>
        <td align="center" width="*"><input type="button" name="btnGen" value="파일생성" onClick="javascript:tblFileGen()"></td>
    </tr>
</table>
<iframe name="ifrmList" src="" style="width:100%;height:80%" border=1></iframe>
</form>

</div>


<script type="text/javascript">
    $(document).ready(function () {
        console.log("정훈의 테스트11 ");
    });

    function tblGen() {
        var classNm = document.frmMain.classNm.value;
        var devNm = document.frmMain.devnm.value;
        var clasPath = document.frmMain.classPath.value;

        if(classNm == "" || classNm == null){
            alert("service클래스명을 넣어주세요.");
            document.frmMain.classNm.focus();
            return;
        }
        if(devNm == "" || devNm == null){
            alert("작성자 이름을 넣어주세요.");
            document.frmMain.devnm.focus();
            return;
        }
        if(clasPath == "" || clasPath == null){
            alert("하위패키지를 넣어주세요.");
            document.frmMain.classPath.focus();
            return;
        }
        document.frmMain.target = "ifrmList";
        document.frmMain.action = "${pageContext.request.contextPath}/sourceMakerContent";

        console.log( document.frmMain.action);
        document.frmMain.submit();
    }

    function tblFileGen() {
        var classNm = document.frmMain.classNm.value;
        var devNm = document.frmMain.devnm.value;
        var clasPath = document.frmMain.classPath.value;

        if(classNm == "" || classNm == null){
            alert("service클래스명을 넣어주세요.");
            document.frmMain.classNm.focus();
            return;
        }
        if(devNm == "" || devNm == null){
            alert("작성자 이름을 넣어주세요.");
            document.frmMain.devnm.focus();
            return;
        }
        if(clasPath == "" || clasPath == null){
            alert("하위패키지를 넣어주세요.");
            document.frmMain.classPath.focus();
            return;
        }

        if(!confirm("하위 패키지와 클래스 항목을 한번더 확인해 주세요.\n파일을 생성하기 전 꼭 코드작성 버튼을 한번 눌러 변경된 사항을 적용 후 파일 생성 하시기 바랍니다.")) {
            return;
        }

        ifrmList.makeFile();

    }



</script>
<%

    } catch (Exception e) {
        System.out.println(e);
        e.printStackTrace();
    } finally {
        System.out.println("finally");
        try {rs.close();} catch(Exception e) {}
        System.out.println("rs.close");
        try {pstmt.close();} catch(Exception e) {}
        System.out.println("pstmt.close()");
        con.close();
        System.out.println("con.close()");
    }

%>
