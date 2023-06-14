<%@ page import="com.example.pathfinder.dto.UserDTO" %>
<%@ page import="com.example.pathfinder.util.CmmUtil" %>
<%@ page import="com.example.pathfinder.dto.BoardDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    BoardDTO rDTO = (BoardDTO)request.getAttribute("rDTO");
    int access = 1; //(작성자 : 2 / 다른 사용자: 1)
    if (session.getAttribute("user")==null) {
        access = 1;
    }else {
        UserDTO uDTO = (UserDTO) session.getAttribute("user");

        if (uDTO.getUserNo() == Integer.parseInt(rDTO.getUserNo())) {
            access = 2;
        }
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

        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('preview').src = e.target.result;
                    document.getElementById('preview').style.textAlign="left";
                    document.getElementById('preview').style.width="450px";
                    document.getElementById('preview').style.height="350px";
                };
                reader.readAsDataURL(input.files[0]);
            } else {
                document.getElementById('preview').src = "";
            }
        }

        //작성자 여부체크
        function doOnload(){

            if ("<%=access%>"=="1"){
                alert("작성자만 수정할 수 있습니다.");
                location.href="/review/reviewList";

            }
        }

        //전송시 유효성 체크
        function doSubmit(f){
            if(f.title.value == ""){
                alert("제목을 입력하시기 바랍니다.");
                f.title.focus();
                return false;
            }

            if(calBytes(f.title.value) > 200){
                alert("최대 200Bytes까지 입력 가능합니다.");
                f.title.focus();
                return false;
            }

            if(f.contents.value == ""){
                alert("내용을 입력하시기 바랍니다.");
                f.contents.focus();
                return false;
            }
            if (f.s2.value == ""){
                alert("코스를 선택해주시기 바랍니다");
                f.s2.focus();
                return false
            }

            if(calBytes(f.contents.value) > 4000){
                alert("최대 4000Bytes까지 입력 가능합니다.");
                f.contents.focus();
                return false;
            }


        }
        $(document).ready(function () {
            $("preview").click(function () {
                $(this).attr('src',"");
            })
        });

        //글자 길이 바이트 단위로 체크하기(바이트값 전달)
        function calBytes(str){

            var tcount = 0;
            var tmpStr = new String(str);
            var strCnt = tmpStr.length;

            var onechar;
            for (i=0;i<strCnt;i++){
                onechar = tmpStr.charAt(i);

                if (escape(onechar).length > 4){
                    tcount += 2;
                }else{
                    tcount += 1;
                }
            }

            return tcount;
        }

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
            width: 60px;
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

        .subject {
            height: 1000px;
        }
    </style>

    <title>메인</title>
</head>
<body>
<div class="main">
    <div class="header">
        <div class="search">
            <input type="text" name="search" id="search" placeholder="검색어 입력">
            <input type="image" class="img" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search()">
            <input type="button" class="menu" id="menuBtn" onClick="location.href='LoginPage'" value="메뉴" >
        </div>
    </div>
    <div class="container">
        <form method="post" class="ui large form" encType="multipart/form-data" action="/reviewUpdate">
            <input type="text" id="title" name="title" value="<%=rDTO.getTitle()%>" placeholder="제목" autocomplete="off" autofocus="autofocus">
            <input type="hidden" name="nSeq" value="<%=CmmUtil.nvl(request.getParameter("nSeq")) %>" />
            <br><hr>
            <div class="field">
                <h4 align="left">내용</h4>
                <div class="ui left icon input">
                    <textarea style="resize: vertical;" id="contents" name="contents" placeholder="게시글 내용" rows="8"><%=rDTO.getContents()%></textarea>
                </div>
            </div>
            <div class="field">
                <label class="input-file-button" for="file">
                    사진첨부
                </label>
                <input style="display: none;" type="file" id="file" name="file" onchange="readURL(this);">
                <input type="hidden" id="imgLink" name="imgLink" value="<%=rDTO.getImglink()%>">
                <% if (rDTO.getImglink() != ""){
                %>
                <img id="preview" style="height: 450px;width: 350px" src="<%=rDTO.getImglink()%>" />
                <%}else{%>
                <img id="preview" />
                <%}%>
            </div>
            <div class="ui fluid large teal submit button" type="submit" id="write_bbs">
                <input class="submitBtn" type="submit" value="후기 수정">
            </div>
        </form>
    </div>
</div>

</body>
