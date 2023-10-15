<%@ page import="com.example.pathfinder.dto.ScanDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.pathfinder.dto.NewsDTO" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%--<%--%>
<%--    List<NewsDTO> nList = (List<NewsDTO>) request.getAttribute("nList");--%>
<%--%>--%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>


        input {
            width: 100%;
            border: 1px solid #bbb;
            border-radius: 8px;
            padding: 10px 12px;
            font-size: 14px;
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
            align: center;
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

        ul.group {
            --swiper-theme-color: #007aff;
            --swiper-navigation-size: 44px;
            color: #111;
            word-wrap: break-word;
            -webkit-text-size-adjust: none;
            direction: ltr;
            word-break: keep-all;
            font-family: "Noto Sans KR", "Apple SD Gothic Neo", "Malgun Gothic", "맑은 고딕", Dotum, 돋움, Arial, sans-serif;
            font-size: 100%;
            line-height: 1;
            padding: 0;
            box-sizing: border-box;
            letter-spacing: -.4px;
            list-style: none;
            -webkit-box-flex: 1!important;
            /*display: flex;*/
            flex-grow: 1!important;
            flex-wrap: wrap;
            margin-left: -5px;
            margin-right: -5px;
            margin-bottom: -10px;
            margin-top: -10px;
        }

        /*li, ul {*/
        /*    list-style: none;*/
        /*}*/

        li {
            --swiper-theme-color: #007aff;
            --swiper-navigation-size: 44px;
            color: #111;
            word-wrap: break-word;
            -webkit-text-size-adjust: none;
            direction: ltr;
            word-break: keep-all;
            font-family: "Noto Sans KR", "Apple SD Gothic Neo", "Malgun Gothic", "맑은 고딕", Dotum, 돋움, Arial, sans-serif;
            font-size: 100%;
            line-height: 1;
            margin: 0;
            box-sizing: border-box;
            letter-spacing: -.4px;
            list-style: none;
            max-width: 100%;
            padding-left: 5px;
            padding-right: 5px;
            width: 49.99%;
            -webkit-box-flex: 0;
            flex: 0 0 auto;
            -webkit-box-orient: vertical;
            -webkit-box-direction: normal;
            display: flex;
            flex-flow: column;
            height: auto;
            position: relative;
            padding-bottom: 10px;
            padding-top: 10px;
        }

    </style>

    <title>메인</title>
</head>
<body>
<div class="main">

    <h2 class="header">여행 뉴스</h2>
    <div class="container">

    <c:if test="${empty nList}">
        <p>No news available.</p>
    </c:if>

        <ul class="group">
            <c:forEach items="${nList}" var="news">
                <li>
                    <img src="${news.image}" style="width:380px; height:213px;" /><br/>
                    <button data-toggle="collapse" href="#fold${news.newsNo}" aria-expanded="false" aria-controls="fold${news.newsNo}" style="width:380px;">
                            ${news.headline}
                    </button>
                    <div id="fold${news.newsNo}" class="collapse fold" style="width:380px;">
                            ${news.text}
                        <br/><a href="${news.link}">원본 기사 보기</a><br/>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div><a href="/index">메인 화면으로</a>
</div>
</div>

</body>
