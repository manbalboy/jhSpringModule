<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- Begin Page Content -->

<form name="listForm" action="/member/management/viewMemberList">
    <input name="checkedIdForDel" type="hidden" />
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-2 text-gray-800">일반회원관리 등록</h1>

        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <div>
                    <span class="m-0 font-weight-bold text-primary" style="font-size: 15px">일반회원관리 등록</span>
                </div>
            </div>

            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="quizTable" width="100%" cellspacing="0">
                        <colgroup>
                            <col style="width: 20%;">
                            <col style="width: ;">
                        </colgroup>
                        <thead>

                        </thead>
                        <tbody>
                            <tr>
                                <th>일반회원아이디 *</th>
                                <td>
                                    <input type="text" disabled="disabled" style="width: 100%;"/>
                                    <button type="button" >중복아이디 검사</button>
                                </td>
                            </tr>
                            <tr>
                                <th>일반회원이름 *</th>
                                <td>
                                    <input type="text"  style="width: 100%;"/>
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호 *</th>
                                <td>
                                    <input type="password"  style="width: 100%;"/>
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호확인 *</th>
                                <td>
                                    <input type="password" style="width: 100%;"/>
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호힌트 *</th>
                                <td>
                                    <input type="password" style="width: 100%;"/>
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호정답 *</th>
                                <td>
                                    <input type="text" style="width: 100%;"/>
                                </td>
                            </tr>
                            <tr>
                                <th>성별구분코드 *</th>
                                <td>
                                    <input type="password" style="width: 100%;"/>
                                </td>
                            </tr>
                            <tr>
                                <th>휴대전화번호 *</th>
                                <td>
                                    <input type="text" style="width: 100%;"/>
                                </td>
                            </tr>
                            <tr>
                                <th>일반전화번호 *</th>
                                <td>
                                    <input type="text" style="width: 100%;"/>
                                </td>
                            </tr>
                            <tr>
                                <th>이메일주소 *</th>
                                <td>
                                    <input type="text" style="width: 100%;"/>
                                </td>
                            </tr>
                            <tr>
                                <th>우편번호 *</th>
                                <td>
                                    <input type="text" style="width: 100%;"/>
                                </td>
                            </tr>
                            <tr>
                                <th>주소 *</th>
                                <td>
                                    <input type="text" style="width: 100%;"/>
                                </td>
                            </tr>
                            <tr>
                                <th>상세주소 *</th>
                                <td>
                                    <input type="text" style="width: 100%;"/>
                                </td>
                            </tr>
                             <tr>
                                <th>일반회원 상태코드 *</th>
                                <td>
                                    <input type="text" style="width: 100%;"/>
                                </td>
                            </tr>


                        </tbody>
                    </table>
                    <div style="float: right;">
                        <button type="button" onClick="fn_goMemberList()">목록</button>
                        <button type="button" >저장</button>
                    </div
                </div>
            </div>
        </div>
    </div>

</form>

<<script type="text/javascript">


document.addEventListener('keydown', function(event) {
    if (event.keyCode === 13) {
        event.preventDefault();
    }
}, true);


// 회원 리스트로 이동
function fn_goMemberList () {
    location.href ="${pageContext.request.contextPath}/member/management/viewMemberList";
}


</script>




