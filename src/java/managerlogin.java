import database.dbconfig;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class managerlogin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            String mid = request.getParameter("mid");
            String pass = request.getParameter("pass");
            
            // Validate input
            if(mid == null || pass == null || mid.trim().isEmpty() || pass.trim().isEmpty()) {
                response.sendRedirect("mlogin.jsp?error=empty");
                return;
            }
            
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = new dbconfig().getConnection();
            Statement stat = con.createStatement();
            
            ResultSet rs = stat.executeQuery("SELECT * FROM manager WHERE mid='" + mid + "' AND pass='" + pass + "'");
            
            if(rs.next()) {
                // Login successful - CREATE SESSION
                HttpSession session = request.getSession();
                session.setAttribute("mid", mid);
                
                con.close();
                response.sendRedirect("mdashboard.jsp");
            } else {
                // Login failed
                con.close();
                response.sendRedirect("mlogin.jsp?error=invalid");
            }
        } catch(Exception e) {
            out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Manager Login Servlet";
    }
}