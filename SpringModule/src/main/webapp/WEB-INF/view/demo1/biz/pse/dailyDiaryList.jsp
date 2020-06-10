<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script>
function fn_moveDailyDiaryView(seq){

    var form = document.createElement("form");
    var paramArr = new Array();
    var inputArr = new Array();

    form.action = "${pageContext.request.contextPath }/demo1/pse/dailyDiaryView";
    form.method = "post";

    paramArr.push( ['diarySeq', seq] );

    for (var i = 0; i < paramArr.length; i++) {
        inputArr[i] = document.createElement("input");
        inputArr[i].setAttribute("type", "hidden");
        inputArr[i].setAttribute('name', paramArr[i][0]);
        inputArr[i].setAttribute("value", paramArr[i][1]);
        form.appendChild(inputArr[i]);
    }
    document.body.appendChild(form);
    form.submit();
}
</script>
<div id="list">
    <table class="table">
        <thead>
            <tr>
              <th scope="col">No</th>
              <th scope="col">ID</th>
              <th scope="col">Title</th>
              <th scope="col">RegiDate</th>
            </tr>
          </thead>
        <tbody>
        <c:forEach items="${list }" var="list">
            <tr>
              <th>${list.DIARY_SEQ }</th>
              <td>${list.USER_ID }</td>
              <td><a href="javascript:fn_moveDailyDiaryView('${list.DIARY_SEQ}')">${list.DIARY_TITLE }</a></td>
              <td><fmt:formatDate value="${list.REGIST_DATE }" pattern="yyyy.MM.dd"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>