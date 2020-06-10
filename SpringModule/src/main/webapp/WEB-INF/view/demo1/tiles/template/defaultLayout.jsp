<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ include file="/WEB-INF/view/common/Demo1ScriptHeader.jsp" %>

<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> --%>




<html>

<head>
    <title><tiles:getAsString name="title" /></title>
    <link href="<c:url value='/static/css/bootstrap.css' />"  rel="stylesheet"></link>
    <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
</head>

<body>
        <header id="header">
            <tiles:insertAttribute name="header" />
        </header>

        <section id="sidemenu">
            <tiles:insertAttribute name="menu" />
        </section>

        <section id="site-content">
            <tiles:insertAttribute name="body" />
        </section>

        <footer id="footer">
            <tiles:insertAttribute name="footer" />
        </footer>
</body>
</html>