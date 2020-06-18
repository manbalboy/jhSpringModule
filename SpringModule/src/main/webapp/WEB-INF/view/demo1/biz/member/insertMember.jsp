<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- Begin Page Content -->

<style>

/* TODO : 모달창 css 추후 모달찰 컴포넌트 모듈 추가해야함 */
/* The Modal (background) */
.searchModal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 10; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}
/* Modal Content/Box */
.search-modal-content {
    background-color: #fefefe;
    margin: 15% auto; /* 15% from the top and centered */
    padding: 20px;
    border: 1px solid #888;
    width: 70%; /* Could be more or less, depending on screen size */
}
</style>



<form name="saveForm" action="${pageContext.request.contextPath}/member/management/insertMember" >
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
                                    <input type="text" name="memberId" disabled="disabled" style="width: 80%;" data-maxbyte="20" data-valid='required'/>
                                    <button type="button" onclick="fn_showIdChk('modalIdChk')">중복아이디 검사</button>
                                </td>
                            </tr>
                            <tr>
                                <th>일반회원이름 *</th>
                                <td>
                                    <input type="text" name="memberName" style="width: 80%;" data-maxbyte="50" data-valid='required'/>
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호 *</th>
                                <td>
                                    <input type="password" name="password" style="width: 80%; ime-mode:disabled;" data-maxbyte="50" data-valid='required' />
                                    <span data-target="password"  style="width: 20%;" ></span>
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호확인 *</th>
                                <td>
                                    <input type="password" name="passwordChk" style="width: 80%; ime-mode:disabled;" data-maxbyte="50"/>
                                    <span data-target="passwordChk"  style="width: 20%;" ></span>
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호힌트 *</th>
                                <td>
                                    <select name="passwordHintContents" style="width: 80%;" >
                                        <c:forEach items="${listMEM002}" var="statusRow">
                                             <option value="${statusRow.code}">${statusRow.codeName}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호정답 *</th>
                                <td>
                                    <input type="text" name="passwordCnsrContents" style="width: 80%;" data-maxbyte="500"/>
                                </td>
                            </tr>
                            <tr>
                                <th>성별구분코드 *</th>
                                <td>
                                    <select name="sexdstnCode" style="width: 80%;" >
                                        <c:forEach items="${listMEM003}" var="statusRow">
                                             <option value="${statusRow.code}">${statusRow.codeName}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>휴대전화번호 *</th>
                                <td>
                                    <input type="text" name="mobilePhoneNumber" style="width: 100%;" data-maxbyte="20" data-valid='required'/>
                                </td>
                            </tr>
                            <tr>
                                <th>일반전화번호 *</th>
                                <td>
                                    <input type="text" name="phoneNumber" style="width: 100%;" data-maxbyte="20"/>
                                </td>
                            </tr>
                            <tr>
                                <th>이메일주소 *</th>
                                <td>
                                    <input type="email" name="memberEmailAddress" style="width: 100%;" data-maxbyte="60" data-valid='required'/>
                                </td>
                            </tr>
                            <tr>
                                <th>우편번호 *</th>
                                <td>
                                    <input type="text" name="zipCode" style="width: 100%;" data-maxbyte="6"/>
                                </td>
                            </tr>
                            <tr>
                                <th>주소 *</th>
                                <td>
                                    <input type="text" name="address" style="width: 100%;" data-maxbyte="100"/>
                                </td>
                            </tr>
                            <tr>
                                <th>상세주소 *</th>
                                <td>
                                    <input type="text" name="detailAddress" style="width: 100%;" data-maxbyte="100"/>
                                </td>
                            </tr>
                             <tr>
                                <th>일반회원 상태코드 *</th>
                                <td>
                                    <select name="memberStatusCode" style="width: 100%;" >
                                        <c:forEach items="${listMEM001}" var="statusRow">
                                             <option value="${statusRow.code}">${statusRow.codeName}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div style="float: right;">
<!--                         <button type="button" onClick="fn_test()">테스트</button> -->
                        <button type="button" onClick="fn_goMemberList()">목록</button>
                        <button type="button" onClick="fn_save();">저장</button>
                    </div
                </div>
            </div>
        </div>
    </div>

</form>

<div id="modalIdChk" class="searchModal">
    <div class="search-modal-content">
        <div class="border-bottom-info">
            <h3>아이디 중복 확인</h3>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <div class="row">
                    <div class="col-sm-12">
                        <br>
                        <span>사용할 아이디  :  </span> <input name="chkId" type="text" data-maxbyte="20"/>
                        <br>
                        <span>결과  :  </span> <span name="chkIdResult">중복확인을 실행하십시오.</span>
                    </div>
                </div>
            </div>
        </div>
        <hr>
        <button type="button" onClick="fn_searchIdCheck('selectIdCheck');"><span class="pop_bt modalCloseBtn" style="font-size: 13pt;">확인</span></button>
        <button type="button" onClick="fn_searchIdCheck('searchIdCheck');"><span class="pop_bt modalCloseBtn" style="font-size: 13pt;">조회</span></button>
        <button type="button" onClick="fn_closeModal('modalIdChk');"><span class="pop_bt modalCloseBtn" style="font-size: 13pt;">닫기</span></button>
    </div>
</div>

