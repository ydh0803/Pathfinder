        <%@ page import="com.example.pathfinder.dto.FestaDTO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    List<FestaDTO> rList = (List<FestaDTO>) request.getAttribute("list");
    FestaDTO rDTO = null;%>

<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function serch() {
            let keyword = $('#search').val()
            console.log(keyword)
            let aaa = encodeURI(keyword)
            console.log(aaa)

            $.ajax({
                    url: "/festa",
                    data: {AR : aaa},
                    method: "POST",
                    success : function (data){

                    }
                }
            )
        }

    </script>
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
    </style>

    <title>메인</title>
</head>
<body>
<div class="main">


    <div class="result">


        <h2 class="header">검색결과</h2>
        <div class="header">

        </div>
        <div class="container">
            <div id="map" style="width:500px;height:400px;"></div>
            <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=344db8e40afa1ae457b074b2bc2932bc"></script>
            <script>
                var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                    mapOption = {
                        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                        level: 3 // 지도의 확대 레벨
                    };

                var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

                // 마커를 표시할 위치와 title 객체 배열입니다
                <%--    var positions = [--%>
                <%--        {--%>
                <%--            title: <%=rDTO.getTitle()%>,--%>
                <%--            latlng: new kakao.maps.LatLng(<%=rDTO.getMapx()%>, <%=rDTO.getMapy()%>)--%>
                <%--        }--%>
                <%--    ];--%>

                // 마커 이미지의 이미지 주소입니다
                var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

                for (var i = 0; i < positions.length; i ++) {

                    // 마커 이미지의 이미지 크기 입니다
                    var imageSize = new kakao.maps.Size(24, 35);

                    // 마커 이미지를 생성합니다
                    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

                    // 마커를 생성합니다
                    var marker = new kakao.maps.Marker({
                        map: map, // 마커를 표시할 지도
                        position: positions[i].latlng, // 마커를 표시할 위치
                        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                        image : markerImage // 마커 이미지
                    });
                }
            </script>
            <%
                for (int i = 0; i < rList.size(); i++) {
                    rDTO = rList.get(i);

            %>
            <img src="<%=rDTO.getFirstimage()%>" style="width:150px;height:150px;"/>
            <a href="/course/courseDetail?coursename=<%=rDTO.getTitle()%>"><%=rDTO.getTitle()%></a>

            <%}%>
        </div>
    </div>
</div>

</body>
