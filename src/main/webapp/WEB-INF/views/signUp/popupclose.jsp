<%@ page import="com.example.pathfinder.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%

    //전달받은 메시지
    String msg = CmmUtil.nvl((String)request.getAttribute("msg"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title></title>
    <script type="text/javascript">
        alert("<%=msg%>");
        opener.parent.location='/LoginPage';
        window.close()
    </script>
</head>
<body>

</body>
</html>