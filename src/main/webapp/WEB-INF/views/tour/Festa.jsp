<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="com.example.pathfinder.dto.FestaDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.pathfinder.util.ApiFesta" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    List<FestaDTO> rList = (List<FestaDTO>) request.getAttribute("list");%>

<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>

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

<h2 class="header">축제 지도</h2>
    <div class="container">
    <div id="map2" style="width:100%;height:500px;"></div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=344db8e40afa1ae457b074b2bc2932bc&libraries=services"></script>
    <script type="text/javascript">

        navigator.geolocation.getCurrentPosition(function(position) {

            let latitude = position.coords.latitude; // 위도
            let longitude = position.coords.longitude; // 경도

            let mapContainer2 = document.getElementById('map2'), // 지도를 표시할 div
                mapOption2 = {
                    center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
                    level: 8 // 지도의 확대 레벨
                };
            let map2 = new kakao.maps.Map(mapContainer2, mapOption2);


        });
        function getLocation(){
            let area = document.getElementById("areaCode").value
            console.log(area)
            let ac = "";
            if (area == 1) {
                ac = "서울특별시"
            } else if (area == 2) {
                ac = "인천광역시"
            } else if (area == 3) {
                ac = "대전광역시"
            } else if (area == 4) {
                ac = "대구광역시"
            } else if (area == 5) {
                ac = "광주광역시"
            } else if (area == 6) {
                ac = "부산광역시"
            } else if (area == 7) {
                ac = "울산광역시"
            } else if (area == 8) {
                ac = "세종특별자치시"
            } else if (area == 31) {
                ac = "경기도"
            } else if (area == 32) {
                ac = "강원도"
            } else if (area == 33) {
                ac = "충청북도"
            } else if (area == 34) {
                ac = "충청남도"
            } else if (area == 35) {
                ac = "경상북도"
            } else if (area == 36) {
                ac = "경상남도"
            } else if (area == 37) {
                ac = "전라북도"
            } else if (area == 38) {
                ac = "전라남도"
            } else if (area == 39) {
                ac = "제주특별자치도"
            }
            console.log(ac)
            console.log(area)
            let geocoder = new kakao.maps.services.Geocoder();
            geocoder.addressSearch(ac, function(result, status) {
                let y = result[0].y
                let x = result[0].x
                let mapContainer2 = document.getElementById('map2'), // 지도를 표시할 div
                    mapOption2 = {
                        center: new kakao.maps.LatLng(y, x), // 지도의 중심좌표
                        level: 10 // 지도의 확대 레벨
                    };
                let map2 = new kakao.maps.Map(mapContainer2, mapOption2);

                viewWeather(x, y);

                markerSet();

                function markerSet(){
                    $.ajax({
                        url: "/tour/Festa",
                        data: {"area": area},
                        type: "get",
                        dataType: "JSON",
                        success: function (data) {
                            console.log("성공")
                            $.each(data, function (index, val){
                                console.log(val.mapx)
                                console.log(val.mapy)


                                let markerPosition  = new kakao.maps.LatLng(val.mapy, val.mapx);

// 마커를 생성합니다
                                let marker = new kakao.maps.Marker({
                                    position: markerPosition
                                });

// 마커가 지도 위에 표시되도록 설정합니다
                                marker.setMap(map2);

                                let iwContent = '<div style="padding:5px;">' +
                                        '<p> 축제명<br>'+val.title +'</p>'+
                                        '<p> 축제주소<br>'+ val.addr1 +'</p>' +
                                        '<p> 축제기간<br>'+val.eventstartdate + '~' + val.eventenddate +'</p>' +
                                        '<p> 전화번호<br>'+ val.tel +'</p>'
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
                                    infowindow.open(map2, marker);
                                });

// 마커에 마우스아웃 이벤트를 등록합니다
                                kakao.maps.event.addListener(marker, 'mouseout', function() {
                                    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
                                    infowindow.close();
                                });

                            });
                        }

                    })
                }
            });
        }

    </script>

    <div class="main">
    <select id="areaCode">
        <option value="1">서울</option>
        <option value="2">인천</option>
        <option value="3">대전</option>
        <option value="4">대구</option>
        <option value="5">광주</option>
        <option value="6">부산</option>
        <option value="7">울산</option>
        <option value="8">세종</option>
        <option value="31">경기</option>
        <option value="32">강원</option>
        <option value="33">충북</option>
        <option value="34">충남</option>
        <option value="35">경북</option>
        <option value="36">경남</option>
        <option value="37">전북</option>
        <option value="38">전남</option>
        <option value="39">제주</option>
    </select>
        <button type="submit" id="find" onclick="getLocation()">찾기</button>
    </div>
        <div>
            <span id="currentTemp" name="currentTemp"></span>
            <div id="dailyWeather">


            </div>
        </div>

        <script>

            function viewWeather(x, y) {
                let lat = y, lon = x;


                console.log(lat, lon)

                $.ajax({
                    url: "/weather/getWeather",
                    data: {
                        "lon": lon,
                        "lat": lat
                    },
                    type: "get",
                    dataType: "JSON",
                    success: function (json) {
                        console.log("성공")
                        $('#currentTemp').append("현재 기온" + json.currentTemp)

                        const dailyList = json.dailyList;

                        for (const daily of dailyList) {

                            let day = daily.day;
                            let dayTemp = daily.dayTemp;
                            let description = daily.description;
                            let pop = daily.pop * 100;

                            $('#dailyWeather').append("<div><b>" + day + "</b></div>");
                            $('#dailyWeather').append("<div><b>평균 기온 : " + dayTemp + "°C</b></div>");
                            $('#dailyWeather').append("<div><b>날  씨 : " + description + "</b></div>");
                            $('#dailyWeather').append("<div><b>강수 확률 : " + pop + "%</b></div>");
                            $('#dailyWeather').append("<div><br></div>");

                        }


                    }

                })

            }

        </script>
<%--        <input type="button" class="menu" onclick='viewWeather()' value="날씨 보기">--%>
    </div>



<a href="/index">메인 화면으로</a>
</div>
</div>

</body>
