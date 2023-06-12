<%@ page import="com.example.pathfinder.dto.ApiDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Objects" %>
<%@ page import="com.example.pathfinder.dto.DetailDTO" %>
<%@ page import="org.springframework.ui.Model" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    DetailDTO dDTO = (DetailDTO) request.getAttribute("Detail");
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
        .img {
            width: 380px;
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


    <h2 class="header"><%=dDTO.getTitle()%></h2>
    <div class="container">

        <img class="img" src="<%= dDTO.getFirstimage() %>">

        <% if (dDTO.getAddr1() != null) { %>
        <a>주소 : <%= dDTO.getAddr1() %></a><br/>
        <% } %>

        <% if (dDTO.getTel() != null || dDTO.getInfocenterleports() != null || dDTO.getInfocenterlodging() != null || dDTO.getInfocenterfood() != null || dDTO.getInfocentershopping() != null || dDTO.getInfocenterculture() != null) { %>
        <a>문의 :
            <% if (dDTO.getTel() != null) { %>
            <%= dDTO.getTel() %>
            <% } %>
            <% if (dDTO.getInfocenterleports() != null) { %>
            <%= dDTO.getInfocenterleports() %>
            <% } %>
            <% if (dDTO.getInfocenterlodging() != null) { %>
            <%= dDTO.getInfocenterlodging() %>
            <% } %>
            <% if (dDTO.getInfocenterfood() != null) { %>
            <%= dDTO.getInfocenterfood() %>
            <% } %>
            <% if (dDTO.getInfocentershopping() != null) { %>
            <%= dDTO.getInfocentershopping() %>
            <% } %>
            <% if (dDTO.getInfocenterculture() != null) { %>
            <%= dDTO.getInfocenterculture() %>
            <% } %>
        </a><br/>
        <% } %>

        <% if (dDTO.getExpagerangeleports() != null) { %>
        <a>체험연령 : <%= dDTO.getExpagerangeleports() %></a><br/>
        <% } %>

        <% if (dDTO.getParkingfood() != null || dDTO.getParkingleports() != null || dDTO.getParkinglodging() != null || dDTO.getParkingculture() != null || dDTO.getParkingshopping() != null || dDTO.getParkingfee() != null || dDTO.getParkingfeeleports() != null) { %>
        <a>주차시설 :
            <% if (dDTO.getParkingfood() != null) { %>
            <%= dDTO.getParkingfood() %>
            <% } %>
            <% if (dDTO.getParkingleports() != null) { %>
            <%= dDTO.getParkingleports() %>
            <% } %>
            <% if (dDTO.getParkinglodging() != null) { %>
            <%= dDTO.getParkinglodging() %>
            <% } %>
            <% if (dDTO.getParkingculture() != null) { %>
            <%= dDTO.getParkingculture() %>
            <% } %>
            <% if (dDTO.getParkingshopping() != null) { %>
            <%= dDTO.getParkingshopping() %>
            <% } %>
            / <%= dDTO.getParkingfee() %>
            <% if (dDTO.getParkingfeeleports() != null) { %>
            <%= dDTO.getParkingfeeleports() %>
            <% } %>
            <!-- Continue from the previous code -->

            <% if (dDTO.getOpenperiod() != null || dDTO.getOpendatefood() != null || dDTO.getOpendateshopping() != null) { %>
            <a>개장일 :
                <% if (dDTO.getOpenperiod() != null) { %>
                <%= dDTO.getOpenperiod() %>
                <% } %>
                <% if (dDTO.getOpendatefood() != null) { %>
                <%= dDTO.getOpendatefood() %>
                <% } %>
                <% if (dDTO.getOpendateshopping() != null) { %>
                <%= dDTO.getOpendateshopping() %>
                <% } %>
            </a><br/>
            <% } %>

            <% if (dDTO.getRestdateleports() != null || dDTO.getRestdateshopping() != null || dDTO.getRestdatefood() != null) { %>
            <a>휴장일 :
                <% if (dDTO.getRestdateleports() != null) { %>
                <%= dDTO.getRestdateleports() %>
                <% } %>
                <% if (dDTO.getRestdateshopping() != null) { %>
                <%= dDTO.getRestdateshopping() %>
                <% } %>
                <% if (dDTO.getRestdatefood() != null) { %>
                <%= dDTO.getRestdatefood() %>
                <% } %>
            </a><br/>
            <% } %>

            <% if (dDTO.getUsetimeculture() != null || dDTO.getUsetimeleports() != null) { %>
            <a>이용시간 :
                <% if (dDTO.getUsetimeculture() != null) { %>
                <%= dDTO.getUsetimeculture() %>
                <% } %>
                <% if (dDTO.getUsetimeleports() != null) { %>
                <%= dDTO.getUsetimeleports() %>
                <% } %>
            </a><br/>
            <% } %>

            <% if (dDTO.getAccomcountleports() != null || dDTO.getAccomcountshopping() != null || dDTO.getAccomcountlodging() != null || dDTO.getAccomcountculture() != null) { %>
            <a>수용인원 :
                <% if (dDTO.getAccomcountleports() != null) { %>
                <%= dDTO.getAccomcountleports() %>
                <% } %>
                <% if (dDTO.getAccomcountshopping() != null) { %>
                <%= dDTO.getAccomcountshopping() %>
                <% } %>
                <% if (dDTO.getAccomcountlodging() != null) { %>
                <%= dDTO.getAccomcountlodging() %>
                <% } %>
                <% if (dDTO.getAccomcountculture() != null) { %>
                <%= dDTO.getAccomcountculture() %>
                <% } %>
            </a><br/>
            <% } %>

            <% if (dDTO.getChkpetleports() != null || dDTO.getChkpetculture() != null || dDTO.getChkpetshopping() != null) { %>
            <a>애완동물 동반여부 :
                <% if (dDTO.getChkpetleports() != null) { %>
                <%= dDTO.getChkpetleports() %>
                <% } %>
                <% if (dDTO.getChkpetculture() != null) { %>
                <%= dDTO.getChkpetculture() %>
                <% } %>
                <% if (dDTO.getChkpetshopping() != null) { %>
                <%= dDTO.getChkpetshopping() %>
                <% } %>
            </a><br/>
            <% } %>

            <% if (dDTO.getChkcreditcardleports() != null || dDTO.getChkcreditcardculture() != null || dDTO.getChkcreditcardshopping() != null || dDTO.getChkcreditcardfood() != null) { %>
            <a>신용카드 사용여부 :
                <% if (dDTO.getChkcreditcardleports() != null) { %>
                <%= dDTO.getChkcreditcardleports() %>
                <% } %>
                <% if (dDTO.getChkcreditcardculture() != null) { %>
                <%= dDTO.getChkcreditcardculture() %>
                <% } %>
                <% if (dDTO.getChkcreditcardshopping() != null) { %>
                <%= dDTO.getChkcreditcardshopping() %>
                <% } %>
                <% if (dDTO.getChkcreditcardfood() != null) { %>
                <%= dDTO.getChkcreditcardfood() %>
                <% } %>
            </a><br/>
            <% } %>

            <% if (dDTO.getChkbabycarriageleports() != null || dDTO.getChkbabycarriageculture() != null || dDTO.getChkbabycarriageshopping() != null) { %>
            <a>유모차 대여여부 :
                <% if (dDTO.getChkbabycarriageleports() != null) { %>
                <%= dDTO.getChkbabycarriageleports() %>
                <% } %>
                <% if (dDTO.getChkbabycarriageculture() != null) { %>
                <%= dDTO.getChkbabycarriageculture() %>
                <% } %>
                <% if (dDTO.getChkbabycarriageshopping() != null) { %>
                <%= dDTO.getChkbabycarriageshopping() %>
                <% } %>
            </a><br/>
            <% } %>

            <% if (dDTO.getScale() != null || dDTO.getScaleleports() != null || dDTO.getScalefood() != null) { %>
            <a>규모 :
                <% if (dDTO.getScale() != null) { %>
                <%= dDTO.getScale() %>
                <% } %>
                <% if (dDTO.getScaleleports() != null) { %>
                <%= dDTO.getScaleleports() %>
                <% } %>
                <% if (dDTO.getScalefood() != null) { %>
                <%= dDTO.getScalefood() %>
                <% } %>
            </a></br>
            <% } %>

            <% if (dDTO.getReservation() != null || dDTO.getReservationfood() != null || dDTO.getReservationlodging() != null || dDTO.getReservationurl() != null) { %>
            <a>예약 :
                <% if (dDTO.getReservation() != null) { %>
                <%= dDTO.getReservation() %>
                <% } %>
                <% if (dDTO.getReservationfood() != null) { %>
                <%= dDTO.getReservationfood() %>
                <% } %>
                <% if (dDTO.getReservationlodging() != null) { %>
                <%= dDTO.getReservationlodging() %>
                <% } %>
                <% if (dDTO.getReservationurl() != null) { %>
                <%= dDTO.getReservationurl() %>
                <% } %>
            </a>
            <% } %>

        </a><br/>
        <% } %>







    </div>
</div>
</body>