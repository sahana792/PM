import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import database.dbconfig;

public class updateprogressdb extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // Get parameters from the form
            String id = request.getParameter("id");
            String phono = request.getParameter("phono");
            String updatetitle = request.getParameter("update_title");
            String progressstatus = request.getParameter("progress_status");
            String completionpercentage = request.getParameter("completion_percentage");
            String description = request.getParameter("description");
            String updatedate = request.getParameter("update_date");
            String nextmilestone = request.getParameter("next_milestone");
            
            // Debug output (optional - remove in production)
            out.print("Updating data: ID=" + id + ", " + updatetitle + ", " + progressstatus + ", " + 
                     completionpercentage + "%, " + updatedate + "<br>");
            
            // Database connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = new dbconfig().getConnection();
            
            // Use PreparedStatement to prevent SQL injection
            String sql = "UPDATE projectprogress1 SET " +
                        "update_title = ?, " +
                        "progress_status = ?, " +
                        "completion_percentage = ?, " +
                        "description = ?, " +
                        "update_date = ?, " +
                        "next_milestone = ? " +
                        "WHERE id = ?";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, updatetitle);
            ps.setString(2, progressstatus);
            ps.setString(3, completionpercentage);
            ps.setString(4, description);
            ps.setString(5, updatedate);
            ps.setString(6, nextmilestone);
            ps.setString(7, id);
            
            int result = ps.executeUpdate();
            
            ps.close();
            con.close();
            
            if (result > 0) {
                out.print("<script>alert('Progress Update Modified Successfully!');</script>"); 
                out.println("<meta http-equiv='refresh' content='1; url=mviewprogress.jsp?phono=" + phono + "' />");
            } else {
                out.print("<script>alert('Failed to update progress');</script>");
                out.println("<meta http-equiv='refresh' content='2; url=editprogress.jsp?id=" + id + "&phono=" + phono + "' />");
            }
            
        } catch(Exception e) {
            out.print("<h3>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace(out);
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
        return "Servlet for updating project progress";
    }
}