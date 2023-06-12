<%@ page import="com.example.pathfinder.dto.UserDTO" %>
<%@ page import="com.example.pathfinder.util.CmmUtil" %>
<%@ page import="com.example.pathfinder.dto.BoardDTO" %>
<%@ page import="com.example.pathfinder.dto.CommentDTO" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    BoardDTO rDTO = (BoardDTO) request.getAttribute("rDTO");
    List<CommentDTO> rList= (List<CommentDTO>) request.getAttribute("rList");
    int res = (Integer) request.getAttribute("res");

//공지글 정보를 못불러왔다면, 객체 생성
    if (rDTO == null) {
        rDTO = new BoardDTO();

    }
    int edit = 1;

//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
    if (session.getAttribute("user")==null) {
        edit = 3;
    } else {
        UserDTO uDTO = (UserDTO) session.getAttribute("user");
        int ssUserNo = uDTO.getUserNo();

//로그인 안했다면....
        if (uDTO == null) {
            edit = 3;

//본인이 작성한 글이면 2가 되도록 변경
        } else if (String.valueOf(ssUserNo).equals(String.valueOf(rDTO.getUserNo()))) {
            // 비교 작업 수행
        }


        edit = 2;


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

            //댓글쓰기
            function doReply() {
            if ("<%=edit%>" == 3) {
            alert("로그인 하시길 바랍니다.");
            return false;
        } else {
            let data = new Array();
            let obj = new Object();
            let boardNo = <%=rDTO.getBoardNo()%>;
            let comment = document.getElementById("content").value;
            console.log(comment)
            obj.boardNo = boardNo
            obj.comment = comment
            console.log(comment)
            data.push(obj)
            console.log(data)
            $.ajax({
            url: '/commentReg',
            method: 'post',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function () {
            location.reload();
        }
        })
        }
        }
            function editReply(rid, reg_id, content){
            var htmls = "";
            htmls += '<div style="font-size: 16px" class="card-body" id="repbox'+rid+'">';
            htmls += '<title>Placeholder</title>';
            htmls += '<rect width="100%" height="100%" fill="#007bff"></rect>';
            htmls += '<p>';
            htmls += '<span>';
            htmls += '<strong class="text-gray-dark">' + reg_id + '</strong>';
            htmls += '<span style="padding-left: 7px; font-size: 12pt">';
            htmls += '<a href="javascript:void(0)" onclick="updateReply('+rid+')" style="padding-right:5px">저장</a>';
            htmls += '<a href="javascript:void(0)" onClick="location.reload()">취소<a>';
            htmls += '</span>';
            htmls += '</span>';
            htmls += '<textarea name="editContent" id="editContent" class="form-control" rows="3">';
            htmls += content;
            htmls += '</textarea>';
            htmls += '</p>';
            htmls += '</div>';
            $('#repbox' + rid).replaceWith(htmls);
            $('#repbox' + rid + '#editContent').focus();
        }
            function updateReply(rid){
            let commentNo = rid
            let content = document.getElementById('editContent').value
            if (content == ""){
            alert('최소 1글자 이상 입력해야합니다.')
            return
        }
            let data = new Array();
            let obj = new Object();
            obj.commentNo = commentNo
            obj.commentText = content
            data.push(obj)
            console.log(data)
            $.ajax({
            url: '/commentUpdate',
            method: 'post',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function () {
            location.reload();
        }
        })

        }

            function doEdit() {
            if ("<%=edit%>" == 2) {
            location.href = "/review/reviewEdit?nSeq=<%=CmmUtil.nvl(String.valueOf(rDTO.getBoardNo()))%>";

        } else if ("<%=edit%>" === 3) {
            alert("로그인 하시길 바랍니다.");

        } else {
            alert("본인이 작성한 글만 수정 가능합니다.");
        }
        }
            //삭제하기
            function doDelete() {
            if ("<%=edit%>" == 2) {
            if (confirm("작성한 글을 삭제하시겠습니까?")) {
            location.href = "/reviewDelete?nSeq=<%=String.valueOf(rDTO.getBoardNo())%>";

        }
        } else if ("<%=edit%>" == 3) {
            alert("로그인 하시길 바랍니다.");

        } else {
            alert("본인이 작성한 글만 삭제 가능합니다.");
        }
        }
            function repDelete(cNo) {

            let commentNo = cNo
            let data = new Array();
            let obj = new Object();
            obj.commentNo =commentNo
            data.push(obj)
            console.log(data)
            if (confirm("작성한 댓글을 삭제하시겠습니까?")) {
            $.ajax({
            url:'/repDelete',
            method:'post',
            contentType:'application/json',
            data:JSON.stringify(data) ,
            success: function (){
            location.reload();
        },
        })
        }
        }

            //목록으로 이동
            function doList() {
            location.href = "/review/reviewList";

        }

    </script>



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
            top: 10px;
            right: 12px;
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
        <div class="box" style="width: 100%; font-size: 24px">
            <h2><%=rDTO.getTitle()%></h2>
        </div>
            <hr>
        <div class="box" style="display:flex;width: 100%;color: #272a15">
            <p>작성자 : <%=rDTO.getUserName()%>&nbsp;&nbsp;|&nbsp;&nbsp;</p><p>작성일 : <%=rDTO.getRegdate().substring(0,16)%></p>
        </div>
        <div class="box" style="width: 100%; font-size:16px">
            <% if (rDTO.getImglink() != null) { %>

            <c:set var="link" value="<%=CmmUtil.nvl(rDTO.getImglink())%>"></c:set>
            <c:choose>
                <c:when test="${link eq ''}">
                </c:when>
                <c:otherwise>
                    <br>
                    <img src="<%=CmmUtil.nvl(rDTO.getImglink())%>" width="40%" height="40%">
                </c:otherwise>
            </c:choose>
            <br>
            <% } %>
            <p><%=rDTO.getContents()%></p>
        </div>
        <hr>
        <div class="box">
            <a href="javascript:doEdit();">[수정]</a>
            <a href="javascript:doDelete();">[삭제]</a>
            <a href="javascript:doList();">[목록]</a>
        </div>




    <div class="card my-4">
        <h5 class="card-header">댓글 작성</h5>
        <div class="card-body">
            <div class="form-group">
                <textarea id="content" name="content" class="form-control" rows="2"></textarea>
            </div>
            <button class="btn btn-primary" onclick="doReply()">등록</button>
        </div>
        <div class="card my-4">
            <h5 class="card-header">댓글 목록[<%=res%>]</h5>
            <%
                for (int i = 0; i < rList.size(); i++) {
                    CommentDTO cDTO = rList.get(i);

                    if (cDTO == null) {
                        cDTO = new CommentDTO();
                    }

            %>
            <div class="card-body" id="repbox<%=cDTO.getCommentNo()%>">
                <a><%=CmmUtil.nvl(cDTO.getUserName()) %></a>
                <a><%=cDTO.getRegdate().substring(0,16)%></a>
                <%
                    if (session.getAttribute("user")!=null){
                        UserDTO uDTO = (UserDTO) session.getAttribute("user");
                        if (uDTO.getUserNo()==cDTO.getUserNo()){
                %>
                <a href="javascript:repDelete('<%=cDTO.getCommentNo()%>')">삭제</a><a>&nbsp;&nbsp;|&nbsp;&nbsp;</a><a href="javascript:editReply('<%=cDTO.getCommentNo()%>','<%=cDTO.getUserName()%>','<%=cDTO.getCommentText()%>')">수정</a>
                <%
                        }
                    }
                %>
                <br>
                <a><%=CmmUtil.nvl(cDTO.getCommentText()) %></a>
            </div>
            <hr>
            <%
                }
            %>
        </div>
    </div>
    </div>
</div>

</body>
