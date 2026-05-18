<%@page import="database.dbconfig"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="adminheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Client Requirements</title>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f6fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 95%;
            max-width: 1500px;
            margin: 60px auto;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            padding: 30px;
        }

        h4.card-title {
            text-align: center;
            color: #151542;
            margin-bottom: 30px;
            font-size: 1.8em;
            border-bottom: 3px solid #151542;
            display: inline-block;
            padding-bottom: 8px;
        }

        /* Table Styles */
        .table-wrapper {
            width: 100%;
            overflow-x: hidden !important; /* Prevent horizontal scroll */
        }

        table {
            border-collapse: collapse;
            width: 100%;
            text-align: left;
            font-size: 0.95em;
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

        /* Buttons */
        .btn {
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 0.9em;
            transition: 0.3s;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        /* Responsive Table - No Scroll */
        @media (max-width: 900px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }

            thead {
                display: none;
            }

            tr {
                margin-bottom: 15px;
                background: #fff;
                border-radius: 8px;
                padding: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            }

            td {
                text-align: left;
                position: relative;
                padding-left: 120px;
                border: none;
                border-bottom: 1px solid #eee;
            }

            td:last-child {
                border-bottom: none;
            }

            td:before {
                content: attr(data-label);
                position: absolute;
                left: 15px;
                font-weight: bold;
                color: #151542;
                width: 100px;
            }
        }
    </style>
</head>

<body>
    <div class="container" style=" margin-top:30px;">
        <center><h4 class="card-title">Assigned List</h4></center>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>SL.no</th>
                        <th>Project ID</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Technology</th>
                        <th>MID</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            int slno = 0;
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = new dbconfig().getConnection();
                            Statement stat = con.createStatement();
                            ResultSet res = stat.executeQuery("SELECT * FROM mpadd1");
                            while (res.next()) {
                                slno++;
                    %>
                    <tr>
                        <td data-label="SL.no"><%= slno %></td>
                        <td data-label="Project ID"><%= res.getString("project_id") %></td>
                        <td data-label="Start Date"><%= res.getString("startdate") %></td>
                        <td data-label="End Date"><%= res.getString("enddate") %></td>
                        <td data-label="Technology"><%= res.getString("technology") %></td>
                        <td data-label="MID"><%= res.getString("mid") %></td>
                        <td data-label="Status"><%= res.getString("status") != null ? res.getString("status") : "N/A" %></td>
                        <td data-label="Action">
                            <a href="clientdel?id=<%= res.getString("id") %>">
                                <button class="btn btn-primary">Delete</button>
                            </a>
                        </td>
                    </tr>
                    <% 
                            }
                        } catch (Exception e) { 
                            out.println("<tr><td colspan='10' style='color:red;text-align:center;'>Error: " + e + "</td></tr>");
                        } 
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
