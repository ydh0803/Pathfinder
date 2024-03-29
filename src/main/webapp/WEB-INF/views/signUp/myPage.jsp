<%@ page import="com.example.pathfinder.dto.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    UserDTO uDTO = (UserDTO) session.getAttribute("user");
    String userName = uDTO.getUserName();
%>

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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function deleteUser() {
        console.log("탈퇴")
        if (confirm('정말 탈퇴하시겠습니까?')===true){
            location.href="/deleteUser?userNo=<%=uDTO.getUserNo()%>"
        }
    }

    function chgName() {
        window.open('/user/chgName','이름변경','width=800px,height=400px')
    }

    function getBookmark() {
        var userNo = <%=uDTO.getUserNo()%>;
        console.log(userNo);

        $.ajax({
            type: 'GET',  // 또는 'GET' 등 HTTP 요청 방법 설정
            url: '/bookmarkList',  // 요청을 보낼 URL 설정
            data: {userNo: userNo},  // 요청과 함께 전송할 데이터 설정
            success: function (response) {
                // 성공 시 실행할 동작을 여기에 작성합니다.
                console.log(response);
            },
            error: function (error) {
                // 오류 시 실행할 동작을 여기에 작성합니다.
                console.error(error);
            }
        });

    }

    function getStamp() {
        var userNo = <%=uDTO.getUserNo()%>;
        console.log(userNo);

        $.ajax({
            type: 'GET',  // 또는 'GET' 등 HTTP 요청 방법 설정
            url: '/stamp',  // 요청을 보낼 URL 설정
            data: {userNo: userNo},  // 요청과 함께 전송할 데이터 설정
            success: function (response) {
                // 성공 시 실행할 동작을 여기에 작성합니다.
                console.log(response);
            },
            error: function (error) {
                // 오류 시 실행할 동작을 여기에 작성합니다.
                console.error(error);
            }
        });

    }



</script>
</head>
<body>
<div class="login">


    <h2 class="login-header">마이페이지</h2>

    <form class="login-container">
        <p> 닉네임 : <%=uDTO.getUserName()%></p><a class="btn" onclick="chgName()"><strong style="color:blue">변경</strong></a>
        <p> 이메일 : <%=uDTO.getUserMailid()%>@<%=uDTO.getUserMaildomain()%></p>

        <a onclick="window.open('/pwCheck','비밀번호 변경','width=600 height=400')">비밀번호 변경</a><br/><br/>

        <a href="/calendar">일정</a><br/><br/>
        <a href="/bookmark">북마크</a><br/><br/>
        <a href="/stamp">방문 인증</a><br/><br/>
        <a href="/logOut">로그아웃</a><br/>
        <button onclick="deleteUser()">탈퇴</button>


    </form>
</div>
</body>