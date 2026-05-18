<%@page import="database.dbconfig"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Assign Task</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f6fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .message-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            text-align: center;
            max-width: 500px;
        }
        .success {
            color: #28a745;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .error {
            color: #dc3545;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin-top: 20px;
            font-weight: bold;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <%
        String projectId = request.getParameter("id");
        String pname = request.getParameter("pname");
        String cname = request.getParameter("cname");
        String phono = request.getParameter("phono");
        String description = request.getParameter("description");
        String startdate = request.getParameter("startdate");
        String enddate = request.getParameter("enddate");
        String manager = request.getParameter("manager");
        String mid = request.getParameter("mid");
        String status = request.getParameter("status");
        String budget = request.getParameter("budget");
        String technology = request.getParameter("technology");
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = new dbconfig().getConnection();
            
            String sql = "INSERT INTO mpadd (pname, cname, phono, description, startdate, enddate, manager, budget, technology, mid, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, pname);
            ps.setString(2, cname);
            ps.setString(3, phono);
            ps.setString(4, description);
            ps.setString(5, startdate);
            ps.setString(6, enddate);
            ps.setString(7, manager);
            ps.setString(8, budget);
            ps.setString(9, technology);
            ps.setString(10, mid);
            ps.setString(11, status);
            
            int result = ps.executeUpdate();
            
            ps.close();
            con.close();
            
            if (result > 0) {
    %>
                <div class="message-container">
                    <div class="success">
                        ✓ Task Assigned Successfully!
                    </div>
                    <p>The project "<strong><%= pname %></strong>" has been assigned to employee <strong><%= mid %></strong>.</p>
                    <a href="assigntask.jsp?id=<%= projectId %>" class="btn">Assign Another Task</a>
                    <a href="clientrequirements.jsp" class="btn" style="background-color: #28a745;">View All Projects</a>
                </div>
    <%
            } else {
    %>
                <div class="message-container">
                    <div class="error">
                        ✗ Failed to Assign Task
                    </div>
                    <p>Something went wrong. Please try again.</p>
                    <a href="assigntask.jsp?id=<%= projectId %>" class="btn">Go Back</a>
                </div>
    <%
            }
        } catch (Exception e) {
    %>
            <div class="message-container">
                <div class="error">
                    ✗ Error Occurred
                </div>
                <p><strong>Error Message:</strong> <%= e.getMessage() %></p>
                <a href="assigntask.jsp?id=<%= projectId %>" class="btn">Go Back</a>
            </div>
    <%
            e.printStackTrace();
        }
    %>
</body>
</html>