<%@ page import="com.example.pathfinder.dto.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

    int edit = 1;
//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
    if (session.getAttribute("user")==null) {
        edit = 3;
    } else {
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        int ss_userNo = uDTO.getUserNo();
//로그인 안했다면....
    }
    int rep = 0;
    if (session.getAttribute("user")!=null) {
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        rep = uDTO.getUserNo();
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

        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('preview').src = e.target.result;
                    document.getElementById('preview').style.textAlign="left";
                    document.getElementById('preview').style.width="450px";
                    document.getElementById('preview').style.height="350px";
                };
                reader.readAsDataURL(input.files[0]);
            } else {
                document.getElementById('preview').src = "";
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
            top: 0px;
            right: 0px;
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

        .subject {
            height: 1000px;
        }

        textarea {
            width: 100%;
            height: 400px;
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
    </div>
    <div class="container">
        <form method="post" class="ui large form" encType="multipart/form-data" action="/upload">
            <input type="text" id="title" name="title" placeholder="제목">
            <input type="hidden" name="userNo" id="userNo" value="${user.userNo}">
            <br><hr>
            <textarea style="resize: vertical;" id="contents" name="contents" placeholder="내용" rows="8"></textarea><br><hr>
            <label class="input-file-button" for="file">
            사진첨부
            </label><br>
            <input style="display: none;" type="file" id="file" name="file" onchange="readURL(this);">
            <input type="submit" id="write" value="작성"><input type="button" onclick="location.href='/review/reviewList'" value="취소"
        </form>
    </div>
</div>

</body>
