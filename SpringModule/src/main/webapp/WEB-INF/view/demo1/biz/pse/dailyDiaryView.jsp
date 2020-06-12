<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>

$(document).ready(function(){

    $(".updateDiv").hide();

    var clickCnt = 0;
    $("#btn_update").click(function(){

        $(".viewDiv").hide();
        $(".updateDiv").show();

        clickCnt++;

        if(clickCnt > 1 ){ // 수정 버튼 한 번 이상 클릭 시
            fn_update();
        }
    });

    $("#btn_delete").click(function(){
        fn_delete();
    });
});

function fn_update(){
    if(confirm("수정하시겠습니까?")){
        $.ajax({
            url: "${pageContext.request.contextPath}/demo1/pse/dailyDiaryUpdate"
            , data: {
                diarySeq : $("#diarySeq").text()
                , diaryTitle : $("#diaryTitle").val()
                , diaryContents : $("#diaryContents").val()
            }
            , type: "POST"
            , dataType: "json"
        })
        .done(function(result) {

            console.log(result.success);
            if(Number(result.success) > 0){
                alert("수정 완료!");
                location.href = "./dailyDiaryList";
            }

        });
    }
}

function fn_delete(){
    if(confirm("삭제하시겠습니까?")){
        $.ajax({
            url: "${pageContext.request.contextPath}/demo1/pse/dailyDiaryDelete"
            , data: {
                diarySeq : $("#diarySeq").text()
            }
            , type: "POST"
            , dataType: "json"
        })
        .done(function(result) {

            console.log(result.success);
            if(Number(result.success) > 0){
                alert("삭제 완료!");
                location.href = "./dailyDiaryList";
            }

        });
    }
}
</script>
<div id="list">

        <table class="table table-bordere">
            <c:forEach items="${list }" var="list">
                <tr>
                    <th class="bg-warning">No</th>
                    <td id="diarySeq">${list.DIARY_SEQ }</td>
                </tr>
                <tr>
                    <th class="bg-warning">ID</th>
                    <td>${list.USER_ID }</td>
                </tr>
                <form id="updateFrm">
                <tr>
                    <th class="bg-warning">Title</th>
                    <td>
                        <div class="viewDiv">
                           ${list.DIARY_TITLE }
                        </div>
                        <div class="updateDiv">
                            <input type="text" id="diaryTitle" name="diaryTitle" value="${list.DIARY_TITLE }"/>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th class="bg-warning">RegiDate</th>
                    <td><fmt:formatDate value="${list.REGIST_DATE }" pattern="yyyy.MM.dd"/></td>
                </tr>
                <tr>
                    <th class="bg-warning">Content</th>
                    <td>
                        <div class="viewDiv" style="white-space:pre-line;">
                            ${list.DIARY_CONTENTS }
                        </div>
                        <div class="updateDiv">
                            <textarea name="diaryContents" id="diaryContents" cols="100" rows="10">${list.DIARY_CONTENTS }</textarea>
                        </div>
                    </td>
                </tr>
                 </form>
            </c:forEach>
        </table>
    <div align="center">
        <button class="btn btn-info" id="btn_update">수정</button>
        &nbsp; &nbsp;
        <button class="btn btn-danger" id="btn_delete">삭제</button>
        &nbsp; &nbsp;
        <button class="btn btn-secondary" onclick="location.href='./dailyDiaryList'">목록</button>
    </div>
</div>