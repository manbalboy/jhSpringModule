<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
function btn_insert(){
    const writeForm = document.getElementById("writeForm");

    writeForm.method = "post";
    writeForm.action = "/demo1/pse/dailyDiaryWriteAction";
    writeForm.submit();
    alert('등록 완료!');
}
</script>
<body>
<div id="list">
<form id="writeForm">
    <table class="table table-bordere">
        <tr>
            <th class="bg-warning">Title</th>
            <td>
                <div class="updateDiv">
                    <input type="text" name="diaryTitle" style="width:75.5%" value=""/>
                </div>
            </td>
        </tr>
        <tr>
            <th class="bg-warning">Content</th>
            <td>
                <div class="updateDiv">
                    <textarea name="diaryContents" id="" cols="100" rows="10"></textarea>
                </div>
            </td>
        </tr>
    </table>
</form>
    <div align="center">
        <button class="btn btn-info" onclick="btn_insert()">등록</button>
        &nbsp; &nbsp;
        <button class="btn btn-secondary" onclick="location.href='./dailyDiaryList'">목록</button>
    </div>
</div>
</body>
</html>