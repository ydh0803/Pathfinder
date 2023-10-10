<%@ page import="com.example.pathfinder.dto.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% UserDTO uDTO = (UserDTO) session.getAttribute("user"); %>

<head>
    <style>
        @import url(https://fonts.googleapis.com/css?family=Open+Sans:400,700);

        body {
            background: #456;
            font-family: 'Open Sans', sans-serif;
        }

        .login {
            width: 700px;
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
    </style>
    <style>
        body {
            line-height:14px;
        }


        #calendar {
            max-width: 1100px;
            margin: 0 auto;
        }


        #form-div {
            padding:5px 5px 5px;
            width: 100%;
            margin-top:5px;
            -moz-border-radius: 7px;
            -webkit-border-radius: 7px;
        }

        .feedback-input {
            color:#3c3c3c;
            font-family: Helvetica, Arial, sans-serif;
            font-weight:400;
            font-size: 11px;
            border-radius: 0;
            line-height: 22px;
            background-color: #ffffff;
            padding: 3px 3px 3px 6px;
            margin-bottom: 10px;
            width:100%;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            -ms-box-sizing: border-box;
            box-sizing: border-box;
            border: 3px solid rgba(0,0,0,0);
        }

        .feedback-input:focus{
            background: #fff;
            /*border: 3px solid #3498db;*/
            border-color: #3498db;
            color: #3498db;
            outline: none;
            /*padding: 13px 13px 13px 54px;*/
        }

        .focused {
            color:#30aed6;
            border:#30aed6 solid 3px;
        }

        /* Icons */
        #name{
            background-image: url(http://rexkirby.com/kirbyandson/images/name.svg);
            background-size: 30px 30px;
            background-position: 11px 8px;
            background-repeat: no-repeat;
        }

        #email{
            background-image: url(http://rexkirby.com/kirbyandson/images/email.svg);
            background-size: 30px 30px;
            background-position: 11px 8px;
            background-repeat: no-repeat;
        }

        #comment{
            background-image: url(http://rexkirby.com/kirbyandson/images/comment.svg);
            background-size: 30px 30px;
            background-position: 11px 8px;
            background-repeat: no-repeat;
        }

        textarea {
            width: 100%;
            height: 150px;
            line-height: 150%;
            resize:vertical;
        }

        input:hover, textarea:hover,
        input:focus, textarea:focus {
            background-color:white;
        }

        #button-blue{
            font-family: 'Montserrat', Arial, Helvetica, sans-serif;
            float:left; /* 플롯 중요(::after 가상요소 이용)*/
            width: 100%;
            border: #fbfbfb solid 4px;
            cursor:pointer;
            background-color: #3498db;
            color:white;
            font-size:24px;
            padding-top:22px;
            padding-bottom:22px;
            -webkit-transition: all 0.3s;
            -moz-transition: all 0.3s;
            transition: all 0.3s;
            margin-top:-4px;
            font-weight:700;
        }

        #button-blue:hover{
            background-color: rgba(0,0,0,0);
            color: #0493bd;
        }

        .ease {
            width: 0;
            height: 74px;
            background-color: #fbfbfb;
            -webkit-transition: .3s ease;
            -moz-transition: .3s ease;
            -o-transition: .3s ease;
            -ms-transition: .3s ease;
            transition: .3s ease;
        }

        .submit:hover .ease{
            width:100%;
            background-color:white;
        }
    </style>
    <script src="/js/fullcalendar.js"></script>
    <link href="/css/fullcalendar.css" rel="stylesheet"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%--    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>--%>


    <script>
        document.addEventListener('DOMContentLoaded', function () {
            $(function () {
                var request = $.ajax({
                    url: "/signUp/getUserCalendar", // 변경하기
                    method: "GET",
                    data: {"userNo":<%=uDTO.getUserNo()%>},
                    dataType: "json"
                });
                request.done(function (data) {
                // calendar element 취득
                var calendarEl = document.getElementById('calendar');
                // full-calendar 생성하기
                var calendar = new FullCalendar.Calendar(calendarEl, {
                    height: '700px', // calendar 높이 설정
                    expandRows: true, // 화면에 맞게 높이 재설정
                    slotMinTime: '00:00', // Day 캘린더에서 시작 시간
                    slotMaxTime: '24:00', // Day 캘린더에서 종료 시간
                    // 해더에 표시할 툴바
                    headerToolbar: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'dayGridMonth,timeGridWeek'
                    }, //timeGridDay, listWeek
                    initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
                    // initialDate: '2023-07-15', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
                    navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
                    editable: true, // 수정 가능?
                    selectable: true, // 달력 일자 드래그 설정가능
                    droppable: true, //삭제
                    nowIndicator: true, // 현재 시간 마크
                    dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
                    locale: 'ko', // 한국어 설정
                    eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
                        console.log(obj);
                    },
                    eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
                        console.log(obj);
                    },
                    eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
                        console.log(obj);
                    },
                    drop: function (arg) {
                        // is the "remove after drop" checkbox checked?
                        if (document.getElementById('drop-remove').checked) {
                            // if so, remove the element from the "Draggable Events" list
                            arg.draggedEl.parentNode.removeChild(arg.draggedEl);
                        }
                    },
                    select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
                        var title = prompt('일정명을 입력해주세요.');
                        if (title) {
                            calendar.addEvent({
                                title: title,
                                start: arg.start,
                                end: arg.end,
                                allDay: arg.allDay
                            })
                        }
                        var events = new Array(); // Json 데이터를 받기 위한 배열 선언
                        var obj = new Object();     // Json 을 담기 위해 Object 선언
                        obj.title = title; // 이벤트 명칭  ConsoleLog 로 확인 가능.
                        obj.start = arg.start; // 시작
                        console.log(arg.start)
                        obj.end = arg.end; // 끝
                        console.log(arg.end)
                        obj.userNo = <%=uDTO.getUserNo()%>
                            events.push(obj);
                        $(function saveData(jsondata) {
                                $.ajax({
                                    url: "/signUp/insertCalendar",
                                    method: "POST",
                                    dataType: "json",
                                    data: JSON.stringify(events),
                                    contentType: 'application/json',
                                })
                                // .done(function (events) {
                                //     // alert(events);
                                // })
                                // .fail(function (request, status, error) {
                                //      // alert("에러 발생" + error);
                                // });
                                calendar.unselect()

                        });
                    },
                    eventClick: function (info){
                        if(confirm("'"+ info.event.title +"'일정을 삭제하시겠습니까 ?")){
                            // 확인 클릭 시
                            info.event.remove();
                            console.log(info.event);
                            var events = new Array(); // Json 데이터를 받기 위한 배열 선언
                            var obj = new Object();
                            obj.title = info.event._def.title;
                            obj.start = info.event._instance.range.start;
                            obj.end = info.event._instance.range.end;
                            obj.userNo = <%=uDTO.getUserNo()%>
                                events.push(obj);
                            console.log(events);
                        }
                        $(function deleteData(){
                            $.ajax({
                                url: "/signUp/deleteCalendar",
                                method: "DELETE",
                                dataType: "json",
                                data: JSON.stringify(events),
                                contentType: 'application/json',
                            })
                        })
                    },
                    /**
                     * data 로 값이 넘어온다. log 값 전달.
                     */
                    events: data
                });
                    calendar.render();
                });
                request.fail(function( jqXHR, textStatus ) {
                    alert( "Request failed: " + textStatus );
                });
            });
        });
    </script>

</head>
<body>
<div class="login">


    <h2 class="login-header">일정표</h2>

    <form class="login-container">
        <div id="contents">
            <div id="dialog" title="일정 관리" style="display:none;">
                <div id="form-div">
                    <form class="diaForm" id="diaForm" >
                        <input type="hidden" name="actType" value="C" /> <!-- C:등록 U:수정 D:삭제 -->
                        <input type="hidden" name="id" value="" />
                        <input type="hidden" name="start" value="" />
                        <input type="hidden" name="end" value="" />

                        <p class="name">
                            <input name="title" type="text" class="validate[required,custom[onlyLetter],length[0,100]] feedback-input" placeholder="일정타이틀" id="name" />
                        </p>

                        <p class="email">
                            <input name="xdate" type="text" readonly="readonly" class="validate[required,custom[email]] feedback-input"  placeholder="선택된날짜 및 시간" />
                        </p>

                        <p class="text">
                            <textarea name="xcontent" class="validate[required,length[6,300]] feedback-input" id="comment" placeholder="일정내용"></textarea>
                        </p>
                    </form>
                </div>
            </div>
            <br/>
            <div id='calendar'></div>
        </div>

    </form><a href="/index">메인 화면으로</a>
</div>
</body>