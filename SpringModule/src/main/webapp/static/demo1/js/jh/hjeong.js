console.log(`

██████╗ ██████╗  ██████╗ ██████╗     ██████╗ ██╗   ██╗
██╔══██╗██╔══██╗██╔═══██╗██╔══██╗    ██╔══██╗╚██╗ ██╔╝
██████╔╝██████╔╝██║   ██║██║  ██║    ██████╔╝ ╚████╔╝
██╔═══╝ ██╔══██╗██║   ██║██║  ██║    ██╔══██╗  ╚██╔╝
██║     ██║  ██║╚██████╔╝██████╔╝    ██████╔╝   ██║
╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═════╝     ╚═════╝    ╚═╝

`)

console.log(`정훈

███╗   ███╗ █████╗ ███╗   ██╗██████╗  █████╗ ██╗     ██████╗  ██████╗ ██╗   ██╗
████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔══██╗██║     ██╔══██╗██╔═══██╗╚██╗ ██╔╝
██╔████╔██║███████║██╔██╗ ██║██████╔╝███████║██║     ██████╔╝██║   ██║ ╚████╔╝
██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██╗██╔══██║██║     ██╔══██╗██║   ██║  ╚██╔╝
██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝██║  ██║███████╗██████╔╝╚██████╔╝   ██║
╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝  ╚═════╝    ╚═╝
manbalboy@hanmail.net
`);

console.log(`최선길

██╗  ██╗██╗██╗   ██╗ ██████╗  ██████╗ ██╗██╗     ███████╗
██║  ██║██║╚██╗ ██╔╝██╔═══██╗██╔════╝ ██║██║     ██╔════╝
███████║██║ ╚████╔╝ ██║   ██║██║  ███╗██║██║     ███████╗
██╔══██║██║  ╚██╔╝  ██║   ██║██║   ██║██║██║     ╚════██║
██║  ██║██║   ██║   ╚██████╔╝╚██████╔╝██║███████╗███████║
╚═╝  ╚═╝╚═╝   ╚═╝    ╚═════╝  ╚═════╝ ╚═╝╚══════╝╚══════╝
hiyogils@gmail.com
`);

 console.log(`박서은

 █████╗ ██████╗ ██╗  ██╗██╗   ██╗██╗   ██╗██╗███╗   ██╗
██╔══██╗╚════██╗╚██╗██╔╝██║   ██║╚██╗ ██╔╝██║████╗  ██║
╚█████╔╝ █████╔╝ ╚███╔╝ ██║   ██║ ╚████╔╝ ██║██╔██╗ ██║
██╔══██╗██╔═══╝  ██╔██╗ ██║   ██║  ╚██╔╝  ██║██║╚██╗██║
╚█████╔╝███████╗██╔╝ ██╗╚██████╔╝   ██║   ██║██║ ╚████║
 ╚════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝╚═╝  ╚═══╝
82xuyin@gmail.com
`);





 /////////////바이트 계산 //////////////////
 var calByte = {
         getByteLength : function(s) {

             if (s == null || s.length == 0) {
                 return '';
             }
             var size = 0;

             for ( var i = 0; i < s.length; i++) {
                 size += this.charByteSize(s.charAt(i));
             }

             return size;
         },

         cutByteLength : function(s, len) {

             if (s == null || s.length == 0) {
                 return '';
             }
             var size = 0;
             var rIndex = s.length;

             for ( var i = 0; i < s.length; i++) {
                 size += this.charByteSize(s.charAt(i));
                 if( size == len ) {
                     rIndex = i + 1;
                     break;
                 } else if( size > len ) {
                     rIndex = i;
                     break;
                 }
             }

             return s.substring(0, rIndex);
         },

         charByteSize : function(ch) {

             if (ch == null || ch.length == 0) {
                 return 0;
             }

             var charCode = ch.charCodeAt(0);

             if (charCode <= 0x00007F) {
                 return 1;
             } else if (charCode <= 0x0007FF) {
                 return 2;
             } else if (charCode <= 0x00FFFF) {
                 return 3;
             } else {
                 return 4;
             }
         }
     };

