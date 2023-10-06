<%-- 23.09.25(월) JSP --%>

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<% 
    String uri = "jdbc:oracle:thin:@localhost:1521:xe";
    String userid = "springdev";
    String userpw = "12345";
    String query = "select id, name, gender, age from tbl_test order by id desc";

    Connection con;
    Statement stmt;
    ResultSet rs ;
%>

<!DOCTYPE html>
<html>
<head>
    <title>JDBC 연동 JSP 예제</title>
    <style>
        .main {
            text-align: center;
        }
        .InfoTable {
            border-collapse: collapse;
            border: 3px solid #168;
            width: 800px;
            margin: auto;
	    text-align: center;
        }
        .InfoTable th {
            color: #168;
            background: #f0f6f9;
        }
        .InfoTable th, .InfoTable td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        .InfoTable th:first-child, .InfoTable td:first-child {
            border-left: 0;
        }
        .InfoTable th:last-child, .InfoTable td:last-child {
            border-right: 0;
        }
        .InfoTable tr td:first-child{
            text-align: center;
        }

        .bottom_menu {
            margin-top : 20px;
        }
        .bottom_menu > a:link, .bottom_menu > a:visited {
            background-color: #ffa500;
            color: maroon;
            padding: 15px 25px;
            text-align: center;
            display: inline-block;
            text-decoration: none;
        }
        .bottom_menu > a:hover, .bottom_menu > a:active {
            background-color: #1E90FF;
            text-decoration : none;
        }
        
    </style>

</head>

<body>
    <div class="main">
        <h1>JDBC 연동 JSP 예제 - DBMS : Oracle</h1>
        <table class="InfoTable">
            <tr>
                <th>번호</th>
                <th>이름</th>
                <th>성별</th>
                <th>나이</th>
            </tr>

            <%
                try {
                Class.forName("oracle.jdbc.driver.OracleDriver"); // Oracle JDBC 드라이버를 로딩
                con = DriverManager.getConnection(uri, userid, userpw); // uri, userid, userpw 값으로 DB 연결 시도
                stmt = con.createStatement(); // SQL이 실행될 수 있는 환경 생성 
                rs = stmt.executeQuery(query); // SQL문을 실행해서 그 결과를 ResultSet이란 Collection 객체에 받는다.
                
                while(rs.next()) {

            %>

            <tr>
                <td><%=rs.getInt("id") %></td>
                <td><%=rs.getString("name") %></td>
                <td><%=rs.getString("gender") %></td>
                <td><%=rs.getInt("age") %></td>
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
            <a href="/jsp/jdbctest_registry.jsp">멤버 등록</a>
        </div>
        <br><br>

    </div>
</body>
</html>