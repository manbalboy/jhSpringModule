<!-- Import Reference Class -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="${pageContext.request.contextPath}/resource/static/demo1/lib/jquery/jquery-3.5.1.js" ></script>
<script src="${pageContext.request.contextPath}/resource/static/demo1/js/jh/hjeong.js" ></script>

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

<table height="99%" width="100%">
    <tr>
        <td width="100%" height="100%">

            <textarea id="source" name="source" style="width:100%;height:100%;line-height:110%;scrolling:yes;">

            </textarea>
        </td>
    </tr>
<table>
<iframe name="ifrmFile" src="" style="width:0;height:0" border=0></iframe>
</body>
</html>

<script>
   const jsonModel = ${jsonModel};



   $(document).ready(function (){

    fn_careateHtml(jsonModel);

   });



    function fn_careateHtml (jsonModel) {
        let sStr  = "";

        sStr = jsonModel.tableList[0].tab + " : " + jsonModel.tableList[0].tabName +"\n"
        switch(jsonModel.selectType) {
        case "input" :

            for(let row of jsonModel.tableList) {
                sStr += "\n<input type='text' name='"+row.camel+"'";

                if(!jhUtil.isEmpty(jsonModel.lengthChk) && !jhUtil.isEmpty(row.dataLength)) {
                    sStr += " " + jsonModel.lengthChk + "='" + row.dataLength +"'";
                }

                if(!jhUtil.isEmpty(jsonModel.notNullChk) && !jhUtil.isEmpty(row.nullable)) {
                    sStr += " " + jsonModel.notNullChk + "='" + row.nullable +"'";
                }


                sStr += " />";
            }
            break;
        case "camel" :
            sStr += "\n\n\n\n\n[[기본]]";
            for(let row of jsonModel.tableList) {
                sStr += "\n"+row.camel;
            }

            sStr += "\n\n\n\n\n[[기본 + 주석]]";
            for(let row of jsonModel.tableList) {
                sStr += "\n"+row.camel+fn_setSpaceLength(row.maxNoLineColLength , row.noLineColLength)+row.xmlComment ;
            }
            break;
        case "camel1" :
            sStr += "\n\n\n\n\n[[기본]]";
            for(let row of jsonModel.tableList) {
                sStr += "\n#{"+row.camel+"}";
            }

            sStr += "\n\n\n\n\n[[기본 + 주석]]";
            for(let row of jsonModel.tableList) {
                sStr += "\n#{"+row.camel+"}"+fn_setSpaceLength(row.maxNoLineColLength , row.noLineColLength)+row.xmlComment ;
            }
            break;
        case "camel2" :
            sStr += "\n\n\n\n\n[[기본]]";
            for(let row of jsonModel.tableList) {
                sStr += "\n\${"+row.camel+"}";
            }

            sStr += "\n\n\n\n\n[[기본 + 주석]]";
            for(let row of jsonModel.tableList) {
                sStr += "\n\${"+row.camel+"}"+fn_setSpaceLength(row.maxNoLineColLength , row.noLineColLength) +row.xmlComment ;
            }
            break;
        case "col" :
            sStr += "\n\n\n\n\n[[기본]]";
            for(let row of jsonModel.tableList) {
                sStr += "\n"+row.col;
            }

            sStr += "\n\n\n\n\n[[기본 + DATATYPE]]";
            for(let row of jsonModel.tableList) {
                sStr += "\n"+row.col+fn_setSpaceLength(row.maxColLength , row.colLength)+row.dataType;
            }


            sStr += "\n\n\n\n\n[[기본 + DATATYPE + 코멘트]]";
            for(let row of jsonModel.tableList) {
                sStr += "\n"+row.col +fn_setSpaceLength(row.maxColLength , row.colLength) +row.dataType +fn_setSpaceLength(row.maxDataTypeLength , row.dataTypeLength) +row.colName;
            }
            break;
        case "java" :
            sStr += "\n\n\n\n\n[[기본]]";
            for(let row of jsonModel.tableList) {
                sStr += "\nprivate " + fn_typeOfJavaType(row.dataType) + row.camel+";";
            }
            break;
        }
//         sStr += "\n\n\n\n"+JSON.stringify(jsonModel);
        $("#source").val(sStr);
    }



    // 스페이스 처리
    function fn_setSpaceLength(maxLength, objectLength) {
        var count = maxLength - objectLength + 4;
        let sSpaceStr ="";


        for(i=0; i<count; i++) {
            sSpaceStr += " ";
        }
        return sSpaceStr;
    }

    // javaType String
    function fn_typeOfJavaType (dataType) {
        var sReturnStr = "String ";
        if(dataType.indexOf('NUMBER') > -1) {
            sReturnStr = "int ";
        } else if(dataType.indexOf('DATE') > -1){
            sReturnStr = "Date ";
        } else {

        }
        return sReturnStr;



    }




</script>