<%@page import="database.dbconfig"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="emphome.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>All Project Progress</title>

    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f5f6fa; margin: 0; padding: 0; }
        .container { width: 95%; max-width: 1400px; margin: 40px auto; background-color: #ffffff;
            border-radius: 10px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); padding: 30px; }
        h1 { color: #151542; text-align: center; margin-bottom: 30px; padding-bottom: 15px;
            border-bottom: 3px solid #151542; }

        .table-container { overflow-x: auto; margin-top: 20px; }
        table { width: 100%; border-collapse: collapse; background-color: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); }
        thead { background: linear-gradient(135deg, #151542 0%, #2d2d6e 100%); color: white; }
        th { padding: 15px 10px; text-align: left; font-weight: 600; font-size: 14px; white-space: nowrap; }
        td { padding: 12px 10px; border-bottom: 1px solid #e9ecef; font-size: 14px; }
        tbody tr:hover { background-color: #f8f9fa; }

        .status-badge { padding: 6px 15px; border-radius: 20px; font-size: 12px; font-weight: 600; display: inline-block; }
        .status-planning { background-color: #ffc107; color: #000; }
        .status-progress { background-color: #17a2b8; color: white; }
        .status-design { background-color: #6f42c1; color: white; }
        .status-development { background-color: #007bff; color: white; }
        .status-testing { background-color: #fd7e14; color: white; }
        .status-review { background-color: #20c997; color: white; }
        .status-deployment { background-color: #e83e8c; color: white; }
        .status-completed { background-color: #28a745; color: white; }
        .status-hold { background-color: #dc3545; color: white; }

        .completion-badge { padding: 5px 12px; border-radius: 15px; font-size: 12px; font-weight: 600;
            display: inline-block; }
        .completion-low { background-color: #f8d7da; color: #721c24; }
        .completion-medium { background-color: #fff3cd; color: #856404; }
        .completion-high { background-color: #d1ecf1; color: #0c5460; }
        .completion-complete { background-color: #d4edda; color: #155724; }

        .description-cell { max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .no-progress { text-align: center; padding: 50px 20px; color: #6c757d; }

        /* Update Button */
        .update-btn {
            background-color: #151542;
            color: white;
            padding: 6px 14px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
        }
        .update-btn:hover {
            background-color: #2d2d6e;
        }

        /* Delete Button */
        .delete-btn {
            background-color: #dc3545;
            color: white;
            padding: 6px 14px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
        }
        .delete-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>

<body>
<div class="container">
    <h1>📊 All Project Progress </h1>

    <%-- Display message on delete --%>
    <%
        String msg = request.getParameter("msg");
        if (msg != null) {
    %>
        <div style="
            background: #d4edda; 
            color: #155724; 
            padding: 12px; 
            border-radius: 6px; 
            margin-bottom: 20px;
            text-align: center;
        ">
            <%= msg %>
        </div>
    <%
        }
    %>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Phone</th>
                    <th>Update Title</th>
                    <th>Status</th>
                    <th>Completion</th>
                    <th>Description</th>
                    <th>Update Date</th>
                    <th>Next Milestone</th>
                    <th>Created At</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
            </thead>

            <tbody>
            <%
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = new dbconfig().getConnection();

                    String sql = "SELECT * FROM projectprogress1 ORDER BY update_date DESC, created_at DESC";
                    PreparedStatement ps = con.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();

                    int rowNum = 0;
                    boolean hasData = false;

                    while (rs.next()) {
                        hasData = true;
                        rowNum++;

                        int id = rs.getInt("id");

                        String phono = rs.getString("phono");
                        String updateTitle = rs.getString("update_title");
                        String progressStatus = rs.getString("progress_status");
                        String completionPercentage = rs.getString("completion_percentage");
                        String description = rs.getString("description");
                        String updateDate = rs.getString("update_date");
                        String nextMilestone = rs.getString("next_milestone");
                        String createdAt = rs.getString("created_at");

                        String statusClass = "status-progress";
                        String st = progressStatus.toLowerCase();
                        if (st.equals("planning")) statusClass = "status-planning";
                        else if (st.equals("in progress")) statusClass = "status-progress";
                        else if (st.equals("design phase")) statusClass = "status-design";
                        else if (st.equals("development phase")) statusClass = "status-development";
                        else if (st.equals("testing phase")) statusClass = "status-testing";
                        else if (st.equals("review")) statusClass = "status-review";
                        else if (st.equals("deployment")) statusClass = "status-deployment";
                        else if (st.equals("completed")) statusClass = "status-completed";
                        else if (st.equals("on hold")) statusClass = "status-hold";

                        // Extract percentage from string like "Planning (10%)"
                        int cp = 0;
                        try {
                            if(completionPercentage != null && completionPercentage.contains("(") && completionPercentage.contains("%")) {
                                String percentStr = completionPercentage.substring(
                                    completionPercentage.indexOf("(") + 1, 
                                    completionPercentage.indexOf("%")
                                ).trim();
                                cp = Integer.parseInt(percentStr);
                            }
                        } catch(Exception e) {
                            cp = 0;
                        }

                        String completionClass = "completion-low";
                        if (cp >= 100) completionClass = "completion-complete";
                        else if (cp >= 70) completionClass = "completion-high";
                        else if (cp >= 40) completionClass = "completion-medium";
            %>

                <tr>
                    <td><%= rowNum %></td>
                    <td><%= phono %></td>
                    <td><%= updateTitle %></td>
                    <td><span class="status-badge <%= statusClass %>"><%= progressStatus %></span></td>
                    <td><span class="completion-badge <%= completionClass %>"><%= completionPercentage %></span></td>
                    <td class="description-cell" title="<%= description %>"><%= description %></td>
                    <td><%= updateDate %></td>
                    <td><%= (nextMilestone != null && !nextMilestone.trim().isEmpty()) ? nextMilestone : "-" %></td>
                    <td><%= createdAt %></td>

                    <td>
                        <a href="update.jsp?id=<%= id %>" class="update-btn">Update</a>
                    </td>

                    <td>
                       <a href="deleteprogressdb1?id=<%= id %>"
                        class="delete-btn"
                        onclick="return confirm('Are you sure you want to delete this record?');">
                        Delete
                     </a>
                    </td>
                </tr>

            <%
                    }

                    if (!hasData) {
            %>
                <tr>
                    <td colspan="11">
                        <div class="no-progress">
                            <h3>No Progress Records Found</h3>
                        </div>
                    </td>
                </tr>
            <%
                    }

                    rs.close();
                    ps.close();
                    con.close();

                } catch (Exception e) {
                    out.println("<tr><td colspan='11'>Error: " + e.getMessage() + "</td></tr>");
                    e.printStackTrace();
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>