<%-- 23.10.05(목) JDBC --%>

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>멤버 등록</title>

    <link href="/board/style.css" type="text/css" rel="stylesheet">

    <script>
        function registerForm() {
            let rname = document.querySelector('#rname');
            let gender = document.querySelector('#gender');
            let age = document.querySelector('#age');

            // 필수값 등록시 값 입력 여부 확인
            if(rname.value === '') { // window.document.WriteForm.writer.value ---> DOM : Documetn Object Model
                alert('이름을 입력하세요!!!');
                writer.focus();
                return false;
            }
            if(gender.value === '') {
                alert('성별을 입력하세요!!!');
                title.focus();
                return false;
            }
            if(age.value === '') {
                alert('나이를 입력하세요!!!');
                content.focus();
                return false;
            }

            document.WriteForm.action = '/servlet/jdbctest_registry'
            document.WriteForm.submit();
        }
    </script>

</head>

<body>
    <div class = "main">
        <h1>멤버 등록</h1>
        <br>
        <div id="formZone">
            <form class="WriteForm" name="WriteForm" method="post">
                <input type="text" id="rname" class="items" name="rname" placeholder="멤버 이름을 입력하세요">
                <input type="text" id="gender" class="items" name="gender" placeholder="성별을 입력하세요">
                <input type="text" id="age" class="items" name="age" placeholder="나이를 입력하세요">
                <input type="button" class="btn_write" value="등록" onclick="registerForm()">
                <input type="button" class="btn_cancel" value="취소" onclick="history_back()">
            </form>
            
        </div>
        <br><br>

    </div>
</body>
</html>