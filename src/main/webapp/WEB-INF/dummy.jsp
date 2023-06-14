<%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />--%>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">--%>
<%--<!-- Latest compiled and minified CSS -->--%>
<%--<link rel="stylesheet" href="/css/bootstrap.min.css">--%>
<%--<html>--%>
<%--<head>--%>

<%--    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">--%>
<%--    <title>회원가입</title>--%>
<%--    <script>--%>
<%--        function mailCheck() {--%>
<%--            let i = document.join.mail3.selectedIndex // 선택항목의 인덱스 번호--%>
<%--            let domain = document.join.mail3.options[i].value // 선택항목 value--%>
<%--            document.join.user_maildomain.value=domain--%>
<%--        }--%>
<%--        function doSubmit(f){--%>
<%--            if(f.user_id.value == ""){--%>
<%--                alert("아이디를 입력해주시기 바랍니다.");--%>
<%--                f.user_id.focus();--%>
<%--                return false;--%>
<%--            }--%>
<%--            if(f.user_name.value == ""){--%>
<%--                alert("닉네임을 입력해주시기 바랍니다.");--%>
<%--                f.user_name.focus();--%>
<%--                return false;--%>
<%--            }--%>
<%--            if(f.user_mailid.value == ""){--%>
<%--                alert("이메일을 입력해주시기 바랍니다.");--%>
<%--                f.user_mailid.focus();--%>
<%--                return false;--%>
<%--            }--%>
<%--            if(f.user_maildomain.value == ""){--%>
<%--                alert("도메인을 선택해주시기 바랍니다.");--%>
<%--                f.user_maildomain.focus();--%>
<%--                return false;--%>
<%--            }--%>
<%--            if(f.idChkYN.value == ""){--%>
<%--                alert("아이디 중복체크를 해주시기 바랍니다.");--%>
<%--                f.user_id.focus();--%>
<%--                return false;--%>
<%--            }--%>
<%--            if(f.nameChkYN.value == ""){--%>
<%--                alert("닉네임 중복체크를 해주시기 바랍니다.");--%>
<%--                f.user_id.focus();--%>
<%--                return false;--%>
<%--            }--%>
<%--            if(f.pwChkYN.value == ""){--%>
<%--                alert("비밀번호가 일치하지않습니다");--%>
<%--                f.user_pw.focus();--%>
<%--                return false;--%>
<%--            }--%>
<%--            if(f.mailChkYN.value == ""){--%>
<%--                alert("이메일 중복체크를 해주시기 바랍니다.");--%>
<%--                f.user_id.focus();--%>
<%--                return false;--%>
<%--            }--%>
<%--            if(f.certificationYN.value == ""){--%>
<%--                alert("메일인증을 해주시기 바랍니다.");--%>
<%--                f.certificationYN.focus();--%>
<%--                return false;--%>
<%--            }--%>
<%--        }--%>
<%--        function mailcheck(){--%>
<%--            let i = document.join.mail3.selectedIndex // 선택항목의 인덱스 번호--%>
<%--            let mail = document.join.mail3.options[i].value // 선택항목 value--%>
<%--            document.join.user_maildomain.value=mail--%>
<%--        }--%>
<%--        function isEmail(asValue) {--%>
<%--            let regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;--%>
<%--            return regExp.test(asValue);--%>
<%--        }--%>


