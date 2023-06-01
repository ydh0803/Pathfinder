<%@ page import="com.example.pathfinder.dto.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

    int edit = 1;
//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
    if (session.getAttribute("user")==null) {
        edit = 3;
    } else {
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        int ss_user_no = uDTO.getUser_no();
//로그인 안했다면....
    }
    int rep = 0;
    if (session.getAttribute("user")!=null) {
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        rep = uDTO.getUser_no();
    }
%>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function search() {
        let keyword = $('#search').val()
        console.log(keyword)
        let aaa = encodeURI(keyword)
        console.log(aaa)

        location.href="/keywordSearch?AR=" + aaa
    }

    function chksearch() {
        if(f.search.value == ""){
            alert("검색어를 입력해주세요.");
            f.search.focus();
            return false;
        }
    }
</script>
    <style>
        .search {
            position: relative;
            width: 300px;
        }

        input {
            width: 100%;
            border: 1px solid #bbb;
            border-radius: 8px;
            padding: 10px 12px;
            font-size: 14px;
        }

        .img {
            position: absolute;
            width: 17px;
            top: 10px;
            right: 12px;
            margin: 0;
        }

        .menu {
            position: absolute;
            width: 60px;
        }

        @import url(https://fonts.googleapis.com/css?family=Open+Sans:400,700);

        body {
            background: #456;
            font-family: 'Open Sans', sans-serif;
        }

        .main {
            width: 400px;
            margin: 16px auto;
            font-size: 16px;
        }

        /* Reset top and bottom margins from certain elements */
        .header,
        .login p {
            margin-top: 0;
            margin-bottom: 0;
        }


        .header {
            background: #28d;
            padding: 20px;
            font-size: 1.4em;
            font-weight: normal;
            text-align: center;
            text-transform: uppercase;
            color: #fff;
        }

        .container {
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

        .login input[type="text"],
        .login input[type="password"] {
            background: #fff;
            border-color: #bbb;
            color: #555;
        }

        /* Text fields' focus effect */
        .login input[type="text"]:focus,
        .login input[type="password"]:focus {
            border-color: #888;
        }

        .login input[type="submit"] {
            background: #28d;
            border-color: transparent;
            color: #fff;
            cursor: pointer;
        }

        .login input[type="submit"]:hover {
            background: #17c;
        }

        /* Buttons' focus effect */
        .login input[type="submit"]:focus {
            border-color: #05a;
        }
    </style>

    <title>메인</title>
</head>
<body>
<div class="main">
<div class="header">
    <div class="search">
            <input type="text" name="search" id="search" placeholder="검색어 입력">
            <input type="image" class="img" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search()">
        <input type="button" class="menu" id="menuBtn" onClick="location.href='LoginPage'" value="메뉴" >
    </div>
    <ul class="navbar-nav ms-auto">
        <% if(session.getAttribute("user") == null){%>
        <li li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/LoginPage">로그인</a></li>
        <%}%>
        <!--<form  required oninput="Show()">-->
        <% if(session.getAttribute("user") != null){%>
        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/myPage">마이페이지</a></li>
        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/logOut">로그아웃</a></li>
        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" onclick="window.open('/admin','관리자 페이지','width=1000 height=1200')">관리자 페이지</a></li>
        <%}%>
    </ul>
    <input type="button" onClick="location.href='/fiesta'" value="지도" >
    <input type="button" onClick="location.href='/gps'" value="주변 시설" >
</div>
<div class="container">


</div>
</div>

</body>
