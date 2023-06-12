<%@ page import="com.example.pathfinder.dto.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    UserDTO userDTO = (UserDTO) session.getAttribute("user");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>닉네임 변경</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        function doOnload(f) {
            if(f.user_name.value == ""){
                alert("닉네임을 입력해주시기 바랍니다.");
                f.user_name.focus();
                return false;
            }

            if(f.nameChkYN.value == "" || f.nameChkYN.value == "N"){
                alert("닉네임 중복체크를 해주시기 바랍니다.");
                f.user_name.focus();
                return false;
            }

        }
        function keyPress() {
            document.getElementById('nameChkYN').value = "N";
        }
        function nameCheck() {
            $.ajax({
                url : "/nameCheck",
                type : "POST",
                dataType :"JSON",
                data : {"userName" : $("#userName").val()},
                success : function (data) {
                    console.log(data)
                    if(data >= 1) {
                        alert("중복된 닉네임 입니다.");
                    } else if (data == 0) {
                        document.getElementById('nameChkYN').value = "Y";
                        alert("사용 가능한 닉네임 입니다.")
                    }
                }

            })
        }
    </script>
    <style type="text/css">
        .main{
            padding-top: 80px;
            text-align: center;
            max-width: 600px;
            height: 60%;
            padding-right:15px;
            padding-left:15px;
            margin-right:auto;
            margin-left:auto
        }
    </style>

</head>
<body>
<form name="join" method="post" action="/user/chgName" onsubmit="return doOnload(this);">
    <div class="main">
        <h2>닉네임 변경</h2>
        <div class="form-group">
            <input type="text" style="width:400px;height:35px;" id="userName" name="userName" placeholder="새로 사용하고 싶으신 닉네임을 입력해주세요" >
            <input type="hidden" id="nameChkYN" name="nameChkYN">
            <input type="hidden" id="userNo" name="userNo" onkeypress="" value="<%=userDTO.getUserNo()%>">
            <input type="button" class="btn btn-primary" value="중복체크" onclick="nameCheck()"><br>
            <input type="submit" class="btn btn-primary" value="변경">
        </div>
    </div>
</form>
</body>
</html>