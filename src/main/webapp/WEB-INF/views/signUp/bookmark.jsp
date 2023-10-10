<%@ page import="com.example.pathfinder.dto.UserDTO" %>
<%@ page import="com.example.pathfinder.dto.BookmarkDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.pathfinder.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    UserDTO uDTO = (UserDTO) session.getAttribute("user");

    List<BookmarkDTO> bList = (List<BookmarkDTO>) request.getAttribute("bList");

    if (bList == null) {
        bList = new ArrayList<BookmarkDTO>();

    }
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

        #ulTable > li > ul > li:first-child               {width:100%;} /*No 열 크기*/

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
    </style>
</head>
<body>
<div class="login">


    <h2 class="login-header">마이페이지</h2>

    <form class="login-container">
        <div style="text-align: center" id="mainWrapper">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">북마크</h1>&nbsp;&nbsp;
                <ul>
                    <ul id ="ulTable">
                        <li>
                            <ul>
                                <li>이름</li>
                            </ul>
                        </li>
                        <!-- 게시물이 출력될 영역 -->
                        <%
                            for (int i = 0; i < bList.size(); i++) {
                                BookmarkDTO bDTO = bList.get(i);
                                System.out.println(bDTO);
                                if (bDTO == null) {
                                    bDTO = new BookmarkDTO();
                                }

                        %>
                        <li>
                            <ul>
                                <li><a href="<%=bDTO.getLink()%>"><%=bDTO.getTitle()%></a></li>
                            </ul>
                        </li>
                        <%
                            }
                        %>
                    </ul>
                </ul>
            </div>
<br/>
        </div>

    </form><a href="/index">메인 화면으로</a>
</div>
</body>