<%@ page import="com.example.pathfinder.dto.ScanDTO" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    List<ScanDTO> sList = (List<ScanDTO>) request.getAttribute("list");
%>
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
            width: 600px;
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

    <h2 class="header">주변 시설 검색</h2>
    <div class="container">
        <div id="map" style="width:100%;height:500px;"></div>

        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=344db8e40afa1ae457b074b2bc2932bc&libraries=services"></script>
        <script>
            function SetGPS() {
                var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                    mapOption = {
                        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                        level: 10 // 지도의 확대 레벨
                    };

                var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

                // HTML5의 geolocation으로 사용할 수 있는지 확인합니다
                if (navigator.geolocation) {

                    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
                    navigator.geolocation.getCurrentPosition(function (position) {

                        let lat = position.coords.latitude, // 위도
                            lon = position.coords.longitude; // 경도

                        console.log(lat, lon)

                        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
                            message = '<div style="padding:5px;">현재 위치</div>'; // 인포윈도우에 표시될 내용입니다

                        // 마커와 인포윈도우를 표시합니다
                        displayMarker(locPosition, message);


                            let ContentTypeId = document.getElementById("ContentTypeID").value;
                            console.log(ContentTypeId)
                            console.log(lon)
                            console.log(lat)
                            $.ajax({
                                    url: "/tour/gpsScan",
                                    data: {"mapX": lon,
                                        "mapY": lat,
                                        "ContentTypeId": ContentTypeId},
                                    type: "get",
                                    dataType: "JSON",
                                    success: function (data) {
                                        $.each(data, function (index, val){
                                            console.log("성공")
// 마커를 생성합니다
                                            let markerPosition  = new kakao.maps.LatLng(val.mapy, val.mapx);
                                            let marker = new kakao.maps.Marker({
                                                position: markerPosition
                                            });

// 마커가 지도 위에 표시되도록 설정합니다
                                            marker.setMap(map);

                                            let iwContent = '<div style="padding:5px;">' +
                                                '<p> 이름 : '+val.title +'</p>'+
                                                '<p> 주소 : '+ val.addr1 +'</p>' +
                                                '<p> 전화번호 : '+ val.tel +'</p>'
                                            '</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                                                iwPosition = new kakao.maps.LatLng(val.mapy, val.mapx); //인포윈도우 표시 위치입니다

// 인포윈도우를 생성합니다
                                            let infowindow = new kakao.maps.InfoWindow({
                                                position : iwPosition,
                                                content : iwContent
                                            });

// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
                                            kakao.maps.event.addListener(marker, 'mouseover', function() {
                                                // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
                                                infowindow.open(map, marker);
                                            });

// 마커에 마우스아웃 이벤트를 등록합니다
                                            kakao.maps.event.addListener(marker, 'mouseout', function() {
                                                // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
                                                infowindow.close();
                                            });


                                    })},
                                    error: function (error) {
                                        console.log("실패");
                                    }
                                }
                            );



                    });

                } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

                    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),
                        message = 'geolocation을 사용할수 없어요..'

                    displayMarker(locPosition, message);
                }

                // 지도에 마커와 인포윈도우를 표시하는 함수입니다
                function displayMarker(locPosition, message) {

                    // 마커를 생성합니다
                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: locPosition
                    });

                    var iwContent = message, // 인포윈도우에 표시할 내용
                        iwRemoveable = true;

                    // 인포윈도우를 생성합니다
                    var infowindow = new kakao.maps.InfoWindow({
                        content: iwContent,
                        removable: iwRemoveable
                    });

                    // 인포윈도우를 마커위에 표시합니다
                    infowindow.open(map, marker);

                    // 지도 중심좌표를 접속위치로 변경합니다
                    map.setCenter(locPosition);


                }


            }


        </script>


    <p>현재 위치를 중심으로 반경 10km를 검색합니다.</p>
    <select id="ContentTypeID">
        <option value="14">문화시설</option>
        <option value="28">레포츠</option>
        <option value="32">숙박</option>
        <option value="38">쇼핑</option>
        <option value="39">음식점</option>
    </select>
    <button id="ScanStart" onclick="SetGPS()">검색</button>


        <div id="gpsList" name="gpsList">

        </div>

        <script>

            function executeCode() {
                navigator.geolocation.getCurrentPosition(function (position) {
                let lat = position.coords.latitude, // 위도
                    lon = position.coords.longitude; // 경도
                let ContentTypeId = document.getElementById("ContentTypeID").value;

                $.ajax({
                    url: "/tour/gpsScan",
                    data: {"mapX": lon,
                        "mapY": lat,
                        "ContentTypeId": ContentTypeId},
                    type: "get",
                    dataType: "JSON",
                    success: function (data) {
                        $.each(data, function (index, val){
                            $('#gpsList').append('<img src="' +val.firstimage+'" style="width:150px;height:150px;">' +
                                '<a href="/tour/gpsDetail?contentid='+val.contentid+'&title='+val.title+'&addr1='+val.addr1+'&tel='+val.tel+'&firstimage='+val.firstimage+'&mapx='+val.mapx+'&mapy='+val.mapy+'&contenttypeid='+ContentTypeId+'"> '+val.title+' <a/>' + '</br>')


            })}})})}



        </script>


        <input type="button" class="menu" id="menuBtn" onclick='executeCode()' value="목록 보기">

</div><a href="/index">메인 화면으로</a>
    </div>
</div>

</body>
