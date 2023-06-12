<%@ page import="com.example.pathfinder.dto.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.pathfinder.util.CmmUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
    UserDTO userDTO = (UserDTO) session.getAttribute("user");

%>
<script>

    function goList(){
        location.href="/admin"
    }
    function doSubmit(f){
        if(f.title.value == ""){
            alert("제목을 입력하시기 바랍니다.");
            f.title.focus();
            return false;
        }

        if(calBytes(f.title.value) > 200){
            alert("최대 200Bytes까지 입력 가능합니다.");
            f.title.focus();
            return false;
        }

        if(f.contents.value == ""){
            alert("내용을 입력하시기 바랍니다.");
            f.contents.focus();
            return false;
        }

        if(calBytes(f.contents.value) > 500){
            alert("최대 500Bytes까지 입력 가능합니다.");
            f.contents.focus();
            return false;
        }


    }
</script>

<head>
    <style>
        @import url(https://fonts.googleapis.com/css?family=Open+Sans:400,700);

        body {
            background: #456;
            font-family: 'Open Sans', sans-serif;
        }

        .login {
            width: 400px;
            margin: 16px auto;
            font-size: 16px;
        }

        /* Reset top and bottom margins from certain elements */
        .login-header,
        .login p {
            margin-top: 0;
            margin-bottom: 0;
        }

        /* The triangle form is achieved by a CSS hack */
        .login-triangle {
            width: 0;
            margin-right: auto;
            margin-left: auto;
            border: 12px solid transparent;
            border-bottom-color: #28d;
        }

        .login-header {
            background: #28d;
            padding: 20px;
            font-size: 1.4em;
            font-weight: normal;
            text-align: center;
            text-transform: uppercase;
            color: #fff;
        }

        .login-container {
            background: #ebebeb;
            padding: 12px;
        }

        /* Every row inside .login-container is defined with p tags */
        .login p {
            padding: 12px;
        }

        .login input {
            box-sizing: border-box;
            display: block;
            width: 100%;
            border-width: 1px;
            border-style: solid;
            padding: 16px;
            outline: 0;
            font-family: inherit;
            font-size: 0.95em;
        }

        .login input[type="email"],
        .login input[type="password"] {
            background: #fff;
            border-color: #bbb;
            color: #555;
        }

        /* Text fields' focus effect */
        .login input[type="email"]:focus,
        .login input[type="password"]:focus {
            border-color: #888;
        }

        .login input[type="button"] {
            background: #28d;
            border-color: transparent;
            color: #fff;
            cursor: pointer;
        }

        .login input[type="button"]:hover {
            background: #17c;
        }

        /* Buttons' focus effect */
        .login input[type="button"]:focus {
            border-color: #05a;
        }

        .input-file-button{
            padding: 6px 25px;
            background-color:#0d6efd;
            border-radius: 4px;
            color: white;
            cursor: pointer;
        }

        .submitBtn{
            background-color: #17c;
            border: #17c;
        }

        body>.grid {
            height: 100%;
        }

        .image {
            margin-top: -100px;
        }

        .column {
            max-width: 850px;
            max-height: 1200px;
        }

    </style>

</head>
<body onload="doOnload()">
<div class="login">


    <h2 class="login-header">공지 작성</h2>
    <div class="login-container">

        <form method="post" class="ui large form" encType="multipart/form-data" action="/noticeReg" onsubmit="return doSubmit(this);">
            <div class="ui stacked segment">
                <div class="field">
                    <h4 align="left">공지 제목</h4>
                    <input type="text" id="title" name="title" placeholder="제목" autocomplete="off" autofocus="autofocus">
                </div>
                <div class="field">
                    <h4 align="left">작성자</h4>
                    <input type="text" id="adminName" name="adminName" autocomplete="off" autofocus="autofocus" value="<%=userDTO.getUserName()%>" readonly>
                </div>
                <div class="field">
                    <h4 align="left">공지 내용</h4>
                    <div class="ui left icon input">
                        <textarea style="resize: vertical;" id="contents" name="contents" placeholder="공지 내용" rows="8"></textarea>
                    </div>
                </div>
                <div class="ui fluid large teal submit button" type="submit" id="write_bbs">
                    <input class="submitBtn" type="submit" value="공지 작성">
                </div>
                <br>
                <div class="ui fluid large teal submit button" type="submit" id="writebbs">
                    <input class="submitBtn" type="button" onclick="goList()" value="목록">
                </div>
            </div>
        </form>

    </div>
</div>
</body>