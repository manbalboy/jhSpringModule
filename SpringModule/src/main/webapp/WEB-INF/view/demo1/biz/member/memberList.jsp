<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- Begin Page Content -->

<form name="listForm" action="/member/management/viewMemberList">
    <input name="checkedIdForDel" type="hidden" />
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-2 text-gray-800">일반회원관리목록</h1>
    <!--     <p class="mb-4"> DataTables is a third party plugin that is used to generate the demo -->
    <!--         table below. For more information about DataTables, please visit the -->
    <!--         <a target="_blank" href="https://datatables.net">official DataTables documentation</a>. -->
    <!--     </p> -->

        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <div>
                    <span class="m-0 font-weight-bold text-primary" style="font-size: 15px">일반회원관리</span>
                    <input type="button" onclick="fn_goInsertMemberView()" value="등록" class="bg-gradient-danger" style="float: right; margin-left: 1px;"/>
                    <input type="button" onclick="fn_deleteUser()" value="삭제" class="bg-gradient-success" style="float: right; margin-left: 1px"/>
                    <input type="button" onclick="fn_search()" value="조회" class="bg-gradient-info" style="float: right; margin-left: 1px"/>

                    <input  name="searchKeyword" type="text" style="float: right; margin-left: 1px" value="${searchInfo.searchKeyword }"/>
                    <select name="searchCondition" id="searchCondition" style="float: right; margin-left: 1px">
                        <option value="memberName" <c:if test="${searchInfo.searchCondition == 'memberName'}">selected</c:if> >이름</option>
                        <option value="memberId" <c:if test="${searchInfo.searchCondition == 'memberId'}">selected</c:if> >ID</option>
                    </select>
                    <select name="memberStatusCode" id="sbscrbSttus" style="float: right; margin-left: 1px" >
                        <option value="" >가입상태(전체)</option>
                        <option value="A01" <c:if test="${searchInfo.memberStatusCode == 'A01'}">selected</c:if> >신청</option>
                        <option value="A03" <c:if test="${searchInfo.memberStatusCode == 'A03'}">selected</c:if> >삭제</option>
                        <option value="A02" <c:if test="${searchInfo.memberStatusCode == 'A02'}">selected</c:if> >승인</option>
                    </select>
                </div>
            </div>

            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="quizTable" width="100%" cellspacing="0">
                        <colgroup>
                            <col style="width: 3%;">
                            <col style="width: 15%;">
                            <col style="width: 15%;">
                            <col style="width: 20%;">
                            <col style="width: 13%;">
                            <col style="width: 10%;">
                            <col style="width: ;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th><input type="checkbox" name="checkAll" onClick="fn_CheckAll()"/></th>
                                <th>아이디</th>
                                <th>사용자이름</th>
                                <th>이메일</th>
                                <th>휴대전화번호</th>
                                <th>등록일</th>
                                <th>가입상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${memberList}" var="row">
                                <tr>
                                    <td>
                                        <input name="checkField" type="checkbox"/>
                                        <input name="checkId" type="hidden" value="${row.memberId}"/>
                                    </td>
                                    <td>${row.memberId}</td>
                                    <td>${row.memberName}</td>
                                    <td>${row.memberEmailAddress}</td>
                                    <td>${row.mobilePhoneNumber}</td>
                                    <td>${row.subscribeDate}</td>
                                    <td>${row.memberStatusCode}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</form>

<<script type="text/javascript">
function fn_CheckAll() {
    let checkField = document.listForm.checkField;
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(let i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(let j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}


function fn_deleteUser() {
    let checkField = document.listForm.checkField;
    let id = document.listForm.checkId;
    let checkedIds = "";
    let checkedCount = 0;
    if(checkField) {
        if(checkField.length > 1) {
            for(let i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkedIds += ((checkedCount==0? "" : ",") + id[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkedIds = id.value;
            }
        }
    }

    if(checkedIds.length > 0) {
        //alert(checkedIds);
        if(confirm("삭제하시겠습니까?")){
            document.listForm.checkedIdForDel.value=checkedIds;
            document.listForm.action = "/member/management/deleteMemberList";
            document.listForm.submit();
        }
    }
}


function fn_search() {
    document.listForm.action = "/member/management/viewMemberList";
    document.listForm.submit();
}


function fn_goInsertMemberView () {
    location.href ="${pageContext.request.contextPath}/member/management/viewInsertMember";
}


document.addEventListener('keydown', function(event) {
    if (event.keyCode === 13) {
        event.preventDefault();
    }
}, true);


</script>




