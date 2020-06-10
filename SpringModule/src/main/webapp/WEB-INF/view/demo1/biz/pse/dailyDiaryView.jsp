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

    });
});

function fn_update(){
    if(confirm("수정하시겠습니까?")){
        alert("아직 수정 기능은 안 했습니다ㅠ..");
    }
}
</script>
<div id="list">
    <table class="table">
        <c:forEach items="${list }" var="list">
            <tr>
                <th scope="col">No</th>
                <td>${list.DIARY_SEQ }</td>
            </tr>
            <tr>
                <th scope="col">ID</th>
                <td>${list.USER_ID }</td>
            </tr>
            <tr>
                <th scope="col">Title</th>
                <td>
                    <div class="viewDiv">
                       ${list.DIARY_TITLE }
                    </div>
                    <div class="updateDiv">
                        <input type="text" value="${list.DIARY_TITLE }"/>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="col">RegiDate</th>
                <td><fmt:formatDate value="${list.REGIST_DATE }" pattern="yyyy.MM.dd"/></td>
            </tr>
            <tr>
                <th scope="col">Content</th>
                <td>
                    <div class="viewDiv">
                        ${list.DIARY_CONTENTS }
                    </div>
                    <div class="updateDiv">
                        <textarea name="" id="" cols="30" rows="10">${list.DIARY_CONTENTS }</textarea>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </table>
    <div align="center">
        <button class="btn btn-warning" id="btn_update">수정</button>
        &nbsp; &nbsp;
        <button class="btn btn-danger" id="btn_delete">삭제</button>
        &nbsp; &nbsp;
        <button class="btn btn-info" onclick="location.href='./dailyDiaryList'">목록</button>
    </div>
</div>