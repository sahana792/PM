<%@page import="database.dbconfig"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="clientheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>My Projects</title>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f6fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 95%;
            max-width: 1200px;
            margin: 60px auto;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            padding: 30px;
        }

        h1 {
            text-align: center;
            color: #151542;
            margin-bottom: 30px;
            font-size: 1.8em;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            text-align: center;
        }

        .alert-warning {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }

        .alert-info {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        /* Center the table properly */
        .table-wrapper {
            display: flex;
            justify-content: center;
            overflow-x: auto;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            max-width: 1100px;
            margin: 0 auto;
            text-align: left;
            font-size: 0.95em;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #dee2e6;
            vertical-align: middle;
        }

        th {
            background-color: #151542;
            color: white;
            text-transform: uppercase;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        tr:hover {
            background-color: #e9ecef;
        }

        .status-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.85em;
            font-weight: 600;
            display: inline-block;
        }

        .status-pending {
            background-color: #ffc107;
            color: #000;
        }

        .status-accepted {
            background-color: #28a745;
            color: white;
        }

        .status-rejected {
            background-color: #dc3545;
            color: white;
        }

        /* Make table responsive */
        @media (max-width: 768px) {
            table {
                font-size: 0.85em;
            }
            th, td {
                padding: 8px;
            }
        }
    </style>
</head>

<body>
    <div class="container">
        <center>
            <h1>My Project List</h1>
            
            <%
                // Get logged-in user's phone number from session
                String loggedInPhono = (String) session.getAttribute("phono");
                
                // Check if user is logged in
                if (loggedInPhono == null || loggedInPhono.trim().isEmpty()) {
            %>
                    <div class="alert alert-warning">
                        <strong>Please login first to view your projects!</strong>
                    </div>
            <%
                } else {
            %>
            
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>SL.no</th>
                            <th>Project Name</th>
                            <th>Client Name</th>
                            <th>Phone No</th>
                            <th>Description</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Budget</th>
                            <th>Technology</th>
                            <th>Progress</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                int slno = 0;
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection con = new dbconfig().getConnection();
                                
                                // Filter by logged-in user's phone number
                                String sql = "SELECT * FROM projectadd1 WHERE phono = ?";
                                PreparedStatement ps = con.prepareStatement(sql);
                                ps.setString(1, loggedInPhono);
                                ResultSet res = ps.executeQuery();
                                
                                boolean hasRecords = false;
                                while (res.next()) {
                                    hasRecords = true;
                                    slno++;
                                    String progress = res.getString("progress");
                                    if (progress == null || progress.trim().isEmpty()) {
                                        progress = "Pending";
                                    }
                        %>
                        <tr>
                            <td><%= slno %></td>
                            <td><%= res.getString("pname") %></td>
                            <td><%= res.getString("cname") %></td>
                            <td><%= res.getString("phono") %></td>
                            <td><%= res.getString("description") %></td>
                            <td><%= res.getString("startdate") %></td>
                            <td><%= res.getString("enddate") %></td>
                            <td><%= res.getString("budget") %></td>
                            <td><%= res.getString("technology") %></td>
                            <td>
                                <% if (progress.equalsIgnoreCase("Accepted")) { %>
                                    <span class="status-badge status-accepted">Accepted</span>
                                <% } else if (progress.equalsIgnoreCase("Rejected")) { %>
                                    <span class="status-badge status-rejected">Rejected</span>
                                <% } else { %>
                                    <span class="status-badge status-pending">Pending</span>
                                <% } %>
                            </td>
                        </tr>
                        <% 
                                }
                                
                                if (!hasRecords) {
                                    out.println("<tr><td colspan='10' style='text-align:center;color:#666;'>No projects found for your account.</td></tr>");
                                }
                                
                                ps.close();
                                con.close();
                            } catch (Exception e) { 
                                out.println("<tr><td colspan='10' style='color:red;text-align:center;'>Error: " + e + "</td></tr>");
                            } 
                        %>
                    </tbody>
                </table>
            </div>
            <% } %>
        </center>
    </div>
</body>
</html>