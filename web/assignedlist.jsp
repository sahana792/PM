<%@page import="database.dbconfig"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="mhome.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Assigned List</title>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f6fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 95%;
            max-width: 100%;
            margin: 80px auto 40px auto;
            margin-left: 8px;
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

        .title-center {
            text-align: center;
            margin-bottom: 20px;
        }

        .table-wrapper {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            margin: 0 -15px;
            padding: 0 15px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            min-width: 900px;
            font-size: 0.9em;
            white-space: nowrap;
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
            position: sticky;
            top: 0;
            z-index: 10;
        }

        tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        tr:hover {
            background-color: #e9ecef;
        }

        /* Action column */
        td:nth-child(9), th:nth-child(9) {
            min-width: 100px;
            text-align: center;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 5px;
            font-size: 0.9em;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background-color: #dc3545;
            color: white;
        }

        .btn-primary:hover {
            background-color: #c82333;
            transform: translateY(-2px);
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: #6c757d;
            font-size: 1.1em;
        }

        .status-badge {
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 0.85em;
            font-weight: 600;
            display: inline-block;
        }

        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }

        .status-ongoing {
            background-color: #fff3cd;
            color: #856404;
        }
    </style>
</head>

<body>
<div class="container">
    <div class="title-center">
        <h4 class="card-title">Assigned List</h4>
    </div>

    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>SL.NO</th>
                    <th>PROJECT ID</th>
                    <th>START DATE</th>
                    <th>END DATE</th>
                    <th>TECHNOLOGY</th>
                    <th>MID</th>
                    <th>STATUS</th>
                    <th>ACTION</th>
                </tr>
            </thead>

            <tbody>
            <%
                try {
                    int slno = 0;
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = new dbconfig().getConnection();
                    Statement stat = con.createStatement();
                    ResultSet res = stat.executeQuery("SELECT * FROM mpadd1 ORDER BY id DESC");

                    boolean hasData = false;

                    while (res.next()) {
                        hasData = true;
                        slno++;

                        String status = res.getString("status");
                        if (status == null || status.trim().isEmpty()) {
                            status = "Ongoing";
                        }

                        String statusClass = status.equalsIgnoreCase("Completed")
                                ? "status-completed"
                                : "status-ongoing";
            %>
                <tr>
                    <td><%= slno %></td>
                    <td><strong>#<%= res.getInt("project_id") %></strong></td>
                    <td><%= res.getString("startdate") %></td>
                    <td><%= res.getString("enddate") %></td>
                    <td><%= res.getString("technology") %></td>
                    <td><%= res.getString("mid") %></td>
                    <td>
                        <span class="status-badge <%= statusClass %>"><%= status %></span>
                    </td>
                    <td>
                        <a href="clientdel?id=<%= res.getString("id") %>">
                            <button class="btn btn-primary">Delete</button>
                        </a>
                    </td>
                </tr>
            <%
                    }

                    if (!hasData) {
            %>
                <tr>
                    <td colspan="9" class="no-data">
                        No assigned tasks found. Start by assigning tasks to employees.
                    </td>
                </tr>
            <%
                    }

                    res.close();
                    stat.close();
                    con.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='9' style='color:red;text-align:center;'>Error: " + e.getMessage() + "</td></tr>");
                    e.printStackTrace();
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
