<%@ page import="com.example.pathfinder.dto.UserDTO" %>
<%@ page import="java.util.Objects" %>
<%@ page import="com.example.pathfinder.dto.NoticeDTO" %>
<%@ page import="com.example.pathfinder.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    NoticeDTO rDTO = (NoticeDTO) request.getAttribute("rDTO");
    int res = (Integer) request.getAttribute("res");

//공지글 정보를 못불러왔다면, 객체 생성
    if (rDTO == null) {
        rDTO = new NoticeDTO();

    }
    int edit = 1;

//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
    if (session.getAttribute("user")==null) {
        edit = 3;
    } else {
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        String ss_user_name = uDTO.getUserName();

//로그인 안했다면....
        if (uDTO == null) {
            edit = 3;

//본인이 작성한 글이면 2가 되도록 변경
        } else if (Objects.equals(ss_user_name, rDTO.getAdminname())) {

            edit = 2;

        }
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

        //삭제하기
        function goAdmin(){
            location.href="/adminPage"
        }
        function doDelete() {
            if ("<%=edit%>" == 2) {
                if (confirm("작성한 글을 삭제하시겠습니까?")) {
                    location.href = "/noticeDelete?nSeq=<%=rDTO.getNoticeNo()%>";

                }
            } else if ("<%=edit%>" == 3) {
                alert("로그인 하시길 바랍니다.");

            } else {
                alert("본인이 작성한 글만 삭제 가능합니다.");
            }
        }

        function doEdit() {
            if ("<%=edit%>" == 2) {
                location.href = "/admin/NoticeEdit?nSeq=<%=CmmUtil.nvl(String.valueOf(rDTO.getNoticeNo()))%>";

            } else if ("<%=edit%>" === 3) {
                alert("로그인 하시길 바랍니다.");

            } else {
                alert("본인이 작성한 글만 수정 가능합니다.");
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
            width: 45px;
            height: 35px;
        }

        .admin {
            position: absolute;
            right: -60px;
            width: 20px;
            height: 35px;
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
            <%--        <input type="button" class="menu" id="menuBtn" onClick="location.href='LoginPage'" value="메뉴" >--%>
            <% if(session.getAttribute("user") == null) { %>
            <button class="menu" id="menuBtn" onclick="location.href='/LoginPage'" value="메뉴">메뉴</button>
            <% } %>

            <% if(session.getAttribute("user") != null) { %>
            <button class="menu" id="menuBtn" onclick="location.href='/myPage'">메뉴</button>
            <button class="admin" id="adminOnly" onclick="window.open('/adminPage','관리자', 'width=1000,height=1200')">관</button>
            <% } %>

        </div>

    </div>
    <div class="container">
        <h2>공지</h2>

        <div class="box" style="width: 100%; font-size: 24px">
            <%=rDTO.getTitle()%>
        </div>
        <hr>
        <div class="box" style="display:flex;width: 100%;color: #272a15">
            <p>작성자:<%=rDTO.getAdminname()%>&nbsp;&nbsp;|&nbsp;&nbsp;</p><p>작성일:<%=rDTO.getRegdate().substring(0,16)%></p>
        </div>
        <hr>
        <div class="box" style="width: 100%; font-size:16px">
            <p><%=rDTO.getContents()%></p>
        </div>
        <div style="font-size: 18px" class="box">
            <%if (edit==2){%>
            <a onclick="doEdit()">[수정]</a>
            <a onclick="goAdmin()">[목록]</a>
            <a onclick="doDelete()">[삭제]</a>
            <%}%>
        </div>

        <a href="/index">메인 화면으로</a>
    </div>
</div>

</body>
