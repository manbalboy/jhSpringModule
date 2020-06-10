<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> --%>
<html>

<base href="/">
<%@ include file="/WEB-INF/view/common/Demo1ScriptHeader.jsp"%>
<script type="text/javascript">

</script>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>LOGOUT</title>


<!-- Custom styles for this template-->

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-password-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-2">Logout</h1>
                                        <p class="mb-4">bye bye</p>
                                    </div>
                                    <form class="user" action="/logout" method="post">
                                        <sec:csrfInput/>
                                        <input type="submit" class="btn btn-primary btn-user btn-block"value="logout">

                                    </form>
                                    <hr>
                                    <div class="text-center">
                                        <a class="small" href="register.html">Create an Account!</a>
                                    </div>
                                    <div class="text-center">
                                        <a class="small" href="login.html">Already have an
                                            account? Login!</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

  <!-- 밑에서 실행해주어야 동작됨 -->
  <!-- Bootstrap core JavaScript-->
  <script src="${pageContext.request.contextPath}/resource/static/demo1/lib/bootstrap-admin-template/vendor/jquery/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/resource/static/demo1/lib/bootstrap-admin-template/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="${pageContext.request.contextPath}/resource/static/demo1/lib/bootstrap-admin-template/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="${pageContext.request.contextPath}/resource/static/demo1/lib/bootstrap-admin-template/js/sb-admin-2.min.js"></script>

  <!-- Page level plugins -->
  <script src="${pageContext.request.contextPath}/resource/static/demo1/lib/bootstrap-admin-template/vendor/chart.js/Chart.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath}/resource/static/demo1/lib/bootstrap-admin-template/js/demo/chart-area-demo.js"></script>
  <script src="${pageContext.request.contextPath}/resource/static/demo1/lib/bootstrap-admin-template/js/demo/chart-pie-demo.js"></script>

</body>