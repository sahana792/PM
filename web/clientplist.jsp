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
            width: 98%;
            max-width: 1400px;
            margin: 20px auto;
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

        /* Remove scroll and make table fit */
        .table-wrapper {
            width: 100%;
            overflow: visible;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            table-layout: auto;
            margin: 0 auto;
            text-align: left;
            font-size: 0.9em;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 10px 8px;
            border: 1px solid #dee2e6;
            vertical-align: middle;
            word-wrap: break-word;
        }

        th {
            background-color: #151542;
            color: white;
            text-transform: uppercase;
            font-weight: 600;
            font-size: 0.85em;
        }

        /* Specific column widths to prevent overflow */
        th:nth-child(1), td:nth-child(1) { width: 5%; } /* SL.no */
        th:nth-child(2), td:nth-child(2) { width: 10%; } /* Client Name */
        th:nth-child(3), td:nth-child(3) { width: 12%; } /* Email */
        th:nth-child(4), td:nth-child(4) { width: 9%; } /* Phone */
        th:nth-child(5), td:nth-child(5) { width: 10%; } /* Title */
        th:nth-child(6), td:nth-child(6) { width: 15%; } /* Requirements */
        th:nth-child(7), td:nth-child(7) { width: 15%; } /* Description */
        th:nth-child(8), td:nth-child(8) { width: 9%; } /* Deadline */
        th:nth-child(9), td:nth-child(9) { width: 10%; text-align: center; } /* Status */

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
                font-size: 0.75em;
            }
            th, td {
                padding: 6px 4px;
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
                            <th>Client Name</th>
                            <th>Email</th>
                            <th>Phone No</th>
                            <th>Title</th>
                            <th>Requirements</th>
                            <th>Description</th>
                            <th>Deadline</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                int slno = 0;
                                 Class.forName("com.mysql.jdbc.Driver");
                                Connection con = new dbconfig().getConnection();
                                
                                // Filter by logged-in user's phone number
                                String sql = "SELECT * FROM requirements WHERE phono = ?";
                                PreparedStatement ps = con.prepareStatement(sql);
                                ps.setString(1, loggedInPhono);
                                ResultSet res = ps.executeQuery();
                                
                                boolean hasRecords = false;
                                while (res.next()) {
                                    hasRecords = true;
                                    slno++;
                                    String status = res.getString("status");
                                    if (status == null || status.trim().isEmpty()) {
                                        status = "Pending";
                                    }
                        %>
                        <tr>
                            <td><%= slno %></td>
                            <td><%= res.getString("cname") %></td>
                            <td><%= res.getString("email") %></td>
                            <td><%= res.getString("phono") %></td>
                            <td><%= res.getString("title") %></td>
                            <td><%= res.getString("requirements") %></td>
                            <td><%= res.getString("description") %></td>
                            <td><%= res.getString("deadline") %></td>
                            <td>
                                <% if (status.equalsIgnoreCase("Accepted")) { %>
                                    <span class="status-badge status-accepted">Accepted</span>
                                <% } else if (status.equalsIgnoreCase("Rejected")) { %>
                                    <span class="status-badge status-rejected">Rejected</span>
                                <% } else { %>
                                    <span class="status-badge status-pending">Pending</span>
                                <% } %>
                            </td>
                        </tr>
                        <% 
                                }
                                
                                if (!hasRecords) {
                                    out.println("<tr><td colspan='9' style='text-align:center;color:#666;'>No projects found for your account.</td></tr>");
                                }
                                
                                ps.close();
                                con.close();
                            } catch (Exception e) { 
                                out.println("<tr><td colspan='9' style='color:red;text-align:center;'>Error: " + e + "</td></tr>");
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