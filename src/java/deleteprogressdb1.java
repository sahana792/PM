/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author user
 */
public class deleteprogressdb1 extends HttpServlet {

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

            // ------------------- DELETE LOGIC ----------------------
            String id = request.getParameter("id");

            if (id != null && !id.trim().equals("")) {

                Class.forName("com.mysql.jdbc.Driver");
                Connection con = new database.dbconfig().getConnection();

                String sql = "DELETE FROM projectprogress1 WHERE id = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, id);

                int rows = ps.executeUpdate();

                ps.close();
                con.close();

                if (rows > 0) {
                    response.sendRedirect("mviewprogress.jsp?msg=Record+deleted+successfully");
                } else {
                    response.sendRedirect("mviewprogress.jsp?msg=Record+not+found");
                }

            } else {
                response.sendRedirect("mviewprogress.jsp?msg=Invalid+ID");
            }
            // -------------------------------------------------------

        }
        catch(Exception e)
        {
            response.sendRedirect("mviewprogress.jsp?msg=Error:+ " + e.getMessage());
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
