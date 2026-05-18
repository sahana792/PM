<%@page import="java.sql.*"%>
<%@page import="database.dbconfig"%>
<%@page contentType="text/plain" pageEncoding="UTF-8"%>
<%
    String id = request.getParameter("id");
    String status = request.getParameter("status");

    try {
        Connection con = new dbconfig().getConnection();
        String sql = "UPDATE mpadd1 SET status=? WHERE id=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, Integer.parseInt(id));
        ps.executeUpdate();
        con.close();
        out.print("Success");
    } catch(Exception e) {
        out.print("Error: " + e);
    }
%>
