// 23.09.27(수) JSP/Servlet

package board;

import java.sql.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/board/delete")
public class delete extends HttpServlet {
    
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) {
        int seqno = Integer.parseInt(request.getParameter("seqno"));

        String uri = "jdbc:oracle:thin:@localhost:1521:xe";
        String userid = "springdev";
        String userpw = "12345";

        String query = "delete from tbl_board where seqno= " + seqno;

        Connection con;
        Statement stmt;

        try{

            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection(uri, userid, userpw);
            stmt = con.createStatement();
            stmt.executeUpdate(query);

            response.sendRedirect("/board/list.jsp");

        }catch(Exception e){
            e.printStackTrace();
        }

    }
    
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) {
        doGet(request, response);
    }
}
