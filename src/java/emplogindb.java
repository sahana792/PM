import database.dbconfig;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class emplogindb extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String mid = request.getParameter("mid");
            String pass = request.getParameter("pass");

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = new dbconfig().getConnection();
            Statement stat = con.createStatement();

            // CHECK LOGIN
            ResultSet rs = stat.executeQuery(
                    "SELECT * FROM employee WHERE mid='" + mid + "' AND pass='" + pass + "'");

            if (rs.next()) {

                // -------------------------
                //  ⭐ STORE SESSION ⭐
                // -------------------------
                HttpSession session = request.getSession();
                session.setAttribute("mid", mid);               // employee ID
                session.setAttribute("ename", rs.getString("name"));  // employee name (optional)

                // -------------------------
                //  ⭐ MARK ATTENDANCE ⭐
                // -------------------------
                Statement st2 = con.createStatement();
                st2.executeUpdate(
                        "INSERT INTO employeeattendance(mid, name, logintime, date) "
                      + "VALUES('" + mid + "', '" + rs.getString("name") + "', CURTIME(), CURDATE())"
                );

                // Redirect to employee home page
                response.sendRedirect("empdashboard.jsp");

            } else {
                response.sendRedirect("emplogin.jsp?error=invalid");
            }

        } catch (Exception e) {
            out.println(e);
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
