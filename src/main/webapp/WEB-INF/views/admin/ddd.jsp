<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.pathfinder.dto.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.pathfinder.util.CmmUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

    List<UserDTO> uList = (List<UserDTO>) request.getAttribute("uList");
    List<NoticeDTO> nList = (List<NoticeDTO>) request.getAttribute("nList");
    List<BoardDTO> bList = (List<BoardDTO>) request.getAttribute("bList");

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

    if (uList == null) {
        uList = new ArrayList<UserDTO>();

    }
    if (nList == null) {
        nList = new ArrayList<NoticeDTO>();

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
        location.href = "/userDetail?bNo="+bNo;
    }

    function noticeDetail(cNo) {
        location.href = "/NoticeDetail?bNo="+cNo;
    }

    function mainWrapper(){
        document.getElementById("mainWrapper").style.display="block"
        document.getElementById("mainWrapper2").style.display="none"
        document.getElementById("mainWrapper3").style.display="none"

    }
    function mainWrapper2(){
        document.getElementById("mainWrapper").style.display="none"
        document.getElementById("mainWrapper2").style.display="block"
        document.getElementById("mainWrapper3").style.display="none"

    }
    function mainWrapper3(){
        document.getElementById("mainWrapper").style.display="none"
        document.getElementById("mainWrapper2").style.display="none"
        document.getElementById("mainWrapper3").style.display="block"
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
        <div class="row">
            <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <br>
                        <li class="nav-item">
                            <a onclick="mainWrapper()">
                                회원 조회
                            </a>
                        </li><br><hr><br>
                        <li class="nav-item">
                            <a onclick="mainWrapper2()">
                                공지 조회
                            </a>
                        </li><br><hr><br>

                    </ul>
                </div>
            </nav>
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <!--회원조회-->
                <div style="display: block" id="mainWrapper">
                    <div id="userinfo" class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">회원 조회</h1>
                    </div>
                    <ul>
                        <ul id ="ulTable">
                            <li>
                                <ul>
                                    <li>아이디</li>
                                    <li>이메일</li>
                                    <li>회원이름</li>
                                    <li>가입일</li>
                                </ul>
                            </li>
                            <!-- 게시물이 출력될 영역 -->
                            <%
                                for (int i = 0; i < uList.size(); i++) {
                                    UserDTO rDTO = uList.get(i);

                                    if (rDTO == null) {
                                        rDTO = new UserDTO();
                                    }

                            %>
                            <li>
                                <ul>
                                    <li><%=CmmUtil.nvl(String.valueOf(rDTO.getUserId()))%></li>
                                    <li><a href="javascript:doDetail('<%=rDTO.getUserNo()%>');">
                                        <%=CmmUtil.nvl(rDTO.getUserMailid())%>@<%=CmmUtil.nvl(rDTO.getUserMaildomain())%>
                                    </a></li>
                                    <li><%=rDTO.getUserName()%></li>
                                </ul>
                            </li>
                            <%
                                }
                            %>
                        </ul>
                        <!-- 게시판 페이징 영역 -->
                        <li>
                            <div id="divPaging">
                                <div><strong>[</strong></div>
                                <!-- 각 번호 페이지 버튼 -->
                                <c:forEach var="num" begin="${userPageMake.startPage}" end="${userPageMake.endPage}">
                                    <div><a href="/admin?uNo=${num}" class="num">${num}</a></div>
                                </c:forEach>
                                <div><strong>]</strong></div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div style="display: none" id="mainWrapper2">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">공지 조회</h1>&nbsp;&nbsp;
                        <%if (session.getAttribute("user") != null){
                            UserDTO uDTO = (UserDTO) session.getAttribute("user");
                            if (uDTO.getAuth()=="admin"){%>
                        <button href="/admin/noticeInsertForm">공지 등록</button>
                        <%

                                }

                            }%>
                        <a href="/admin/noticeInsertForm">공지 등록</a>
                    </div>
                    <ul>
                        <ul id ="ulTable2">
                            <li>
                                <ul>
                                    <li>번호</li>
                                    <li>제목</li>
                                    <li>작성자</li>
                                    <li>작성일</li>
                                </ul>
                            </li>
                            <!-- 게시물이 출력될 영역 -->
                            <%
                                for (int i = 0; i < nList.size(); i++) {
                                    NoticeDTO rDTO = nList.get(i);

                                    if (rDTO == null) {
                                        rDTO = new NoticeDTO();
                                    }

                            %>
                            <li>
                                <ul>
                                    <li><%=CmmUtil.nvl(String.valueOf(rDTO.getNoticeNo()))%></li>
                                    <li><a href="javascript:noticeDetail('<%=rDTO.getNoticeNo()%>');">
                                        <%=CmmUtil.nvl(rDTO.getTitle())%>
                                    </a></li>
                                    <li><%=rDTO.getAdminname()%></li>
                                    <li><%=rDTO.getRegdate()%></li>
                                </ul>
                            </li>
                            <%
                                }
                            %>
                        </ul>
                        <!-- 게시판 페이징 영역 -->
                        <li>
                            <div id="divPaging2">
                                <div><strong>[</strong></div>
                                <!-- 각 번호 페이지 버튼 -->
                                <c:forEach var="num" begin="${noticePageMake.startPage}" end="${noticePageMake.endPage}">
                                    <div><a href="/adminPage?tNo=${num}" class="num">${num}</a></div>
                                </c:forEach>
                                <div><strong>]</strong></div>
                            </div>
                        </li>
                    </ul>
                </div>

            </main>
        </div>


        <a href="/tour/certificateRegForm?title=한국폴리텍대학 서울강서캠퍼스&addr1=서울특별시 강서구 화곡동 우장산로10길 112">인증 테스트</a>
    </div>
</div>
</body>