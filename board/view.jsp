<%-- 23.09.26(화) JSP --%>

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 내용 보기</title>
    <link href="/board/style.css" type="text/css" rel="stylesheet">
<%
    int seqno = Integer.parseInt(request.getParameter("seqno"));
%>
    <script>
        function boardDelete() {
            if(confirm("정말 삭제 하시겠습니까?") == true) document.location.href = '/board/delete?seqno=<%=seqno %>';  
        }
    </script>
</head>

<% 
    String uri = "jdbc:oracle:thin:@localhost:1521:xe";
    String userid = "springdev";
    String userpw = "12345";
    String query = "select seqno,title,writer,to_char(regdate,'YYYY-MM-DD HH24:MI:SS') as regdate,content from tbl_board where seqno= " + seqno;
    String query_hitno = "update tbl_board set hitno = (select nvl(hitno, 0) from tbl_board where seqno = " + seqno + ") + 1 where seqno = " + seqno;

    String query_prev = "select max(seqno) as prev_seqno from tbl_board where seqno < " + seqno;
    String query_next = "select min(seqno) as next_seqno from tbl_board where seqno > " + seqno;

    System.out.println("게시물 상세 보기 SQL = " + query);
    System.out.println("게시물 상세 보기 SQL = " + query_hitno);

    String writer = "";
    String title = "";
    String regdate = "";
    String content = "";

    int prev_seqno = 0;
    int next_seqno = 0;

    //Response 시에 브라우저에 한글을 UTF-8로 인코딩해서 출력
    request.setCharacterEncoding("utf-8");

    Connection con;
    Statement stmt;
    Statement stmt_hitno;
    Statement stmt_prev;
    Statement stmt_next; 
    ResultSet rs;
    ResultSet rs_prev;
    ResultSet rs_next;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver"); // Oracle JDBC 드라이버를 로딩
        con = DriverManager.getConnection(uri, userid, userpw); // uri, userid, userpw 값으로 DB 연결 시도
        stmt = con.createStatement(); // SQL이 실행될 수 있는 환경 생성 
        stmt_hitno = con.createStatement();
        stmt_prev = con.createStatement();
        stmt_next = con.createStatement();
        rs = stmt.executeQuery(query); // SQL문을 실행해서 그 결과를 ResultSet이란 Collection 객체에 받는다.
        rs_prev = stmt_prev.executeQuery(query_prev); // SQL문을 실행해서 그 결과를 ResultSet이란 Collection 객체에 받는다.
        rs_next = stmt_next.executeQuery(query_next); // SQL문을 실행해서 그 결과를 ResultSet이란 Collection 객체에 받는다.
        stmt_hitno.executeUpdate(query_hitno);

        if(rs.next()) { // 게시물 상세 값 가져오기
            writer = rs.getString("writer");
            title = rs.getString("title");
            regdate = rs.getString("regdate");
            content = rs.getString("content");
        }

        // 이전/다음 게시물 번호 값 가져 오기
        if(rs_prev.next()) prev_seqno = rs_prev.getInt("prev_seqno");
        if(rs_next.next()) next_seqno = rs_next.getInt("next_seqno");

        if(rs != null) rs.close();
        if(rs_prev != null) rs.close();
        if(rs_next != null) rs.close();
        
        if(stmt != null) stmt.close();
        if(stmt_hitno != null) stmt.close();
        if(stmt_prev != null) stmt.close();
        if(stmt_next != null) stmt.close();
        if(con != null) con.close(); 

    }catch(Exception e) {
        e.printStackTrace();
    }     
%>

<body>
    <div class="main">
        <img src="/images/logo.jpg" class="topBanner"><br>
        <h1 style="text-align:center;">게시물 내용 보기</h1>
        <br>
        
        <div class = "boardView">
            <div class="items_v">글쓴이 : <%=writer %></div>
            <div class="items_v">제목 : <%=title %></div>
            <div class="items_v">날짜 : <%=regdate %></div>
            <div class="textArea"><pre>내용 : <%=content %></pre></div>
        </div>

        <div class="bottom_menu">
            
        <% if (prev_seqno != 0) { %> 
            <a href="/board/view.jsp?seqno=<%=prev_seqno%>">이전</a>&nbsp;&nbsp;
        <% } %>
            <a href="/board/list.jsp">목록가기</a>&nbsp;&nbsp;
        <% if (next_seqno != 0) { %>
            <a href="/board/view.jsp?seqno=<%=next_seqno%>">다음</a>&nbsp;&nbsp;
        <% } %>
            <a href="/board/write.jsp">글 작성</a>&nbsp;&nbsp;
            <a href="/board/modify.jsp?seqno=<%=seqno%>">글 수정</a>&nbsp;&nbsp;
            <a href="javascript:boardDelete()">글 삭제</a>
        </div>
        <br><br>
    </div>
</body>
</html>