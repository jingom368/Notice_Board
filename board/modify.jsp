<%-- 23.09.27(수) JSP --%>

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 등록</title>

    <link href="/board/style.css" type="text/css" rel="stylesheet">

    <script>
        function modifyForm() {
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

            document.ModifyForm.action = '/board/modify';
            document.ModifyForm.submit();
        }
    </script>

</head>

<%
    int seqno = Integer.parseInt(request.getParameter("seqno"));

    String uri = "jdbc:oracle:thin:@localhost:1521:xe";
    String userid = "springdev";
    String userpw = "12345";
    String query = "select seqno,title,writer,to_char(regdate,'YYYY-MM-DD HH24:MI:SS') as regdate,content from tbl_board where seqno= " + seqno;

    String writer = "";
    String title = "";
    String regdate = "";
    String content = "";

    //Response 시에 브라우저에 한글을 UTF-8로 인코딩해서 출력
    request.setCharacterEncoding("utf-8");

    Connection con;
    Statement stmt;
    ResultSet rs;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver"); // Oracle JDBC 드라이버를 로딩
        con = DriverManager.getConnection(uri, userid, userpw); // uri, userid, userpw 값으로 DB 연결 시도
        stmt = con.createStatement(); // SQL이 실행될 수 있는 환경 생성 
        rs = stmt.executeQuery(query); // SQL문을 실행해서 그 결과를 ResultSet이란 Collection 객체에 받는다.

        if(rs.next()) {
            writer = rs.getString("writer");
            title = rs.getString("title");
            regdate = rs.getString("regdate");
            content = rs.getString("content");
        }

        if(rs != null) rs.close();
        if(stmt != null) stmt.close();
        if(con != null) con.close(); 

        }catch(Exception e) {
            e.printStackTrace();
        }  

%>

<body>
    <div class = "main">
        <img src="/images/logo.jpg" class="topBanner"><br>
        <h1>게시물 등록</h1>
        <br>
        <div id="formZone">
            <form class="ModifyForm" name="ModifyForm" method="post">
                <input type="text" id="writer" class="items" name="writer" value="<%=writer %>">
                <input type="text" id="title" class="items" name="title" value="<%=title %>">
                <input type="hidden" name="seqno" value="<%=seqno %>">
                <br><br>
                <textarea id="content" cols="100" rows="500" name="content"><%= content %></textarea>
                <input type="button" class="btn_write" value="수정" onclick="modifyForm()">
                <input type="button" class="btn_cancel" value="취소" onclick="history_back()">
            </form>
            
        </div>
        <br><br>

    </div>
</body>
</html>