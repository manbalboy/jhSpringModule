<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.*, java.sql.*"%>

<div class="container-fluid">
    <h5>@ 표시가 붙은 항목은 사용자가 직접 수정해야 하는 부분입니다.</h5>
<form name="frmMain" method=post onSubmit="tblGen();">
<div>

</div>
<table border=1 cellspecing=0 style="margin-bottom: 2px" name="dbTable">
    <colgroup>
        <col style="width: 5%;">
        <col style="width: 18%;">
        <col style="width: 5%;">
        <col style="width: 18%;">
        <col style="width: 5%;">
        <col style="width: 18%;">
        <col style="width: 5%;">
        <col style="width: 18%;">
        <col style="width: ;">
    </colgroup>
    <tr>
        <td>@ ID </td>
        <td><input type="text" name="dbId" value="hr" style="width: 100%"/></td>
        <td>@ PW</td>
        <td><input type="text" name="dbPw" value="hr" style="width: 100%"/></td>
        <td>@ URL</td>
        <td><input type="text" name="dbURL" value="jdbc:oracle:thin:@java-coder.co.kr:18903:orcl" style="width: 100%"/></td>
        <td>@ DB TYPE</td>
        <td>
            <select name="className"style="width:100%" >
                <option value="oracle.jdbc.driver.OracleDriver">
                 ORACLE
                </option>
            </select>
        </td>
        <td><button type="button" onClick="fn_dbConnect()">전송</button></td>
    </tr>
</table>



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

            </select>
        </td>
        <td align="right">@선택</td>
        <td align="left">
            <select name="selectType" style="width:100;" onChange="javascript:tblGen();">
                <option value="interface">service</option>
                <option value="Impl">Impl</option>
                <option value="saveMaps">mapper</option>
                <option value="html">html</option>
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



    function fn_dbConnect () {
        //dbTable 정보
        const OBJECTS = document.querySelectorAll('[name=dbTable] tr > td > input, [name=dbTable] tr > td > select');

        let oAjaxData =  {};

        // 이클립스가 뉴피쳐 못받아드려서 오류현상일어남
        for(let oObj of OBJECTS) {
            let key = oObj.name

            oAjaxData[key] = oObj.value

            if(jhUtil.isEmpty(oObj.value)) {
                alert("DATA를 입력하세요");
                oObj.focus();
                return false;
            }
        }


        jhUtil.callAjax({
            sId  : "dbConnect",
            data : oAjaxData,
            type : "POST",
            url  : "${pageContext.request.contextPath}/sourceMaker/tableListAjax",
            dataType : "json",
            contentType: "application/json;",
            callBackFunction : fn_callBack
        });

        console.log(oAjaxData);
    };


    function fn_callBack(data, sId){
        switch(sId) {
        case "dbConnect" :
            let list =  data.tableList;
//             //초기화
            document.querySelector('[name=tableName]').innerHTML = "";
            let sHTML = "";

            for(let row of list) {
                sHTML += "<option value='"+row.tableName+"'>"+ row.tableName +"</option>";
            }

            console.log(sHTML);
            document.querySelector('[name=tableName]').innerHTML = sHTML;
            break;
        }
        console.log(data, sId);
    };
</script>

