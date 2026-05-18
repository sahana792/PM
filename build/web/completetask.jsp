<%@page import="java.sql.*"%>
<%@page import="database.dbconfig"%>
<%
    String pid = request.getParameter("pid");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = new dbconfig().getConnection();
        PreparedStatement ps = con.prepareStatement("UPDATE mpadd1 SET status='Completed' WHERE pid=?");
        ps.setString(1, pid);
        ps.executeUpdate();
        con.close();
        response.sendRedirect("myProjects.jsp"); // Redirect back to your projects page
    } catch(Exception e){
        out.println("Error: " + e);
    }
%>
