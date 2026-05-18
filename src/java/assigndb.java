/*
 * OPTIMIZED VERSION - Only stores assignment-specific data
 * Project details are fetched from requirements table when needed
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
public class assigndb extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            // Only get the data we need to store
            String projectId = request.getParameter("project_id");
            String startdate = request.getParameter("startdate");
            String enddate = request.getParameter("enddate");
            String technology = request.getParameter("technology");
            String status = request.getParameter("status");
            
            // Get array of employee IDs
            String[] employeeIds = request.getParameterValues("mid[]");
            
            if (employeeIds == null || employeeIds.length < 2) {
                out.print("<script>alert('Please select at least 2 employees!'); window.history.back();</script>");
                return;
            }
            
            Class.forName("com.mysql.jdbc.Driver");
            con = new dbconfig().getConnection();
            
            // OPTIMIZED: Only insert assignment-specific data
            // Project details will be fetched from requirements table using JOIN
            String insertSql = "INSERT INTO mpadd1 (project_id, startdate, enddate, technology, mid, status) " +
                              "VALUES (?, ?, ?, ?, ?,?)";
            
            ps = con.prepareStatement(insertSql);
            
            int successCount = 0;
            
            // Insert one record for each employee
            for (String employeeId : employeeIds) {
                if (employeeId != null && !employeeId.trim().isEmpty()) {
                    ps.setString(1, projectId);      // References requirements.id
                    ps.setString(2, startdate);
                    ps.setString(3, enddate);
                    ps.setString(4, technology);
                    ps.setString(5, employeeId);     // Individual employee ID
                    ps.setString(6, status);
                    
                    int result = ps.executeUpdate();
                    if (result > 0) {
                        successCount++;
                    }
                }
            }
            
            if (successCount > 0) {
                out.print("<script>alert('Task assigned to " + successCount + " employee(s) successfully!'); window.location.href='addprogress.jsp?id=" + projectId + "';</script>");
            } else {
                out.print("<script>alert('Failed to assign task!'); window.history.back();</script>");
            }
            
        } catch(Exception e) {
            out.print("<script>alert('Error: " + e.getMessage() + "'); window.history.back();</script>");
            e.printStackTrace(out);
        } finally {
            try {
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
        return "Optimized Task Assignment Servlet";
    }
}