<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<table class="table">
<thead>
    <tr>
      <th scope="col">COLUMN1</th>
      <th scope="col">COLUMN2</th>
      <th scope="col">COLUMN3</th>
      <th scope="col">COLUMN4</th>
      <th scope="col">TEST1</th>
    </tr>
  </thead>
<tbody>
<c:forEach items="${list2 }" var="item">
    <tr>
      <th>${item.TEST1 }</th>
      <td>${item.COLUMN1 }Mark</td>
      <td>${item.COLUMN2 }Otto</td>
      <td>${item.COLUMN3 }@mdo</td>
      <td>${item.COLUMN4 }@mdo</td>
    </tr>
</c:forEach>
</tbody>
</table>
<div id="pageNavi" data-total-cnt="${list2[0].TOTAL_CNT}" data-current-page="${not empty param.currentPage ? param.currentPage : 1}"></div>
