<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 등록</title>

    <link href="/board/style.css" type="text/css" rel="stylesheet">

    <script>
        function registerForm() {
            let writer = document.querySelector('#writer');
            let title = document.querySelector('#title');
            let content = document.querySelector('#content');

            // 필수값 등록시 값 입력 여부 확인
            if(writer.value === '') { // window.document.WriteForm.writer.value ---> DOM : Documetn Object Model
                alert('이름을 입력하세요!!!');
                writer.focus();
                return false;
            }
            if(title.value === '') {
                alert('제목을 입력하세요!!!');
                title.focus();
                return false;
            }
            if(content.value === '') {
                alert('내용을 입력하세요!!!');
                content.focus();
                return false;
            }

            document.WriteForm.action = '/board/write'
            document.WriteForm.submit();
        }
    </script>

</head>

<body>
    <div class = "main">
        <img src="/images/logo.jpg" class="topBanner"><br>
        <h1>게시물 등록</h1>
        <br>
        <div id="formZone">
            <form class="WriteForm" name="WriteForm" method="post">
                <input type="text" id="writer" class="items" name="writer" placeholder="작성자 이름을 입력하세요">
                <input type="text" id="title" class="items" name="title" placeholder="제목을 입력하세요">
                <br><br>
                <textarea id="content" cols="100" rows="500" name="content" placeholder="내용을 입력하세요"></textarea>
                <input type="button" class="btn_write" value="등록" onclick="registerForm()">
                <input type="button" class="btn_cancel" value="취소" onclick="history_back()">
            </form>
            
        </div>
        <br><br>

    </div>
</body>
</html>