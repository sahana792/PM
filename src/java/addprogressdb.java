import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import database.dbconfig;

public class addprogressdb extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            // Get parameters from the form
            String projectId = request.getParameter("project_id");
            String phono = request.getParameter("phono");
            String updateTitle = request.getParameter("update_title");
            String progressStatus = request.getParameter("progress_status");
            String completionPercentage = request.getParameter("completion_percentage");
            String description = request.getParameter("description");
            String updateDate = request.getParameter("update_date");
            String nextMilestone = request.getParameter("next_milestone");
            
            // Validate required fields
            if (phono == null || phono.trim().isEmpty()) {
                response.sendRedirect("addprogress.jsp?id=" + projectId + "&error=phone_required");
                return;
            }
            
            if (projectId == null || projectId.trim().isEmpty()) {
                response.sendRedirect("addprogress.jsp?error=project_id_required");
                return;
            }
            
            // Database connection
            Class.forName("com.mysql.jdbc.Driver");
            con = new dbconfig().getConnection();
            
            // Check if a record already exists for this project ID
            String checkSql = "SELECT id FROM projectprogress1 WHERE id = ?";
            ps = con.prepareStatement(checkSql);
            ps.setInt(1, Integer.parseInt(projectId));
            rs = ps.executeQuery();
            
            if (rs.next()) {
                // Record exists - UPDATE it
                rs.close();
                ps.close();
                
                String updateSql = "UPDATE projectprogress1 SET " +
                                  "phono = ?, " +
                                  "update_title = ?, " +
                                  "progress_status = ?, " +
                                  "completion_percentage = ?, " +
                                  "description = ?, " +
                                  "update_date = ?, " +
                                  "next_milestone = ? " +
                                  "WHERE id = ?";
                
                ps = con.prepareStatement(updateSql);
                ps.setString(1, phono);
                ps.setString(2, updateTitle);
                ps.setString(3, progressStatus);
                ps.setString(4, completionPercentage);
                ps.setString(5, description);
                ps.setString(6, updateDate);
                ps.setString(7, nextMilestone);
                ps.setInt(8, Integer.parseInt(projectId));
                
                int result = ps.executeUpdate();
                
                if (result > 0) {
                    // Redirect back to the same page with success message
                    response.sendRedirect("addprogress.jsp?id=" + projectId + "&success=updated");
                } else {
                    response.sendRedirect("addprogress.jsp?id=" + projectId + "&error=update_failed");
                }
                
            } else {
                // Record doesn't exist - INSERT with the SAME project ID
                rs.close();
                ps.close();
                
                String insertSql = "INSERT INTO projectprogress1 (id, phono, update_title, progress_status, " +
                                  "completion_percentage, description, update_date, next_milestone, created_at) " +
                                  "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";
                
                ps = con.prepareStatement(insertSql);
                ps.setInt(1, Integer.parseInt(projectId));
                ps.setString(2, phono);
                ps.setString(3, updateTitle);
                ps.setString(4, progressStatus);
                ps.setString(5, completionPercentage);
                ps.setString(6, description);
                ps.setString(7, updateDate);
                ps.setString(8, nextMilestone);
                
                int result = ps.executeUpdate();
                
                if (result > 0) {
                    // Redirect back to the same page with success message
                    response.sendRedirect("addprogress.jsp?id=" + projectId + "&success=added");
                } else {
                    response.sendRedirect("addprogress.jsp?id=" + projectId + "&error=insert_failed");
                }
            }
            
        } catch(Exception e) {
            String projectId = request.getParameter("project_id");
            e.printStackTrace(out);
            response.sendRedirect("addprogress.jsp?id=" + projectId + "&error=" + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace(out);
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
        return "Servlet for adding project progress updates";
    }
}