<!-- Import Reference Class -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat,java.util.Date,java.io.*" %>
<%

    String selectType = request.getParameter("selectType");
    String basicClassPath = request.getParameter("basicClassPath");
    String classPath = request.getParameter("classPath");
    String classNm = request.getParameter("classNm");
    String localPath = request.getParameter("localPath");
    String selectPrj = request.getParameter("selectPrj");
    String tableName = request.getParameter("tableName");

    String source = request.getParameter("source");
    source = new String(source.getBytes("8859_1"),"UTF-8");
    try {
        String sPath = null;
        String sFileNm = null;
        String sLastPackage = null;

        if(selectType.equals("interface")){
            //sPath = localPath + "/" + selectPrj + "/src/main/java/"+basicClassPath.replace(".", "/")+"/"+classPath.replace(".", "/")+"/service";
            sPath = localPath + "/" + selectPrj + "/src/"+basicClassPath.replace(".", "/")+"/"+classPath.replace(".", "/")+"/service";
            sFileNm = classNm + "Service.java";
        }else if(selectType.equals("Impl")){
            //sPath = localPath + "/" + selectPrj + "/src/main/java/"+basicClassPath.replace(".", "/")+"/"+classPath.replace(".", "/")+"/service/impl";
            sPath = localPath + "/" + selectPrj + "/src/"+basicClassPath.replace(".", "/")+"/"+classPath.replace(".", "/")+"/service/impl";
            sFileNm = classNm + "ServiceImpl.java";
        }else if(selectType.equals("saveMaps")){
            sPath = localPath + "/" + selectPrj + "/profile/common/resources/"+basicClassPath.replace(".", "/")+"Mapper"+"/"+classPath.replace(".", "/");
            //sFileNm = "V2_WRITE_" + tableName + ".xml";
            sFileNm = tableName + "_mapper.xml";
        }else if(selectType.equals("selcetMaps")){
            sPath = localPath + "/" + selectPrj + "/src/main/resources/sqlmap/mapper/"+classPath.replace(".", "/");
            /*
            sLastPackage = sGetSplitLast(classPath, ".");
            sFileNm = sLastPackage + ".xml";
            */

            sFileNm = "V2_READ_" + classNm + ".xml";
        }

        System.out.println("sPath======>"+sPath);
        System.out.println("sFileNm======>"+sFileNm);

        File fPath  = new File(sPath);
        System.out.println("1");
        if (!fPath.exists()){
        System.out.println("2");
            fPath.mkdirs();
        System.out.println("3");
        }
        System.out.println("4");

        File fImpl  = new File(sPath+"/"+sFileNm);
        System.out.println(fImpl.getPath());
        System.out.println(fImpl.getName());

        fImpl.createNewFile();
        System.out.println("6");

        BufferedWriter sourceOut = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(sPath+"/"+sFileNm), "utf-8"));

        sourceOut.write(source);

        sourceOut.flush();

        out.println("파일이 생성되었습니다.");
        sourceOut.close();
    } catch (Exception e) {
        System.out.println(e);
    } finally {

    }
%>

<html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- <link rel="stylesheet" href="/include/css/style.css" type="text/css"> -->
<title></title>
<script language="javascript">
//alert("1111111");
</script>
</head>
<body style="margin:0">

</body>
</html>
<%!

private String getInitCap(String str) {

    String first = str.substring(0,1).toUpperCase();
    str = str.substring(1);
    str = str.toLowerCase();

    boolean under = false;
    String strone = null;
    String sResultStr = "";

    for(int i=0;i < str.length();i++){

        strone = str.substring(i,i+1);

        if(!strone.equals("_") && !under){
            under = false;
            sResultStr = sResultStr + strone;
            continue;
        }else if(under){
            under = false;

        }else{
            under = true;
            continue;
        }


        char h = strone.charAt(0);

        if(h >= 'a' && h <= 'z')
        {
            sResultStr = sResultStr + String.valueOf((char) (h - 32));
        }
    }

    return first + sResultStr;

}

private String[] sGetSplit(String str, String delimeter)
{
    StringTokenizer st = new StringTokenizer(str, delimeter);
    String[] values = new String[st.countTokens()];
    int pos = 0;
    while (st.hasMoreTokens())
    {
        values[pos++] = st.nextToken();
    }
    return values;
}

private String sGetSplitLast(String str, String delimeter)
{
    String s[] = sGetSplit(str, delimeter);

    return s[s.length-1];
}

%>