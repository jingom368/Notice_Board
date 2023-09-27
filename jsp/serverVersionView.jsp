<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>
    <style>
        .info {
            position: relative;
            top: 150px;
            width: 60%;
            margin: auto;
            padding-left: 30px;
            font-size: 300%;
            border: solid 1px gray;
        }
    </style>
    <title>JSP/Servlet 버전 확인</title>
    <meta charset="UTF-8">
</head>


<body>
    <div></div>
        <div class="info">
            <ul>
                <li>서버 버전 : <%=application.getServerInfo() %></li>
                <li>서블릿 버전 : <%=application.getMajorVersion() %>.<%= application.getMinorVersion() %></li>
                <li>JSP 버전 : <%=JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %></li>
            </ul>
        </div>
    </div>  
</body>
</html>