/*
      charByteSize(ch) : 한글자에 대한 byte를 계산합니다.
      getByteLength(s) : 입력된 글자 전체의 byte를 계산해서 알려줍니다.
      cutByteLength(s) : 원하는 byte 만큼 글자를 잘라서 반환합니다.

     UTF-8은 자리수에 따라서 표현되는 문자가 다릅니다. ASCII의 경우 1byte로 표시되고 라틴문자 그리스문자 등은 2byte로 표시되는데, 자리수에 따라 아래와 같이 표현이 됩니다.
     1byte 이진법 표현 : 0xxxxxxx(0x000000 ~ 0x00007F)
     ASCII 영역에서 사용하는 영역과 동일합니다.
     숫자 1을 표현하게 되면 0000 0031로 나타내게 됩니다.

     2byte 이진법 표현: 110xxxxx 10xxxxxx(0x000080 ~ 0x0007FF)
     2Byte로 표현하는 경우 첫 byte는 110이 앞에 붙고 2번째 byte의 경우 10이 붙습니다.

     3byte 이진법 표현: 1110xxxx 10xxxxxx 10xxxxxx(0x000800 ~ 0x00FFFF)
     3byte로 표현하는 경우 첫 byte는 1110, 2번째 Byte는 10, 3번째 Byte에는 10이 붙습니다.

     4byte 이진법 표현: 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
     (0x010000 ~ 0x10FFFF)
     4byte로 표현하는 경우 첫 byte는 11110, 2번째는 10, 3번째는 10, 4번째는 10이 붙습니다.

*/



 // 이벤트 리스너 등록
 document.addEventListener('keydown', function(event) {
     if (event.target.dataset.maxbyte ) { // 속성이 존재할 경우
     console.log(calByte.cutByteLength( event.target.value, event.target.dataset.maxbyte ))
         event.target.value = calByte.cutByteLength( event.target.value, Number(event.target.dataset.maxbyte) )
     };
 });
 document.addEventListener('keyup', function(event) {
     if (event.target.dataset.maxbyte) { // 속성이 존재할 경우
         event.target.value = calByte.cutByteLength( event.target.value, event.target.dataset.maxbyte )
     };
 });
 document.addEventListener('focusout', function(event) {
     if (event.target.dataset.maxbyte) { // 속성이 존재할 경우
         event.target.value = calByte.cutByteLength( event.target.value, event.target.dataset.maxbyte )
     };
 });



 let jhUtil = {};

 // Ajax 감싸줌 .  기본값 셋팅    필수는 url!
 jhUtil.callAjax = function (oOption) {
     if(jhUtil.isEmpty(oOption.async)) { oOption.async = true; } // 동기 유무
     if(jhUtil.isEmpty(oOption.cache)) { oOption.cache = false; } // 브라우저에 의해 요청되는 페이지를 캐시 여부
     if(jhUtil.isEmpty(oOption.enctype)) { oOption.enctype = ""; }
     if(jhUtil.isEmpty(oOption.callBackFunction)) { oOption.callBackFunction = jhUtil.commCallBak }


/*   processData
 *   ajax 통신을 통해 데이터를 전송할때, 기본적으로 key와 value값을 Query String으로 변환해서 보낸다.
 *   데이터 값에 따라 (key=value&key=value) 또는 (key:value, key:value) 이런 식으로 보내게되는데,
 *   이때 이 processData가 false로 되어 있으면 Query String으로 설정하지 않는다.
 *   processData는 파일 전송 시에 사용한다고 한다
 */
     if(jhUtil.isEmpty(oOption.processData)) { oOption.processData = true; }
   //서버에 데이터를 보낼 때 사용 content - type 헤더의 값
     if(jhUtil.isEmpty(oOption.contentType)) { oOption.contentType = "application/x-www-form-urlencoded;charset=UTF-8"; }
     if(oOption.data != undefined && oOption.contentType == "application/json;") {
         oOption.data = JSON.stringify(oOption.data);
     }

     $.ajax({
        type: oOption.type || "POST",
        url: oOption.url,
        data : oOption.data || "",
        async: oOption.async,
        cache: oOption.cache,
        dataType: oOption.dataType || "json",
        processData: oOption.processData,
        contentType: oOption.contentType,
        enctype: oOption.enctype,

        timeout: oOption.timeout || 30000, // 30초
        error: function(XMLHttpRequest, textStatus, errorThrown) { // 에러
        },
        beforeSend: function(xhr, option){ // http 요청 전에 발생하는 이벤트
        },
        complete: function () { // 요청완료시 성공, 실패, 에러등 모든상황이 종료된 이후의 함수 호출
        },
        success: function(data , mag , info){ // 성공
            oOption.callBackFunction(data , oOption.sId);
        }
     })
 };

 //Ajax 콜백 함수 정의 해주지 않았을때 디폴트 콜백
 jhUtil.commCallBak = function (data , sId) {
    alert("완료되었습니다.");
 };


 // 빈값 체크
 jhUtil.isEmpty =  function (value) {
     if (value === null) { return true }
     if (typeof value === 'undefined') { return true }
     if (typeof value === 'string' && value === '') { return true }
     if (Array.isArray(value) && value.length < 1) { return true }
     if (typeof value === 'object' && value.constructor.name === 'Object' && Object.keys(value).length < 1 && Object.getOwnPropertyNames(value) < 1) { return true }
     if (typeof value === 'object' && value.constructor.name === 'String' && Object.keys(value).length < 1) { return true } // new String()
     return false;
 };