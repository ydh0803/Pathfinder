<%@ page import="com.example.pathfinder.dto.ApiDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Objects" %>
<%@ page import="com.example.pathfinder.dto.DetailDTO" %>
<%@ page import="org.springframework.ui.Model" %>
<%@ page import="com.example.pathfinder.dto.UserDTO" %>
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function bookmark() {


            var url = window.location.href;
            var title = '<%=dDTO.getTitle()%>';
            var userNo = <%= ((UserDTO) session.getAttribute("user")) != null ? ((UserDTO) session.getAttribute("user")).getUserNo() : 0 %>;


            if (userNo == null) {
                    var userNo = 0;
                }

            console.log(url);
            console.log(title);
            console.log(userNo)

            if (userNo !== 0) {
                $.ajax({
                    type: 'POST',  // 또는 'GET' 등 HTTP 요청 방법 설정
                    url: '/user/bookmark',  // 요청을 보낼 URL 설정
                    data: {url: url, title: title, userNo: userNo},  // 요청과 함께 전송할 데이터 설정
                    success: function (response) {
                        // 성공 시 실행할 동작을 여기에 작성합니다.
                        console.log(response);
                    },
                    error: function (error) {
                        // 오류 시 실행할 동작을 여기에 작성합니다.
                        console.error(error);
                    }
                });
            } else {
                window.alert('북마크는 로그인 후 사용할 수 있습니다.')
                console.log("로그인 필요");
            }
        }

    </script>
</head>
<body>
<div class="result">


    <h2 class="header"><%=dDTO.getTitle()%></h2>
    <div class="container">

        <img class="img" src="<%=dDTO.getFirstimage()%>">
        <a>주소 : <%=dDTO.getAddr1()%></a><br/>
        <a>문의 : <%=dDTO.getTel()%>/<%=dDTO.getInfocenter()%></a><br/>
        <a>체험연령 : <%=dDTO.getExpagerange()%></a><br/>
        <a>체험안내 : <%=dDTO.getExpguide()%></a><br/>
        <a>주차시설 : <%=dDTO.getParking()%></a><br/>
        <a>개장일 : <%=dDTO.getOpendate()%></a><br/>
        <a>휴장일 : <%=dDTO.getRestdate()%></a><br/>
        <a>이용시간 : <%=dDTO.getUsetime()%></a><br/>
        <a>수용인원 : <%=dDTO.getAccomcount()%></a><br/>
        <a>애완동물 동반여부 : <%=dDTO.getChkpet()%></a><br/>
        <a>신용카드 사용여부 : <%=dDTO.getChkcreditcard()%></a><br/>
        <a>유모차 대여여부 : <%=dDTO.getChkbabycarriage()%></a><br/>

        <button onclick="bookmark()" value="북마크">북마크</button>

        <% if(session.getAttribute("user") == null) { %>
        <input type="button" onclick="openChatPopup();" value="인증">
        <script>
            function openChatPopup() {
                alert("로그인이 필요합니다.");
            }
        </script>
        <% } else {%>
        <a href="/tour/certificateRegForm?title=<%=dDTO.getTitle()%>&addr1=<%=dDTO.getAddr1()%>">인증</a>
        <% } %>






    </div><a href="/index">메인 화면으로</a>
</div>
</body>