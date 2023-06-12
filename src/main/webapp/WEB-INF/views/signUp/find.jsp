<%@ page import="com.example.pathfinder.dto.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

    int edit = 1;
//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
    if (session.getAttribute("user")==null) {
        edit = 3;
    } else {
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        int ss_userNo = uDTO.getUserNo();
//로그인 안했다면....
    }
    int rep = 0;
    if (session.getAttribute("user")!=null) {
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        rep = uDTO.getUserNo();
    }
%>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function search() {
            let keyword = $('#search').val()
            console.log(keyword)
            let aaa = encodeURI(keyword)
            console.log(aaa)

            location.href="/keywordSearch?AR=" + aaa
        }

        function chksearch() {
            if(f.search.value == ""){
                alert("검색어를 입력해주세요.");
                f.search.focus();
                return false;
            }
        }

        let msg = "${msg}";

        if (msg != "") {
            alert(msg);
        }

        function findId(){
            let data = new Array();
            let obj = new Object();
            let userMail= document.getElementById("userMail").value;
            let mail = userMail.split('@')
            console.log(mail)
            let userMailid = mail[0];
            console.log(userMailid)
            let userMaildomain= mail[1];
            console.log(userMaildomain)
            if (userMailid==="" || userMaildomain===""){
                alert("공백없이 입력해주시기 바랍니다.");
                return
            }
            obj.userMailid = userMailid
            obj.userMaildomain = userMaildomain
            data.push(obj)
            console.log(data)
            $.ajax({
                url:'/findId',
                method:'POST',
                contentType: 'application/json',
                data:JSON.stringify(data),
                success: function(result) {
                    result.forEach(function (res) {
                        alert('회원님의 아이디는 '+res.userId+'입니다.')
                        $('#resultForm').append('<h2 style="text-align: center">조회결과</h2>')
                        $('#resultForm').append('<h4 style="text-align: center">회원님의 아이디는 '+res.userId+' 입니다'+'</h4>')
                    });

                }
            })

        }

        function doSubmit(f){
            if(f.userMailid.value == ""){
                alert("이메일을 입력해주시기 바랍니다.");
                f.userMailid.focus();
                return false;
            }

            if(f.userMaildomain.value == ""){
                alert("도메인을 선택해주시기 바랍니다.");
                f.userMaildomain.focus();
                return false;
            }
        }
        // function sendPw(){
        //     let userMail= document.getElementById("userEmail").value;
        //     let mail = userMail.split('@')
        //     console.log(mail)
        //     let userMailid = mail[0];
        //     console.log(userMailid)
        //     let userMaildomain= mail[1];
        //     console.log(userMaildomain)
        //     let userId = document.getElementById("userId").value;
        //     console.log(userId);
        //     $.ajax({
        //         url: "/sendPw",
        //         type: "get",
        //         data: {
        //             "userMailid" : userMailid,
        //             "userMaildomain" : userMaildomain,
        //             "userId" : userId
        //         },
        //         success: function() {
        //             alert('비밀번호가 재발급되었습니다. 로그인후 변경해주세요')
        //             window.close()
        //         }
        //
        //     })
        //
        // }


    </script>
    <style>
        .search {
            position: relative;
            width: 300px;
        }

        input {
            width: 100%;
            border: 1px solid #bbb;
            border-radius: 8px;
            padding: 10px 12px;
            font-size: 14px;
        }

        .img {
            position: absolute;
            width: 17px;
            top: 0px;
            right: 0px;
            margin: 0;
        }

        .menu {
            position: absolute;
            width: 45px;
            height: 35px;
        }

        .admin {
            position: absolute;
            right: -60px;
            width: 20px;
            height: 35px;
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

        .login input[type="text"],
        .login input[type="password"] {
            background: #fff;
            border-color: #bbb;
            color: #555;
        }

        /* Text fields' focus effect */
        .login input[type="text"]:focus,
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
    <div class="header">
        <h2> 아이디 / 비밀번호 찾기 </h2>
    </div>
    <div class="container">

        <div class="section text-center">
            <h4 class="mb-4 pb-3">아이디 찾기</h4>
            <div class="form-group">
                <input type="email" id="userMail" name="userMail" class="form-style" placeholder="이메일">
            </div>
            <br/>
            <a onclick="findId()" class="btn mt-4">아이디 찾기</a>
            <div style="margin-left: -10%" id="resultForm">
            </div>
        </div>

        <div class="section text-center">
            <h4 class="mb-4 pb-3">비밀번호 재발급</h4>
            <div class="form-group">
                <input type="text" name="userId" class="form-style" placeholder="아이디" id="userId" autocomplete="off">
                <i class="input-icon uil uil-user"></i>
            </div>
            <br/>
            <div class="form-group mt-2">
                <input type="email" name="userEmail" class="form-style" placeholder="이메일" id="userEmail" autocomplete="off">
                <i class="input-icon uil uil-at"></i>
            </div>
            <br/>
            <a onclick="sendPw();" class="btn mt-4">비밀번호 재발급</a>
        </div>
    </div>

    </div>
</div>

</body>