<%--    </script>    <script>--%>
<%--    function idCheck() {--%>
<%--        $.ajax({--%>
<%--            url : "/idCheck",--%>
<%--            type : "POST",--%>
<%--            dataType :"JSON",--%>
<%--            data : {"user_id" : $("#user_id").val()},--%>
<%--            success : function (result) {--%>
<%--                console.log(result)--%>
<%--                if(result >= 1) {--%>
<%--                    alert("중복된 아이디입니다.");--%>
<%--                } else if (result == 0) {--%>
<%--                    $("#idChk").attr("value", "Y");--%>
<%--                    document.getElementById('idChkYN').value = "Y";--%>
<%--                    alert("사용 가능한 아이디입니다.")--%>
<%--                }--%>
<%--            }--%>
<%--        })--%>
<%--    }--%>
<%--    function emailCheck() {--%>
<%--        let clientEmailId = document.getElementById('user_mailid').value;--%>
<%--        let clientEmailDomain = document.getElementById('user_maildomain').value;--%>
<%--        console.log(clientEmailId)--%>
<%--        console.log(clientEmailDomain)--%>
<%--        if (clientEmailDomain==="" || clientEmailId===""){--%>
<%--            alert("공백없이 입력해주시기 바랍니다.");--%>
<%--            return--%>
<%--        }--%>
<%--        $.ajax({--%>
<%--            url : "/mailCheck",--%>
<%--            type : "POST",--%>
<%--            dataType :"JSON",--%>
<%--            data : {user_mailid: clientEmailId , user_maildomain:clientEmailDomain},--%>
<%--            success : function (data) {--%>
<%--                console.log(data)--%>
<%--                if(data >= 1) {--%>
<%--                    alert("중복된 이메일입니다.");--%>
<%--                } else if (data == 0) {--%>
<%--                    document.getElementById('mailChkYN').value = "Y";--%>
<%--                    alert("사용 가능한 이메일입니다.")--%>
<%--                }--%>
<%--            }--%>
<%--        })--%>
<%--    }--%>
<%--    function nameCheck() {--%>
<%--        $.ajax({--%>
<%--            url : "/nameCheck",--%>
<%--            type : "POST",--%>
<%--            dataType :"JSON",--%>
<%--            data : {"user_name" : $("#user_name").val()},--%>
<%--            success : function (data) {--%>
<%--                console.log(data)--%>
<%--                if(data >= 1) {--%>
<%--                    alert("중복된 닉네임 입니다.");--%>
<%--                } else if (data == 0) {--%>
<%--                    document.getElementById('nameChkYN').value = "Y";--%>
<%--                    alert("사용 가능한 닉네임 입니다.")--%>
<%--                }--%>
<%--            }--%>
<%--        })--%>
<%--    }--%>
<%--</script>    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>--%>
<%--    <script>--%>
<%--        function check_pw(){--%>
<%--            let pw = document.getElementById('pw').value;--%>
<%--            let SC = ["!","@","#","$","%","*"];--%>
<%--            let check_SC = 0;--%>
<%--            if(pw.length < 8 || pw.length>16){--%>
<%--                window.alert('비밀번호는 8글자 이상, 16글자 이하만 이용 가능합니다.');--%>
<%--                document.getElementById('pw').value='';--%>
<%--            }--%>
<%--            for(let i=0;i<SC.length;i++){--%>
<%--                if(pw.indexOf(SC[i]) != -1){--%>
<%--                    check_SC = 1;--%>
<%--                }--%>
<%--            }--%>
<%--            if(check_SC == 0){--%>
<%--                window.alert('비밀번호에는 특수문자가 포함되어야 합니다.')--%>
<%--                document.getElementById('pw').value='';--%>
<%--            }--%>
<%--            if(document.getElementById('pw').value !='' && document.getElementById('pw2').value!=''){--%>
<%--                if(document.getElementById('pw').value==document.getElementById('pw2').value){--%>
<%--                    document.getElementById('check').innerHTML='비밀번호가 일치합니다.'--%>
<%--                    document.getElementById('check').style.color='blue';--%>
<%--                    document.getElementById('pwChkYN').value='Y';--%>
<%--                }--%>
<%--                else{--%>
<%--                    document.getElementById('check').innerHTML='비밀번호가 일치하지 않습니다.';--%>
<%--                    document.getElementById('check').style.color='red';--%>
<%--                }--%>
<%--            }--%>
<%--        }--%>
<%--    </script>--%>
<%--    <style>--%>
<%--        @import url(https://fonts.googleapis.com/css?family=Open+Sans:400,700);--%>
<%--        *, *:before, *:after {--%>
<%--            -moz-box-sizing: border-box;--%>
<%--            -webkit-box-sizing: border-box;--%>
<%--            box-sizing: border-box;--%>
<%--        }--%>
<%--        body {--%>
<%--            background: #456;--%>
<%--            font-family: 'Open Sans', sans-serif;--%>
<%--        }--%>
<%--        .row {--%>
<%--            width: 400px;--%>
<%--            margin: 16px auto;--%>
<%--            font-size: 16px;--%>
<%--        }--%>
<%--        .header {--%>
<%--            background: #28d;--%>
<%--            padding: 20px;--%>
<%--            font-size: 1.4em;--%>
<%--            font-weight: normal;--%>
<%--            text-align: center;--%>
<%--            text-transform: uppercase;--%>
<%--            color: #fff;--%>
<%--        }--%>
<%--        .container {--%>
<%--            background: #ebebeb;--%>
<%--            padding: 12px;--%>
<%--        }--%>
<%--        h1 {--%>
<%--            margin: 0 0 30px 0;--%>
<%--            text-align: center;--%>
<%--        }--%>
<%--        input[type="text"],--%>
<%--        input[type="password"],--%>
<%--        input[type="date"],--%>
<%--        input[type="datetime"],--%>
<%--        input[type="email"],--%>
<%--        input[type="number"],--%>
<%--        input[type="search"],--%>
<%--        input[type="tel"],--%>
<%--        input[type="time"],--%>
<%--        input[type="url"],--%>
<%--        textarea,--%>
<%--        select {--%>
<%--            border: none;--%>
<%--            font-size: 16px;--%>
<%--            height: auto;--%>
<%--            margin: 0;--%>
<%--            outline: 0;--%>
<%--            padding: 15px;--%>
<%--            width: 100%;--%>
<%--            background: #e8eeef;--%>
<%--            color: #8a97a0;--%>
<%--            box-shadow: 0 1px 0 rgba(0,0,0,0.03) inset;--%>
<%--            margin-bottom: 30px;--%>
<%--        }--%>
<%--        input[type="email"],--%>
<%--        select {--%>
<%--            border: none;--%>
<%--            font-size: 16px;--%>
<%--            height: auto;--%>
<%--            margin: 0;--%>
<%--            outline: 0;--%>
<%--            padding: 15px;--%>
<%--            width: 40%;--%>
<%--            background: #e8eeef;--%>
<%--            color: #8a97a0;--%>
<%--            box-shadow: 0 1px 0 rgba(0,0,0,0.03) inset;--%>
<%--            margin-bottom: 30px;--%>
<%--        }--%>
<%--        input[type="radio"],--%>
<%--        input[type="checkbox"] {--%>
<%--            margin: 0 4px 8px 0;--%>
<%--        }--%>
<%--        button {--%>
<%--            padding: 19px 39px 18px 39px;--%>
<%--            background: #28d;--%>
<%--            border-color: transparent;--%>
<%--            color: #fff;--%>
<%--            cursor: pointer;--%>
<%--            font-size: 18px;--%>
<%--            text-align: center;--%>
<%--            width: 100%;--%>
<%--        }--%>
<%--        fieldset {--%>
<%--            margin-bottom: 30px;--%>
<%--            border: none;--%>
<%--        }--%>
<%--        legend {--%>
<%--            font-size: 1.4em;--%>
<%--            margin-bottom: 10px;--%>
<%--        }--%>
<%--        label {--%>
<%--            display: block;--%>
<%--            margin-bottom: 8px;--%>
<%--        }--%>
<%--        label.light {--%>
<%--            font-weight: 300;--%>
<%--            display: inline;--%>
<%--        }--%>
<%--        .number {--%>
<%--            background-color: #5fcf80;--%>
<%--            color: #fff;--%>
<%--            height: 30px;--%>
<%--            width: 30px;--%>
<%--            display: inline-block;--%>
<%--            font-size: 0.8em;--%>
<%--            margin-right: 4px;--%>
<%--            line-height: 30px;--%>
<%--            text-align: center;--%>
<%--            text-shadow: 0 1px 0 rgba(255,255,255,0.2);--%>
<%--            border-radius: 100%;--%>
<%--        }--%>
<%--        @media screen and (min-width: 480px) {--%>
<%--            form {--%>
<%--                max-width: 480px;--%>
<%--            }--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<form name="join" method="post" action="/signUpReg" onsubmit="return doSubmit(this);">--%>
<%--    <div class="row">--%>
<%--        <div class="col-md-12">--%>
<%--            <form action="Main.html" method="post">--%>
<%--                <h1 class="header" > 회 원 가 입 </h1>--%>
<%--                <div class="container">--%>
<%--                    <legend>내 정보</legend>--%>

<%--                    <label for="user_id">아이디</label>--%>
<%--                    <input type="text" id="user_id" name="user_id" placeholder="아이디">--%>
<%--                    <input type="hidden" class="form-control" name="idChkYN" id="idChkYN">--%>
<%--                    <button class="btn btn-primary" class="idChk" type="button" id="idChk" onclick="idCheck()" value="N">중복체크</button>--%>


<%--                    <label for="pw">비밀번호</label>--%>
<%--                    <input type="password" name="user_pw" id="pw" onchange="check_pw()" placeholder="비밀번호">--%>

<%--                    <label for="pw2">비밀번호 확인</label>--%>
<%--                    <input type="password" name="user_pw_check" id="pw2" onchange="check_pw()" placeholder="비밀번호 확인">--%>
<%--                    <span id="check"></span>--%>
<%--                    <input type="hidden" class="form-control" name="pwChkYN" id="pwChkYN">--%>

<%--                    <label for="user_mailid">이메일</label>--%>
<%--                    <div class="input-group mb-3">--%>
<%--                        <input type="text" class="form-control" id="user_mailid" name="user_mailid" placeholder="Email">--%>
<%--                    </div>--%>
<%--                    <input type="hidden" class="form-control" name="mailChkYN" id="mailChkYN">--%>
<%--                    <button type="button" class="btn btn-primary" onclick="emailCheck()">중복체크</button>--%>

<%--                    <button type="submit">가입</button>--%>
<%--                    <button type="button" onclick="location.href='main.html'">취소</button>--%>
<%--                </div>--%>
<%--            </form>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</form>--%>
<%--</body>--%>
<%--</html>--%>