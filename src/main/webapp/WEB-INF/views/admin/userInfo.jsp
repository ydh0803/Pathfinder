<%@ page import="com.example.pathfinder.dto.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.pathfinder.util.CmmUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    UserDTO rDTO = (UserDTO) request.getAttribute("rDTO");
    List<BoardDTO> rList = (List<BoardDTO>) request.getAttribute("rList");
    int access = 0;
    if (session.getAttribute("user")==null) {
        access = 0;
    } else {
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        System.out.println(uDTO.getAuth());
        if (uDTO.getAuth().equals("admin")) {
            access = 3;
        } else {
            access = 1;
        }
    }

//게시판 조회 결과 보여주기
    if (rList == null) {
        rList = new ArrayList<BoardDTO>();

    }

%>
<script>

    function doOnload(){
        if ("<%=access%>"==="1"){
            alert("관리자만 접근할수 있는 페이지 입니다");
            window.close()
        }
    }

    function doDetail(bNo) {
        location.href = "/userBoardDetail?bNo="+bNo;
    }

    function goList() {
        location.href = "/admin";
    }
    function userDelete() {
        if (confirm('<%=rDTO.getUserName()%>회원을 삭제하시겠습니까?')){
            location.href = "/adminDeleteUser?bNo="+<%=String.valueOf(rDTO.getUserNo())%>;
        }else {
            location.reload()
        }


    }
    function doOnload(){
        if ("<%=access%>"=="1"){
            alert("관리자만 접근할수 있는 페이지 입니다");
            window.close();
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


        ul, li{
            list-style:none;
            text-align:center;
            padding:0;
            margin:0;
        }

        #mainWrapper{
            width: 100%;
            margin: 0 auto; /*가운데 정렬*/
        }

        #mainWrapper > ul > li:first-child {
            text-align: center;
            font-size:14pt;
            height:40px;
            vertical-align:middle;
            line-height:30px;
        }
        #mainWrapper2{
            width: 100%;
            margin: 0 auto; /*가운데 정렬*/
        }

        #mainWrapper2 > ul > li:first-child {
            text-align: center;
            font-size:14pt;
            height:40px;
            vertical-align:middle;
            line-height:30px;
        }

        #ulTable {margin-top:10px;}
        #ulTable2 {margin-top:10px;}


        #ulTable > li:first-child > ul > li {
            background-color:#c9c9c9;
            font-weight:bold;
            text-align:center;
        }
        #ulTable2 > li:first-child > ul > li {
            background-color:#c9c9c9;
            font-weight:bold;
            text-align:center;
        }

        #ulTable > li > ul {
            clear:both;
            padding:0px;
            position:relative;
            min-width:40px;
        }
        #ulTable2 > li > ul {
            clear:both;
            padding:0px;
            position:relative;
            min-width:40px;
        }
        #ulTable > li > ul > li {
            float:left;
            font-size:10pt;
            border-bottom:1px solid silver;
            vertical-align:baseline;
        }
        #ulTable2 > li > ul > li {
            float:left;
            font-size:10pt;
            border-bottom:1px solid silver;
            vertical-align:baseline;
        }

        #ulTable > li > ul > li:first-child               {width:20%;} /*No 열 크기*/
        #ulTable > li > ul > li:first-child +li           {width:45%;} /*제목 열 크기*/
        #ulTable > li > ul > li:first-child +li+li        {width:20%;} /*작성일 열 크기*/
        #ulTable > li > ul > li:first-child +li+li+li     {width:15%;} /*작성자 열 크기*/
        #ulTable2 > li > ul > li:first-child               {width:20%;} /*No 열 크기*/
        #ulTable2 > li > ul > li:first-child +li           {width:45%;} /*제목 열 크기*/
        #ulTable2 > li > ul > li:first-child +li+li        {width:20%;} /*작성일 열 크기*/
        #ulTable2 > li > ul > li:first-child +li+li+li     {width:15%;} /*작성자 열 크기*/

        #divPaging {
            clear:both;
            margin:0 auto;
            width:220px;
            height:50px;
        }

        #divPaging > div {
            float:left;
            width: 30px;
            margin:0 auto;
            text-align:center;
        }

        #divPaging2 {
            clear:both;
            margin:0 auto;
            width:220px;
            height:50px;
        }

        #divPaging2 > div {
            float:left;
            width: 30px;
            margin:0 auto;
            text-align:center;
        }

        #liSearchOption {clear:both;}
        #liSearchOption > div {
            margin:0 auto;
            margin-top: 30px;
            width:auto;
            height:100px;

        }

        .left {
            text-align : left;
        }
    </style>

</head>
<body onload="doOnload()">
<div class="login">


    <h2 class="login-header">관리자 페이지</h2>
    <div class="login-container">

        <main>
            <div class="col-md-7 col-lg-8">
                <h2 class="mb-3">회원조회</h2>
                <hr class="my-4">
                <div class="row g-3">
                    <div class="col-sm-12">
                        <h4 class="mb-3">이름</h4>
                        <p><%=rDTO.getUserName()%></p>
                    </div>
                </div>
                <hr class="my-1">
                <div class="row g-3">
                    <div class="col-sm-12">
                        <h4 class="mb-3">이메일</h4>
                        <p><%=rDTO.getUserMailid()%>@<%=rDTO.getUserMaildomain()%></p>
                    </div>
                </div>
                <hr class="my-1">
                <div class="row g-3">
                    <div class="col-sm-12">
                        <h4 class="mb-3">아이디</h4>
                        <p><%=rDTO.getUserId()%></p>
                    </div>
                </div>
                <hr class="my-1">
                <div class="row g-3">
                </div>
                <hr class="my-1">
                <div class="row g-3">
                    <div class="col-sm-12">
                        <a onclick="userDelete()">회원삭제</a><a>&nbsp;&nbsp;||&nbsp;&nbsp;</a><a onclick="goList()">목록</a>
                    </div>
                </div>
                <hr class="my-2">
                <div id="mainWrapper">
                    <ul>
                        <!-- 게시판 제목 -->
                        <li><h2>작성글 목록</h2></li>
                        <!-- 게시판 목록  -->
                        <li>
                            <ul id ="ulTable">
                                <li>
                                    <ul>
                                        <li>No</li>
                                        <li>제목</li>
                                        <li>코스명</li>
                                        <li>작성자</li>
                                        <li>작성일</li>
                                    </ul>
                                </li>
                                <!-- 게시물이 출력될 영역 -->
                                <%
                                    for (int i = 0; i < rList.size(); i++) {
                                        BoardDTO cDTO = rList.get(i);

                                        if (cDTO == null) {
                                            cDTO = new BoardDTO();
                                        }

                                %>
                                <li>
                                    <ul>
                                        <li><%=cDTO.getBoardNo()%></li>
                                        <li><a href="javascript:doDetail('<%=cDTO.getBoardNo()%>');">
                                            <%=CmmUtil.nvl(cDTO.getTitle())%>
                                        </a></li>
                                        <li><%=cDTO.getUserName()%></li>
                                        <li><%=cDTO.getRegdate()%></li>
                                    </ul>
                                </li>
                                <%
                                    }
                                %>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </main>



    </div>
</div>
</body>