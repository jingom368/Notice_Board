<%-- 23.09.27(수) JSP --%>

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 목록 보기</title>

    <link href="/board/style.css" type="text/css" rel="stylesheet">
</head>

<% 
    String uri = "jdbc:oracle:thin:@localhost:1521:xe";
    String userid = "springdev";
    String userpw = "12345";
    String query = "select seqno,title,writer,to_char(regdate,'YYYY-MM-DD HH24:MI:SS') as regdate,hitno from tbl_board order by seqno desc";

    //Response 시에 브라우저에 한글을 UTF-8로 인코딩해서 출력
    request.setCharacterEncoding("utf-8");

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
%>

<body>
    <div class="main">
        <img src="/images/logo.jpg" class="topBanner"><br>
        <h1 style="text-align:center;">게시물 목록</h1>
        <table class="InfoTable">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>

            <%
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver"); // Oracle JDBC 드라이버를 로딩
                    con = DriverManager.getConnection(uri, userid, userpw); // uri, userid, userpw 값으로 DB 연결 시도
                    stmt = con.createStatement(); // SQL이 실행될 수 있는 환경 생성 
                    rs = stmt.executeQuery(query); // SQL문을 실행해서 그 결과를 ResultSet이란 Collection 객체에 받는다.
                
                    while(rs.next()) {
            %>

                        <tr onmouseover="this.style.background='#46D2D2'" onmouseout="this.style.background='white'">
                            <td><%=rs.getInt("seqno") %></td>
                            <td style="text-align: left"><a href="/board/view.jsp?seqno=<%=rs.getInt("seqno") %>" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'"><%=rs.getString("title") %></a></td>
                            <td><%=rs.getString("writer") %></td>
                            <td><%=rs.getString("regdate") %></td>
                            <td><%=rs.getInt("hitno") %></td>
                        </tr>

            <%   
                    }

                    if(rs != null) rs.close();
                    if(stmt != null) stmt.close();
                    if(con != null) con.close(); 

                } catch(Exception e) {
                    e.printStackTrace();
                }     
            %>

        </table>
        <br>
        <div class="bottom_menu">
            <a href="/board/write.jsp">글쓰기</a>
        </div>
    </div>
</body>
</html>