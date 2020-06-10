<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

테스트 첫번째 페이지에 오신걸 환영합니다
<div id="list">
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
</div>

<script>
$(document).on('click','.page-item',function(){
    pagination.getList($(this).data('page'));
});
$(function(){
    //totalCnt ,currentPage ,targetId
    pagination.init('pageNavi', getList); //실행 함수 전달
});

function getList(page =1){
    var objThis = pagination.getList || this;
     $('#list').load('<c:url value="/demo1/sample/sample2" />?currentPage='+page , function(){
         pagination.init('pageNavi' , objThis);
   });;
}

/*
 * 페이지 네이션 사용법
 1 페이지 네이션 그릴 위치 선정 아래 와 같은 화면을 제작 한다.
 1.1 <div id="pageNavi" data-total-cnt="${list2[0].TOTAL_CNT}" data-current-page="${not empty param.currentPage ? param.currentPage : 1}"></div>
 1.2 페이지 로드후 pageNavi는 여러개 있을경우 뒤에 숫자로 또는 임의 지정후 입력 파라미터로 아이디 값을 넘겨줌 pagination.init('pageNavi' ,제작 함수 넘겨줌);
 1.3 1.2ex) function getList(page =1){ ~~~~~~ 참고
 1.3 현재 버전에서는 pagination.getList 함수가 실행 되게 되어 있는데 업그레이드 해야함 실행함수 지정할수 있게
 */


 pagination = {
        cntPerBlock : 10 //페이지나비에 보여질 페이지수
        ,cntPerPage : 10 //한페이지에 출력될 목록수
        ,totalCnt : 21 //조회 결과수
        ,currentPage : 2 //현재 보여지는 페이지 번호
        ,getTotalPage : function(){return Math.ceil(this.totalCnt / this.cntPerPage );}  //전체 페이지수
        ,getTotalBlock : function() {return Math.ceil(this.getTotalPage()/this.cntPerBlock );} //전체 블락수
        ,getCurrentBlock : function(){return Math.ceil(this.currentPage / this.cntPerBlock) ;} //현재 블락번호
        ,getPreBtnPage : function(){return (this.getCurrentBlock() - 1) * this.cntPerBlock   ;} //이전 버튼 페이지 번호
        ,getNextBtnPage : function(){return (this.getCurrentBlock()) * this.cntPerBlock +1 ;} //이전 버튼 페이지 번호
        ,hasPreBtn : function(){return this.currentPage > 1;} //이전 버튼(<) 유무
        ,hasPreBlockBtn : function(){return this.getCurrentBlock() > 1;} // 이전 블락 버튼(<<) 노출 유무
        ,hasNextBtn : function(){return this.getTotalPage() > this.currentPage;} //다음페이지 버튼(>) 유무
        ,hasNextBlockBtn : function(){return this.getTotalBlock() > this.getCurrentBlock();} // 다음 블락 버튼(>>) 노출 유무
        ,printNavi : function(){
            console.log('printNavi');
            //블라블라
            var $ul = $('<ul class="pagination" id="pagination">');
            //todo 페이지 이동 펑션 정의 , 링크로 get방식 이동 정의
            var templatePreviousDom = '<li class="page-item" data-page="{{pageNum}}"><a class="page-link" href="#">Previous</a></li>';
            var templatePagingDom = '<li class="page-item" data-page="{{pageNum}}"><a class="page-link" href="#">{{pageNum}}</a></li>';
            var templateNextDom = '<li class="page-item" data-page="{{pageNum}}"><a class="page-link" href="#">Next</a></li>';
            //이전 삽입
            if(this.hasPreBtn()){
                templatePreviousDom = templatePreviousDom.replace(/{{pageNum}}/gi , this.getPreBtnPage());
                $ul.append(templatePreviousDom);
            }
            var beginPageNum = parseInt(1 + (this.getCurrentBlock() - 1) * this.cntPerBlock);

            //돌리고
            if(this.hasNextBlockBtn()){
                for(var i = 0 ; i < this.cntPerBlock ; i ++){
                    var pageNum = beginPageNum + i;
                    var pageHtml = templatePagingDom.replace(/{{pageNum}}/gi , pageNum);
                    $ul.append($(pageHtml));
                }
            }else{
                var isMod0 = this.getTotalPage() % this.cntPerBlock;
                if(isMod0 == 0){
                    for(var i = 0 ; i < this.cntPerBlock ; i ++){
                        var pageNum = beginPageNum + i;
                        var pageHtml = templatePagingDom.replace(/{{pageNum}}/gi , pageNum);
                        if(this.currentPage == pageNum){
                            $(pageHtml).addClass('active');
                        }
                        $ul.append($(pageHtml));
                    }
                }else{
                    for(var i = 0 ; i < (this.getTotalPage() % this.cntPerBlock) ; i ++){
                        var pageNum = beginPageNum + i;
                        var pageHtml = templatePagingDom.replace(/{{pageNum}}/gi , pageNum);
                        $ul.append(pageHtml);
                    }
                }
            }
            //다음 삽입 todo
            if(this.hasNextBtn()){
                templateNextDom = templateNextDom.replace(/{{pageNum}}/gi , this.getNextBtnPage());
                $ul.append(templateNextDom);
            }
           //다음 블록 삽입 todo
             $ul.find('[data-page='+this.currentPage+']').addClass('active');
            return $ul;
        },init : function(targetId ,fn_obj ){ //초기화 메소드

            this.getList = fn_obj;
            this.totalCnt = $('#'+targetId).attr('data-total-cnt');;
            this.currentPage = $('#'+targetId).attr('data-current-page');

            $('#'+targetId).html(this.printNavi());

        },valid : function(totalCnt ,currentPage ,targetId){
            //todo
            //현재 페이지가 음수있때
            //현재페이지가 전체 페이지보다 클때
            //targetId가 비정상일때

        },log : function(){ //로그 출력용
        }
    }
</script>