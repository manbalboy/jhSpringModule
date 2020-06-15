<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.*, java.sql.*"%>

<div class="container-fluid">
    <h5>@ 표시가 붙은 항목은 사용자가 직접 수정해야 하는 부분입니다.</h5>
<form name="frmMain" method=post onSubmit="fn_tblGen();">
<div>

</div>
<table border=1 cellspecing=0 style="margin-bottom: 5px; width: 100%" name="dbTable">
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



<table border=1 cellspecing=0 style="width: 100%">
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
    <tbody>
    <tr>
        <td>@테이블명</td>
        <td>
            <select name="tableName"onChange="javascript:fn_tblGen();" style="width: 100%">

            </select>
        </td>
        <td>@선택</td>
        <td  colspan="5">
            <select name="selectType"  onChange="javascript:fn_tblGen();" style="width: 100%">
                <option value="col">컬럼</option>
                <option value="camel">카멜</option>
                <option value="input">input</option>
                <option value="camel1">#{카멜} 형식</option>
                <option value="camel2">\${카멜} 형식</option>
                <option value="java">javaBean</option>
            </select>
        </td>
        <td>@ 길이체크 속성명</td>
        <td><input type="text" name="lengthChk" value="data-maxbyte" style="width: 100%"/></td>
        <td>@ NotNull체크 속성명</td>
        <td><input type="text" name="notNullChk" value="data-required" style="width: 100%"/></td>



        <td>
            <input type="button" name="btnGen" value="코드작성" onClick="javascript:fn_tblGen()">
        </td>
    </tr>
    </tbody>
</table>
<iframe name="ifrmList" src="" style="width:100%;height:80%" border=1></iframe>
</form>

</div>


<script type="text/javascript">
    function fn_tblGen() {
        document.frmMain.target = "ifrmList";
        document.frmMain.action = "${pageContext.request.contextPath}/sourceMakerHelper/viewSourceMakerContent";

        document.frmMain.submit();
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
            url  : "${pageContext.request.contextPath}/sourceMakerHelper/tableListAjax",
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

            document.querySelector('[name=tableName]').innerHTML = "";
            let sHTML = "";

            for(let row of list) {
                sHTML += "<option value='"+row.tableName+"'>"+ row.tableName +"</option>";
            }

            document.querySelector('[name=tableName]').innerHTML = sHTML;
            break;
        }
    };



</script>

