<%@page import="database.dbconfig"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Track Your Project</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f7fb;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 50px auto;
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form {
            text-align: center;
            margin-bottom: 30px;
        }
        input[type="text"] {
            padding: 10px 15px;
            border: 1px solid #ccc;
            border-radius: 25px;
            width: 250px;
            outline: none;
        }
        input[type="text"]:focus {
            border-color: #28a745;
            box-shadow: 0 0 5px rgba(40,167,69,0.3);
        }
        button {
            padding: 10px 20px;
            border: none;
            border-radius: 25px;
            background-color: #28a745;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        button:hover {
            background-color: #1e7e34;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #28a745;
            color: white;
        }
        .status-bar {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }
        .step {
            flex: 1;
            text-align: center;
            padding: 8px;
            margin-right: 5px;
            border-radius: 4px;
            background: #e0e0e0;
            color: #666;
            font-weight: bold;
        }
        .step.completed { background: #28a745; color: white; }
        .step:last-child { margin-right: 0; }
        .no-data {
            text-align: center;
            font-size: 16px;
            color: #888;
            margin-top: 30px;
        }
    </style>
</head>

<body>
<div class="container">
    <h2>📦 Track Your Project Status</h2>

    <form method="get">
        <input type="text" name="phono" placeholder="Enter your phone number" required>
        <button type="submit">Track</button>
    </form>

    <%
        String id = request.getParameter("phono");
        if (id != null && !id.trim().isEmpty()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = new dbconfig().getConnection();
                String query = "SELECT * FROM userlogin WHERE phono=?";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, id);
                ResultSet res = ps.executeQuery();

                if (!res.isBeforeFirst()) {
    %>
                    <div class="no-data">❌ No record found for this phone number.</div>
    <%
                } else {
                    while (res.next()) {
    %>
                    <table>
                        <tr><th>Client Name</th><td><%= res.getString("name") %></td></tr>
                        <tr><th>Phone</th><td><%= res.getString("phono") %></td></tr>
                        <tr><th>Email</th><td><%= res.getString("email") %></td></tr>
                        <tr><th>Password</th><td><%= res.getString("pass") %></td></tr>
                    </table>

                    <h3>Progress:</h3>
                    <div class="status-bar">
                        <div class="step <%= res.getString("status").equalsIgnoreCase("Task 1") || res.getString("status").equalsIgnoreCase("Task 2") || res.getString("status").equalsIgnoreCase("Task 3") ? "completed" : "" %>">Task 1</div>
                        <div class="step <%= res.getString("status").equalsIgnoreCase("Task 2") || res.getString("status").equalsIgnoreCase("Task 3") ? "completed" : "" %>">Task 2</div>
                        <div class="step <%= res.getString("status").equalsIgnoreCase("Task 3") ? "completed" : "" %>">Task 3</div>
                    </div>
    <%
                    }
                }

                res.close();
                ps.close();
                con.close();
            } catch (Exception e) {
    %>
                <div class="no-data">⚠️ Error: <%= e.getMessage() %></div>
    <%
            }
        }
    %>
</div>
</body>
</html>