<script type="text/javascript">

// 폼 서브밋 엔터 막기
document.addEventListener('keydown', function(event) {
    if (event.keyCode === 13) {
        event.preventDefault();
    }
}, true);

// function fn_test (){
//     let oObjs = document.querySelectorAll("[type=password]");
//     for(let oObj of oObjs) {
//         console.log(oObj.value);
//     }
// }

// 회원 리스트로 이동
function fn_goMemberList () {
    location.href ="${pageContext.request.contextPath}/member/management/viewMemberList";
}

//모달오픈
function fn_showIdChk (sObjId) {
    $('#'+sObjId).show();
}

//모달 닫기
function fn_closeModal(sObjId) {
    $('#'+sObjId).hide();
};

//선택 ID 모달창의 값을 화면으로 보내줌


//사용 할 수 있는 ID 인지 조회한다.
function fn_searchIdCheck (sId) {
    // 빈값입력시
    if(jhUtil.isEmpty(document.querySelector("[name=chkId]").value)) {
        document.querySelector("[name=chkId]").focus();
        document.querySelector("[name=chkIdResult]").style.color = "red";
        document.querySelector("[name=chkIdResult]").innerHTML = "사용할 ID를 입력해주세요.";

        return false;
    };

    jhUtil.callAjax({
        sId  : sId,
        data : {memberId : document.querySelector("[name=chkId]").value},
        type : "POST",
        url  : "${pageContext.request.contextPath}/member/management/checkIdAjax",
        dataType : "json",
        contentType: "application/json;",
        callBackFunction : fn_callBack
    });
};

//콜백 함수
function fn_callBack(reData, sId) {

    switch(sId) {
    // Id check
    case "searchIdCheck" :
    case "selectIdCheck" :
        if(reData.result == "Y") {
            document.querySelector("[name=chkIdResult]").style.color = "red";
            document.querySelector("[name=chkIdResult]").innerHTML = "ID가 중복 되었습니다. 다시 확인하세요";
        } else {
            document.querySelector("[name=chkIdResult]").style.color = "blue";
            document.querySelector("[name=chkIdResult]").innerHTML = "사용가능한 ID 입니다.";
        }
        break;
    }

    //선택 ID 모달창의 값을 화면으로 보내줌
    if(sId === "selectIdCheck"){
        if(reData.result != "Y") {
           document.querySelector("[name=memberId]").value= document.querySelector("[name=chkId]").value;
           fn_closeModal('modalIdChk');
        }
    }
};


//저장함수
function fn_save () {


    // 넘기기전에 memberId 변경
    $("input[name=memberId]").attr("disabled", false);
    document.saveForm.submit();
}


//2020/06/11 최조 작성중 오류가있는지 검증필요
var valid = {
    oObjs: []
    , chk: function () {
        //초기화
        valid.oObjs = [];
        var validDoms = document.querySelectorAll("input[data-valid] ,textarea[data-valid]");
        for (let oDom of validDoms) {
            let validType = oDom.dataset.valid.split("|");
            //필수값
            for (let type of validType) {
                var oObj = {}
                if (type === "required") {

                    if (jhUtil.isEmpty(oDom.value)) {

                        oObj.oObject = oDom;
                        //원하는 값
                        oObj.sMsg = oDom.dataset.validMsg || "필수값";

                        valid.oObjs.push(oObj);
                        oDom.placeholder = oObj.sMsg;
                        oDom.classList.toggle('err', true);
                    }
                }
                //number Chk
                if (type === "number") {
                    if (isNaN(Number(oDom.value))) {
                        oObj.oObject = oDom;
                        oObj.sMsg = isEmpty(oDom.value) ? "숫자만" : oObj.sMsg + ", 숫자만";

                        //원하는 값
                        oObj.sMsg = oDom.dataset.validMsg || oObj.sMsg;
                        valid.oObjs.push(oObj);
                    }
                }
            }
            //오브젝트를 push 한다.
            //처리하는 함수를 만들고 처리한다.
        }

        if (valid.oObjs.length == 0) {
            return true;
        } else {
            return false;
        }

    },

}



document.addEventListener('keydown', function (event) {

    if(event.target.type === "password") {
        fn_passwordChk(event);
    };
});
document.addEventListener('keyup', function (event) {
    if(event.target.type === "password") {
        fn_passwordChk(event);
    };
});
document.addEventListener('focusout', function (event) {
    if(event.target.type === "password") {



    };
});



function fn_passwordChk () {
     document.querySelector('[data-target=password]').textContent = "";
     document.querySelector('[data-target=passwordChk]').textContent =  "";
     let pw = document.querySelector('[name=password]').value;
     let pwChk = document.querySelector('[name=passwordChk]').value;


     if(jhUtil.isEmpty(pw) || jhUtil.isEmpty(pwChk)) {

     } else if(pw === pwChk){
         document.querySelector('[data-target=password]').textContent = "비밀번호 일치함";
         document.querySelector('[data-target=passwordChk]').textContent =  "비밀번호 일치함";
     } else if(pw !== pwChk) {
         document.querySelector('[data-target=password]').textContent = "비밀번호 일치하지 않음";
         document.querySelector('[data-target=passwordChk]').textContent =  "비밀번호 일치하지 않음";
     }
}






</script>
