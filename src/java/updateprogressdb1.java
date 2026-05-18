import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import database.dbconfig;

public class updateprogressdb1 extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // Get parameters from the form
            String id = request.getParameter("id");
            String phono = request.getParameter("phono");
            String updateTitle = request.getParameter("update_title");
            String progressStatus = request.getParameter("progress_status");
            String completionPercentage = request.getParameter("completion_percentage");
            String description = request.getParameter("description");
            String updateDate = request.getParameter("update_date");
            String nextMilestone = request.getParameter("next_milestone");
            
            // Validate required fields
            if (id == null || id.trim().isEmpty()) {
                out.print("<script>alert('Error: Progress ID is required!'); window.history.back();</script>");
                return;
            }
            
            // Database connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = new dbconfig().getConnection();
            
            // Use PreparedStatement to prevent SQL injection
            String sql = "UPDATE projectprogress1 SET update_title = ?, progress_status = ?, " +
                        "completion_percentage = ?, description = ?, update_date = ?, next_milestone = ? " +
                        "WHERE id = ?";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, updateTitle);
            ps.setString(2, progressStatus);
            ps.setString(3, completionPercentage);
            ps.setString(4, description);
            ps.setString(5, updateDate);
            ps.setString(6, nextMilestone);
            ps.setInt(7, Integer.parseInt(id));
            
            int result = ps.executeUpdate();
            
            ps.close();
            con.close();
            
            if (result > 0) {
                out.print("<script>alert('Progress Updated Successfully!'); window.location='eviewprogress.jsp?msg=Progress Updated Successfully';</script>"); 
            } else {
                out.print("<script>alert('Failed to update progress'); window.history.back();</script>");
            }
            
        } catch(Exception e) {
            out.print("<script>alert('Error: " + e.getMessage() + "'); window.history.back();</script>");
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
