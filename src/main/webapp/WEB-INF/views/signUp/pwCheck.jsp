<%@ page import="com.example.pathfinder.dto.UserDTO" %>
<%@ page import="com.example.pathfinder.dto.BoardDTO" %>
<%@ page import="com.example.pathfinder.util.UseSha256" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    UserDTO uDTO = (UserDTO) session.getAttribute("user");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="https://github.com/MinJunjang1/my2022PRJ/blob/7adfa4c9dc7a20b427ada2a2ad3e15a328089c3a/src/main/webapp/WEB-INF/views/js/seouljs.js"></script>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>마이페이지</title>
    <style type="text/css">
        .main{
            padding-top: 80px;
            text-align: center;
            max-width: 600px;
            height: 60%;
            padding-right:15px;
            padding-left:15px;
            margin-right:auto;
            margin-left:auto

        }
    </style>

</head>
<body>
<div class="main">
    <form method="post" action="/user/pwCheck">
        <div>
            <h3>비밀번호를 입력해주세요</h3>
        </div>
        <div>
            <input type="password" id="userPw" name="userPw">
            <input type="hidden" id="userNo" name="userNo" value="<%=uDTO.getUserNo()%>">
            <input type="submit" value="확인">
        </div>
    </form>
</div>
</body>
</html>