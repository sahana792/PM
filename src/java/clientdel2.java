import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import database.dbconfig;

@WebServlet(name = "clientdel2", urlPatterns = {"/clientdel2"})
public class clientdel2 extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String id = request.getParameter("id");
        
        Connection con = null;
        PreparedStatement pst = null;
        
        try {
            // Debug: Check if ID is received
            if (id == null || id.trim().isEmpty()) {
                response.sendRedirect("aclientrequirement.jsp?msg=noid");
                return;
            }
            
            Class.forName("com.mysql.jdbc.Driver");
            con = new dbconfig().getConnection();
            
            // Check if connection is successful
            if (con == null) {
                response.sendRedirect("aclientrequirement.jsp?msg=connection_error");
                return;
            }
            
            String query = "DELETE FROM requirements WHERE id=?";
            pst = con.prepareStatement(query);
            pst.setInt(1, Integer.parseInt(id));
            
            int result = pst.executeUpdate();
            
            if (result > 0) {
                response.sendRedirect("aclientrequirement.jsp?msg=deleted");
            } else {
                response.sendRedirect("aclientrequirement.jsp?msg=notfound");
            }
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("aclientrequirement.jsp?msg=invalid_id");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("aclientrequirement.jsp?msg=error");
        } finally {
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
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
        return "Servlet to delete client requirements";
    }
}