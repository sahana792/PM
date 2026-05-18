import database.dbconfig;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/taskdb")
public class taskdb extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String phono = request.getParameter("phono");  // Get phone number from form
        List<Map<String, String>> projects = new ArrayList<>();

        if (phono != null && !phono.trim().isEmpty()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = new dbconfig().getConnection();
                PreparedStatement pst = con.prepareStatement("SELECT * FROM requirments WHERE phono=?");
                pst.setString(1, phono);
                ResultSet res = pst.executeQuery();

                while (res.next()) {
                    Map<String, String> project = new HashMap<>();
                    project.put("project_name", res.getString("type")); // Assuming project_name = type
                    project.put("client_name", res.getString("cname"));
                    project.put("task_status", res.getString("status"));
                    project.put("email", res.getString("email"));
                    project.put("phono", res.getString("phono"));
                    project.put("domain", res.getString("domain"));
                    project.put("address", res.getString("address"));
                    project.put("deliveredon", res.getString("deliveredon"));
                    project.put("cost", res.getString("cost"));
                    project.put("note", res.getString("note"));
                    projects.add(project);
                }

                res.close();
                pst.close();
                con.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("projects", projects);
        request.getRequestDispatcher("taskprogress.jsp").forward(request, response);
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
}
