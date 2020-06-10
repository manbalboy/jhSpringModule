<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<html>

<head>
	<title>luv2code SYSTEMS Home Page</title>
</head>

<body>
<hr>
<p>
    URL SYSTEM...
	<br>
</p>
<hr>
<div>나비</div>
<div id="pageNavi"></div>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
</body>
<script>
$(function(){
	//totalCnt ,currentPage ,targetId
	pagination.init(11,1,'pageNavi');
});
pagination = {
		cntPerBlock : 10 //페이지나비에 보여질 페이지수
		,cntPerPage : 10 //한페이지에 출력될 목록수
		,totalCnt : 21 //조회 결과수
		,currentPage : 2 //현재 보여지는 페이지 번호
		,getTotalPage : function(){return Math.ceil(this.totalCnt / this.cntPerPage );}  //전체 페이지수
		,getTotalBlock : function() {return Math.ceil(this.getTotalPage()/this.cntPerBlock );} //전체 블락수
		,getCurrentBlock : function(){return Math.ceil(this.currentPage / this.cntPerBlock) ;} //현재 블락번호
		,hasPreBtn : function(){return this.currentPage > 1;} //이전 버튼(<) 유무
		,hasNextBtn : function(){return this.getTotalPage() > this.currentPage;} //다음페이지 버튼(>) 유무
		,hasPreBlockBtn : function(){return this.getCurrentBlock() > 1;} // 이전 블락 버튼(<<) 노출 유무
		,hasNextBlockBtn : function(){return this.getTotalBlock() > this.getCurrentBlock();} // 다음 블락 버튼(>>) 노출 유무
		,printNavi : function(){
		//블라블라
		var $ul = $('<ul class="pagination" id="pagination">');
		//todo 페이지 이동 펑션 정의 , 링크로 get방식 이동 정의 
	    var templatePreviousDom = '<li class="page-item"><a class="page-link" href="#">Previous</a></li>';
	    var templatePagingDom = '<li class="page-item"><a class="page-link" href="#">{{pageNum}}</a></li>'; 
	    var templateNextDom = '<li class="page-item"><a class="page-link" href="#">Next</a></li>';
	    //이전 삽입
	    if(this.hasPreBtn()){
	    	$ul.append(templatePreviousDom);
	    }
	    var beginPageNum = parseInt(1 + (this.getCurrentBlock() - 1) * this.cntPerBlock);
	    
	    //돌리고
	    if(this.hasNextBlockBtn()){
	    	for(var i = 0 ; i < this.cntPerBlock ; i ++){
	    		var pageNum = beginPageNum + i;
	    		var pageHtml = templatePagingDom.replace('{{pageNum}}' , pageNum);
	    		$ul.append(pageHtml);
	    	}
	    }else{
	    	var isMod0 = this.getTotalPage() % this.cntPerBlock;
	    	if(isMod0 == 0){
	    		for(var i = 0 ; i < this.cntPerBlock ; i ++){
		    		var pageNum = beginPageNum + i;
		    		var pageHtml = templatePagingDom.replace('{{pageNum}}' , pageNum);
		    		$ul.append(pageHtml);
		    	}
	    	}else{
	    		for(var i = 0 ; i < (this.getTotalPage() % this.cntPerBlock) ; i ++){
		    		var pageNum = beginPageNum + i;
		    		var pageHtml = templatePagingDom.replace('{{pageNum}}' , pageNum);
		    		$ul.append(pageHtml);
		    	}
	    	}
	    }
	    //다음 삽입 todo
	   //다음 블록 삽입 todo
	    
		return $ul;
		}
		,init : function(totalCnt ,currentPage ,targetId ){ //초기화 메소드
			this.totalCnt = totalCnt;
			this.currentPage = currentPage;
			
			$('#'+targetId).html(this.printNavi());
		}
		,valid : function(totalCnt ,currentPage ,targetId){
			//todo
			//현재 페이지가 음수있때
			//현재페이지가 전체 페이지보다 클때
			//targetId가 비정상일때
			
		}
		,log : function(){ //로그 출력용
		console.log('cntPerBlock = %s,cntPerPage = %s,totalCnt = %s,currentPage = %s,getTotalPage = %s,getTotalBlock = %s' 
		, this.cntPerBlock, this.cntPerPage,this.totalCnt , this.currentPage, this.getTotalPage(), this.getTotalBlock())
		}
	}
</script>

<div style="display:none;">
	<ul class="pagination" id="pagination">
	    <li class="page-item"><a class="page-link" href="#">Previous</a></li>
	    <li class="page-item"><a class="page-link" href="#">1</a></li>
	    <li class="page-item"><a class="page-link" href="#">Next</a></li>
	  </ul>
</div>
</html>









