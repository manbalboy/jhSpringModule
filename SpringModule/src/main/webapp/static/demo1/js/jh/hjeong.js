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