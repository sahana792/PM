/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import database.dbconfig;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author user
 */
public class mprojectdb extends HttpServlet {

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
        String pname = request.getParameter("pname");
        String cname = request.getParameter("cname");
        String phono = request.getParameter("phono");
        String description = request.getParameter("description");
        String startdate = request.getParameter("startdate");
        String enddate = request.getParameter("enddate");
        String manager = request.getParameter("manager");
        String budget = request.getParameter("budget");
        String technology = request.getParameter("technology");
        out.print(pname+" "+cname+" "+phono+" "+description+" "+startdate+" "+enddate+" "+manager+" "+budget+" "+technology+" ");
        
        
                Class.forName("com.mysql.jdbc.Driver");
                Connection con=new dbconfig().getConnection();
                Statement stat=con.createStatement();
                stat.executeUpdate("INSERT INTO `mpadd`(`pname`, `cname`, `phono`, `description`, `startdate`, `enddate`, `manager`, `budget`, `technology`) VALUES ('"+pname+"','"+cname+"','"+phono+"','"+description+"','"+startdate+"','"+enddate+"','"+manager+"','"+budget+"','"+technology+"')");
                out.print("<script>alert('Project Added')</script>"); 
                out.println("<meta http-equiv = \"refresh\" content = \"0;mhome.jsp\" />");
        }
        catch(Exception e)
        {
            out.print(e);
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
