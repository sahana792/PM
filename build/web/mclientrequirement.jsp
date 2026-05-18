<%@page import="java.sql.*"%>
<%@page import="database.dbconfig"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="mhome.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Accepted Client Projects</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1400px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        h4 {
            color: #343a40;
            margin-bottom: 20px;
            border-bottom: 2px solid #28a745;
            padding-bottom: 10px;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }
        th, td {
            padding: 10px;
            border: 1px solid #dee2e6;
            word-wrap: break-word;
            overflow-wrap: break-word;
        }
        th {
            background-color: #151542;
            color: white;
            text-transform: uppercase;
        }
        tr:nth-child(even) { background-color: #f8f9fa; }
        tr:hover { background-color: #e9ecef; }

        .btn-delete, .btn-progress, .btn-assign-task {
            padding: 6px 10px;
            border-radius: 4px;
            color: white;
            font-size: 0.85em;
            text-decoration: none;
            font-weight: 600;
        }
        .btn-delete { background-color: #dc3545; }
        .btn-delete:hover { background-color: #c82333; }

        .btn-progress.add { background-color: #007bff; }
        .btn-progress.add:hover { background-color: #0056b3; }
        .btn-progress.added { background-color: #43C44E; }
        .btn-progress.added:hover { background-color: #369c3f; }

        .btn-assign-task { background-color: #28a745; }
        .btn-assign-task:hover { background-color: #218838; }

        .no-data {
            padding: 30px;
            font-style: italic;
            color: #666;
            text-align: center;
        }
        .stat-box {
            background: linear-gradient(135deg, #151542, #2d2d6e);
            color: white;
            padding: 20px;
            border-radius: 10px;
            width: 250px;
            margin: 20px auto;
            text-align: center;
        }
        .stat-number {
            font-size: 2.5em;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <h4>Accepted Client Projects</h4>

    <%
        // Total accepted projects
        int totalAccepted = 0;
        try {
            Connection con = new dbconfig().getConnection();
            Statement st = con.createStatement();
            ResultSet rsCount = st.executeQuery(
                "SELECT COUNT(*) FROM requirements WHERE LOWER(status)='accepted'"
            );
            if(rsCount.next()) {
                totalAccepted = rsCount.getInt(1);
            }
            rsCount.close();
            st.close();
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    %>

    <div class="stat-box">
        <div class="stat-number"><%= totalAccepted %></div>
        <div>Total Accepted Projects</div>
    </div>

    <table>
        <thead>
            <tr>
                <th>SL.No</th>
                <th>Client Name</th>
                <th>Email</th>
                <th>Phone No</th>
                <th>Title</th>
                <th>Requirements</th>
                <th>Description</th>
                <th>Deadline</th>
                <th>Delete</th>
                <th>Progress</th>
                <th>Task</th>
            </tr>
        </thead>
        <tbody>
        <%
            int slno = 0;
            boolean found = false;

            try {
                Connection con = new dbconfig().getConnection();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(
                    "SELECT * FROM requirements WHERE LOWER(status)='accepted' ORDER BY id DESC"
                );

                while(rs.next()) {
                    found = true;
                    slno++;

                    String id = rs.getString("id");
                    String cname = rs.getString("cname");
                    String email = rs.getString("email");
                    String phono = rs.getString("phono");
                    String title = rs.getString("title");
                    String req = rs.getString("requirements");
                    String desc = rs.getString("description");
                    String deadline = rs.getString("deadline");

                    String reqShort = req.length() > 50 ? req.substring(0,50) + "..." : req;
                    String descShort = desc.length() > 50 ? desc.substring(0,50) + "..." : desc;

                    // Check if progress already added in mpadd1 table
                    String progressClass = "add"; // default blue
                    try {
                        Connection con2 = new dbconfig().getConnection();
                        PreparedStatement pst = con2.prepareStatement(
                            "SELECT COUNT(*) FROM mpadd1 WHERE project_id=?" // Make sure 'project_id' exists in mpadd1
                        );
                        pst.setString(1, id);
                        ResultSet rsProg = pst.executeQuery();
                        if(rsProg.next() && rsProg.getInt(1) > 0) {
                            progressClass = "added"; // green
                        }
                        rsProg.close();
                        pst.close();
                        con2.close();
                    } catch(Exception e2) {
                        e2.printStackTrace();
                    }
        %>
            <tr>
                <td><%= slno %></td>
                <td><%= cname %></td>
                <td><%= email %></td>
                <td><%= phono %></td>
                <td><%= title %></td>
                <td title="<%= req %>"><%= reqShort %></td>
                <td title="<%= desc %>"><%= descShort %></td>
                <td><%= deadline %></td>

                <td>
                    <a href="deleteproject?id=<%= id %>" 
                       class="btn-delete" 
                       onclick="return confirm('Are you sure you want to delete this project?');">
                       Delete
                    </a>
                </td>

                <td>
                    <a href="addprogress.jsp?id=<%= id %>&phono=<%= phono %>" 
                       class="btn-progress <%= progressClass %>">
                       Add Progress
                    </a>
                </td>

                <td>
                    <a href="assigntask.jsp?id=<%= id %>&phono=<%= phono %>" 
                       class="btn-assign-task">
                       Assign Task
                    </a>
                </td>
            </tr>
        <%
                }
                rs.close();
                st.close();
                con.close();
            } catch(Exception e) {
        %>
            <tr>
                <td colspan="11" style="color:red; text-align:center;">
                    Error: <%= e.getMessage() %>
                </td>
            </tr>
        <%
            }

            if(!found) {
        %>
            <tr>
                <td colspan="11" class="no-data">
                    No Accepted Projects Found
                </td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
