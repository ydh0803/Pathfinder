<%@ page import="com.example.pathfinder.dto.ApiDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Objects" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    List<ApiDTO> rList = (List<ApiDTO>) request.getAttribute("list");
%>
<head>
    <style>
        @import url(https://fonts.googleapis.com/css?family=Open+Sans:400,700);

        body {
            background: #456;
            font-family: 'Open Sans', sans-serif;
        }

        .result {
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

        /* The triangle form is achieved by a CSS hack */
        .login-triangle {
            width: 0;
            margin-right: auto;
            margin-left: auto;
            border: 12px solid transparent;
            border-bottom-color: #28d;
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
<div class="result">


    <h2 class="header">검색결과</h2>
        <div class="container">

        <%
            for (int i = 0; i < rList.size(); i++) {
                ApiDTO rDTO = rList.get(i);

        %>
        <img src="<%=rDTO.getFirstimage2()%>" style="width:150px;height:150px;"/>
        <a href="/tour/SearchDetail?title=<%=rDTO.getTitle()%>"><%=rDTO.getTitle()%></a>
            <a href="/tour/SearchDetail?contentid=<%=rDTO.getContentid()%>"><%=rDTO.getTitle()%></a>
<%--        <a href="/tour/SearchDetail?contentId=<%rDTO.getContentId();%>&contentTypeId=<%rDTO.getContentTypeId();%>"><%=rDTO.getTitle()%></a>--%>

        <%}%>
        </div>
</div>
</body>