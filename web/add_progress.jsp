<%@page import="java.sql.*"%>
<%@page import="database.dbconfig"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String phono = request.getParameter("phono");
    String title = request.getParameter("title");
    String status = request.getParameter("status");
    String completion = request.getParameter("completion");
    String desc = request.getParameter("description");
    String udate = request.getParameter("udate");
    String milestone = request.getParameter("milestone");

    try {
        Connection con = new dbconfig().getConnection();
        String sql = "INSERT INTO projectprogress1 (phono, update_title, progress_status, completion_percentage, description, update_date, next_milestone, created_at) VALUES (?,?,?,?,?,?,?,NOW())";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, phono);
        ps.setString(2, title);
        ps.setString(3, status);
        ps.setString(4, completion);
        ps.setString(5, desc);
        ps.setString(6, udate);
        ps.setString(7, milestone);

        int i = ps.executeUpdate();

        if (i > 0) {
            out.println("<script>alert('Progress added successfully'); window.location='emptask.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to add progress'); history.back();</script>");
        }

        con.close();
    } catch(Exception e) {
        out.println("<script>alert('Error: "+e+"'); history.back();</script>");
    }
%>
