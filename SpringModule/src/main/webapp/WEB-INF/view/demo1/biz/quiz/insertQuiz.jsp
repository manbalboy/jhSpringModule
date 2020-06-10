<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">QUIZ 등록</h1>

    <!-- DataTales Example -->
    <form name="saveForm" action="${pageContext.request.contextPath}/insertQuiz">
    <div class="card shadow mb-4">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered"  width="100%" cellspacing="0">
                    <thead>

                    </thead>
                    <tbody>
                        <tr height="300px">
                            <th style="width: 140px; height: 300px">퀴즈내용</th>
                            <th style="height: 300px"><textarea name="quizContents" style="width: 100%; height: 100%" data-maxbyte="4000"></textarea></th>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="card-header py-3">
            <div>
                <button type="button" class="btn btn-info btn-icon-split"style="float: right;" onclick="fn_save()">
                    <span class="text">저장</span>
                </button>
                <a href="${pageContext.request.contextPath}/viewQuiz" class="btn btn-primary btn-icon-split"style="float: right; margin-right: 5px">
                    <span class="text">목록</span>
                </a>
            </div>
        </div>
    </div>
    </form>
</div>




<script>
    //저장 함수
    let fn_save = function () {
        //벨리데이션


        //서브밋
        document.saveForm.submit();
    };

</script>




