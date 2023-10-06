// 23.09.27(수) JSP/Servlet

package board;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/board/modify")
public class modify extends HttpServlet{
    
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        request.setCharacterEncoding("utf-8"); // 예외 처리 해야함
        String uri = "jdbc:oracle:thin:@localhost:1521:xe";
        String userid = "springdev";
        String userpw = "12345";

        Connection con = null;
        Statement stmt = null;

        int seqno = Integer.parseInt(request.getParameter("seqno"));
        String writer = request.getParameter("writer");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        String query = "update tbl_board set writer = '" + writer + "' ,title = '" + title + "', content = '" + content +  "' where seqno = " + seqno;
        System.out.println("게시물 수정 SQL : " + query); 

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection(uri, userid, userpw);
            stmt = con.createStatement();
            stmt.executeUpdate(query);

            if(stmt != null) stmt.close();
            if(con != null) con.close();

            response.sendRedirect("/board/view.jsp?seqno=" + seqno);

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
