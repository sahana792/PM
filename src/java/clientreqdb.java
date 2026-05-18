/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import database.dbconfig;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author user
 */
public class clientreqdb extends HttpServlet {
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
       
        try {
            /* TODO output your page here. You may use following sample code. */
            String cname = request.getParameter("cname");
            String email = request.getParameter("email");
            String phono = request.getParameter("phono");
            String title = request.getParameter("title");
            String requirements = request.getParameter("requirements"); 
            String description = request.getParameter("description");
            String deadline = request.getParameter("deadline");
            String status = request.getParameter("status");
            
            out.print(cname+" "+email+" "+phono+" "+title+" "+requirements+" "+description+" "+deadline+" "+status+" ");
            
            // Use the newer MySQL driver (or keep the old one if you prefer)
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = new dbconfig().getConnection();
            
            // Use PreparedStatement to prevent SQL injection
            String sql = "INSERT INTO `requirements` (`cname`, `email`, `phono`, `title`, `requirements`, `description`, `deadline`, `status`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            
            pstmt.setString(1, cname);
            pstmt.setString(2, email);
            pstmt.setString(3, phono);
            pstmt.setString(4, title);
            pstmt.setString(5, requirements);
            pstmt.setString(6, description);
            pstmt.setString(7, deadline);
            pstmt.setString(8, status);
            
            int rowsInserted = pstmt.executeUpdate();
            
            if(rowsInserted > 0) {
                out.print("<script>alert('Requirement Accepted')</script>"); 
                out.println("<meta http-equiv='refresh' content='0;url=clientrequirement.jsp' />");
            }
            
            pstmt.close();
            con.close();
        }
        catch(Exception e) {
            out.print("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}