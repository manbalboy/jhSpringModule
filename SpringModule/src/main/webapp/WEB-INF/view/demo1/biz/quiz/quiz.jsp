<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">QUIZ !!!! 게시판</h1>
<!--     <p class="mb-4"> DataTables is a third party plugin that is used to generate the demo -->
<!--         table below. For more information about DataTables, please visit the -->
<!--         <a target="_blank" href="https://datatables.net">official DataTables documentation</a>. -->
<!--     </p> -->

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <div>
                <span class="m-0 font-weight-bold text-primary" style="font-size: 40px">QuizTable
                <a href="${pageContext.request.contextPath}/viewInsertQuiz" class="btn btn-primary btn-icon-split"style="float: right;">
                    <span class="text">등록</span>
                </a>
                </span>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="quizTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th style="width: 140px;">작성자</th>
                            <th>퀴즈내용</th>
                            <th style="width: 240px;">등록일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="row">
                            <tr>
                                <td>${row.USER_NAME}</td>
                                <td>${row.QUIZ_CONTENTS}</td>
                                <td>${row.REGISTRATION_DATE}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    $(document).ready (function (){
        $('#quizTable').DataTable({
            order: [[2, 'desc']], // asc 또는 desc
            ordering: true,
            serverSide: false
        });
    });
</script>

