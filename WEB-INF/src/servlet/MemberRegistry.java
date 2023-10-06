// 23.10.05(목) JSP/Servlet

package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;


@WebServlet("/servlet/jdbctest_registry")
public class MemberRegistry extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request,response);
    }
    
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        request.setCharacterEncoding("utf-8");
        String uri = "jdbc:oracle:thin:@localhost:1521:xe";
        String userid = "springdev";
        String userpw = "12345";

        Connection con = null;
        Statement stmt = null;

        String name = request.getParameter("rname");
        String gender = request.getParameter("gender");
        String age = request.getParameter("age");

        String query = "insert into tbl_test (id, name, gender, age) values " 
                    + "(tbl_test_seq.nextval, '" + name + "','" + gender + "',"  + age + ")";
        System.out.println("멤버 등록 SQL : " + query); 

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection(uri, userid, userpw);
            stmt = con.createStatement();
            stmt.executeUpdate(query);

            if(stmt != null) stmt.close();
            if(con != null) con.close();

            response.sendRedirect("/jsp/jdbctest_oracle.jsp"); // Redirect 함으로써 값을 response의 값을 받아옴

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
