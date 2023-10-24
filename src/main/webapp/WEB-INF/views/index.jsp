<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.pathfinder.dto.UserDTO" %>
<%@ page import="com.example.pathfinder.util.CmmUtil" %>
<%@ page import="com.example.pathfinder.dto.NoticeDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

    List<NoticeDTO> rList = (List<NoticeDTO>) request.getAttribute("rList");

    if (rList == null) {
        rList = new ArrayList<NoticeDTO>();

    }

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

    function noticeDetail(cNo) {
        location.href = "/NoticeDetail?bNo="+cNo;
    }




</script>
    <style>
        .search {
            position: relative;
            width: 700px;
            left: 10%;
        }

        .searchbar {
            width: 100%;
            border: 1px solid #bbb;
            border-radius: 8px;
            padding: 10px 12px;
            font-size: 14px;

        }

        .btn {
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
            right: 20px;
            margin: 0;
        }

        .menu {
            position: absolute;
            width: 55px;
            height: 45px;
            right: -10%;
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
            width: 1000px;
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

        ul, li{
            list-style:none;
            text-align:center;
            padding:0;
            margin:0;
            width: 800px;
            left: 10%;
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

        #ulTable {margin-top:10px;}


        #ulTable > li:first-child > ul > li {
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

        #ulTable > li > ul > li {
            float:left;
            font-size:10pt;
            border-bottom:1px solid silver;
            vertical-align:baseline;
        }

        #ulTable > li > ul > li:first-child               {width:10%;} /*No 열 크기*/
        #ulTable > li > ul > li:first-child +li           {width:50%; text-align: left} /*제목 열 크기*/
        #ulTable > li > ul > li:first-child +li+li        {width:15%;} /*작성일 열 크기*/
        #ulTable > li > ul > li:first-child +li+li+li     {width:25%;} /*작성자 열 크기*/

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


        #liSearchOption {clear:both;}
        #liSearchOption > div {
            margin:0 auto;
            margin-top: 30px;
            width:auto;
            height:100px;

        }

        .sidebar {
            display: block;
            overflow: hidden;
            width: 200px;
            background-color: #000;
            color: #fff;
            transition: all 0.5s ease;
            border-radius: 20px;
            padding: 10px;
            box-sizing: border-box;
            position: relative;
            top: -40%;
            left: 80%;
        }
        .sidebar ul {
            list-style: none;
            margin: 0;
            padding: 0;
        }
        .sidebar a, .sidebar > label {
            display: block;
            height: 25px;
            padding: 8px;
            cursor: pointer;
            color: #fff;
            text-decoration: none;
        }

        .sidebar a:hover {
            color: #000;
        }
        .sidebar ul li:hover, .menu > label:hover {
            background-color: #fff;
            color: #000;
            border-radius: 10px;
        }
        .sidebar div {
            position: absolute;
            left: 50px;
            line-height: 1.5;
            font-size: 1em;
            font-family: 'Noto Sans KR';
            padding: 0 0 0 20px;
        }

        #expand-menu {
            display: none;
        }
        #expand-menu:checked ~ ul {
            display: block;
            height: auto;
        }

        .sidebar ::before {
            font-family: 'Material Icons';
            font-size: 1.5em;
            float: left;
            clear: left;
        }
        .sidebar label::before{ content: '\e5d2'; }
        .sidebar li:nth-child(1) a::before{ content: '\e7fd'; }
        .sidebar li:nth-child(2) a::before{ content: '\e55b'; }
        .sidebar li:nth-child(3) a::before{ content: '\f05f'; }
        .sidebar li:nth-child(4) a::before{ content: '\e560'; }
        .sidebar li:nth-child(5) a::before{ content: '\e0b7'; }
        .sidebar li:nth-child(6) a::before{ content: '\ea08'; }
        .sidebar li:nth-child(7) a::before{ content: '\ef3d'; }

        @media screen and (max-width:1023px) {
            .sidebar {
                width: 60px;
            }
        }
        @media screen and (max-width:560px) {
            .sidebar #expand-menu:not(:checked) ~ ul {
                display: none;
            }
        }

    </style>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <title>메인</title>
</head>
<body>
<div class="main">
<div class="header">
    <div class="search">
            <input type="text" name="search" class="searchbar" id="search" placeholder="검색어 입력">
            <input type="image" class="img" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search()">


    </div>

</div>
<div class="container">
    <div >
        <div style="text-align: center" class="col-md-6">
            <div style="text-align: center" id="mainWrapper">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">공지</h1>&nbsp;&nbsp;

                </div>
                <ul>
                    <ul id ="ulTable">
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
                            for (int i = 0; i < rList.size(); i++) {
                                NoticeDTO rDTO = rList.get(i);
                         System.out.println(rDTO);
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
                                <li><%=rDTO.getRegdate().substring(0,10)%></li>

                            </ul>
                        </li>
                        <%
                            }
                        %>
                    </ul>
                    <!-- 게시판 페이징 영역 -->
                    <li>
                        <div style="text-align: center;" id="divPaging">
                            <div><strong>[</strong></div>
                            <!-- 각 번호 페이지 버튼 -->
                            <c:forEach var="num" begin="${noticePageMake.startPage}" end="${noticePageMake.endPage}">
                                <div><a href="/index?tNo=${num}" class="num">${num}</a></div>
                            </c:forEach>
                            <div><strong>]</strong></div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>

</div>
</div>
<div class="sidebar">
    <label for="expand-menu">
        <div>메뉴</div>

    </label>
    <input type="checkbox" id="expand-menu" name="expand-menu">
    <ul>
        <li>
            <% if(session.getAttribute("user") == null) { %>
            <a class="item" id="menuBtn" onclick="location.href='/LoginPage'" value="메뉴"><div>로그인</div></a>
            <% } %>

            <% if(session.getAttribute("user") != null) { %>
            <a class="item" id="menuBtn" onclick="location.href='/myPage'"><div>마이 페이지</div></a>
            <% } %>

        </li>
        <li>
            <a class="item" onClick="location.href='/fiesta'" value="축제 지도" ><div>축제 지도</div></a>
        </li>
        <li>
            <a class="item" onClick="location.href='/gps'" value="주변 시설" ><div>주변 시설</div></a>
        </li>
        <li><a class="item" onclick="location.href='/review/reviewList'" value="리뷰 게시판"><div>리뷰 게시판</div></a></li>
        <li>
            <% if(session.getAttribute("user") == null) { %>
            <a class="item" onclick="openChatPopup();" value="지역 채팅"><div>지역 채팅</div></a>
            <script>
                function openChatPopup() {
                    alert("로그인이 필요합니다.");
                }
            </script>
            <% } else {%>
            <a class="item" onClick="location.href='/chatGroup'" value="지역 채팅" ><div>지역 채팅</div></a>
            <% } %>
        </li>
        <li>
            <a class="item" onClick="location.href='/tour/news'" value="여행 뉴스" ><div>여행 뉴스</div></a>
        </li>
        <li>
            <% if(session.getAttribute("user") != null) { %>
            <a class="item" id="adminOnly" onclick="window.open('/adminPage','관리자')"><div>관리자</div></a>
            <% } %>
        </li>
    </ul>
</div>
</body>
