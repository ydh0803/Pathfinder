<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
    </style>

</head>
<body>
<div class="login">


    <h2 class="login-header">로그인</h2>

    <form class="login-container" method="POST" action="/login">
        <p><input type="text" id="userid" name="userid" placeholder="아이디"></p>
        <p><input type="password" id="userpwd" name="userpwd" placeholder="비밀번호"></p>
        <p><input type="submit" value="로그인"><input type="button" onClick="location.href='signUp'" value="회원가입" ></p>
        <p><input type="button" value="아이디 찾기"><input type="button" value="비밀번호 찾기"></p>

        <a onclick="window.open('/findIdPw','회원가입페이지','height=600, width=800 location=center')">아이디&nbsp;|&nbsp;비밀번호찾기</a>
    </form>
</div>
</body>