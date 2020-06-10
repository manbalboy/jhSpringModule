<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    <table class="table">
        <thead>
            <tr>
              <th scope="col">순번</th>
              <th scope="col">성장일 등록일</th>
              <th scope="col">할일</th>
              <th scope="col">성장오너</th>
            </tr>
          </thead>
        <tbody>
        <c:forEach items="${list }" var="item">
            <tr>
              <th>${item.TODO_ID }</th>
              <td><fmt:formatDate value="${item.REGISTRATION_DATE }" pattern="yyyy.MM.dd"/></td>
              <td>${item.TODO_TITLE }</td>
              <td>${item.TODO_OWNER }</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div id="pageNavi" data-total-cnt="${list[0].TOTAL_CNT}" data-current-page="${not empty param.currentPage ? param.currentPage : 1}"></div>