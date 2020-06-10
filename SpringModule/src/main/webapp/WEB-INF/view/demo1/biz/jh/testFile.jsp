<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- Begin Page Content -->
<div class="container-fluid">
<h1>파일 업로드</h1>
<form action="/upload" method="post" enctype="multipart/form-data">
    <input type="file" value="파일 선택" name="file"/>
    <input type="submit" value="업로드"/>
</form>

</div>



