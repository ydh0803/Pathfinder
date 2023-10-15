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
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=344db8e40afa1ae457b074b2bc2932bc&libraries=services"></script>
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
<body onload="searchAddrFromCoords()">
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



<script>
    // 주소-좌표 변환 객체를 생성합니다
    var geocoder = new kakao.maps.services.Geocoder();
    let addr = "";
    let mapx = "";
    let mapy = "";



    var callback = function (result, status) {

    }

    function searchAddrFromCoords() {
        var y = '<%=dDTO.getMapy()%>';
        var x = '<%=dDTO.getMapx()%>';

        geocoder.transCoord(x, y, transCoordCB, {
            input_coord: kakao.maps.services.Coords.WGS84, // 변환을 위해 입력한 좌표계 입니다
            output_coord: kakao.maps.services.Coords.WCONGNAMUL // 변환 결과로 받을 좌표계 입니다
        });

// 좌표 변환 결과를 받아서 처리할 콜백함수 입니다.
        function transCoordCB(result, status) {
            mapx = result[0].x;
            mapy = result[0].y;


            }

        navigator.geolocation.getCurrentPosition(function (position) {
            let lat = position.coords.latitude; // 위도
            let lon = position.coords.longitude; // 경도

            // 좌표로 행정동 주소 정보를 요청합니다
            geocoder.coord2Address(lon, lat, function (result, status, message) {
                if (status === kakao.maps.services.Status.OK && result.length > 0) {
                    console.log(result)
                    addr = result[0].address.address_name;
                    console.log(addr);

                    // 여기에서 주소 정보를 사용할 수 있습니다.
                } else {
                    console.error('주소 정보를 가져오는데 실패했습니다.');
                }
            });
        });
    }

    // function searchDetailAddrFromCoords(coords, callback) {
    //     // 좌표로 법정동 상세 주소 정보를 요청합니다
    //     geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
    // }


    function openMap() {

        let how = document.getElementById("target").value
        console.log(how)


    // JavaScript 변수에 JSP 데이터 할당
    var title = '<%=dDTO.getTitle()%>';
    <%--var mapy = '<%=dDTO.getMapy()%>';--%>
    <%--var mapx = '<%=dDTO.getMapx()%>';--%>
    console.log(title);
    console.log(mapy);
    console.log(mapx);
    console.log(addr);


        window.open("https://map.kakao.com/?map_type=TYPE_MAP&target=" + how + "&rt=%2C%2C" + mapx + "%2C" + mapy + "&rt1=" + addr + "&rt2=" + title + "&rtIds=%2C&rtTypes=%2C",width=500,height=500)

    };
</script>
        <select id="target">
            <option value="car">자동차</option>
            <option value="transit">대중교통</option>
            <option value="walk">도보</option>
            <option value="bike">자전거</option>
        </select>
        <button class="map-btn" id="map-btn" onclick="openMap()">길찾기</button><br/><br/>

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