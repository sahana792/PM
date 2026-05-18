<%@page import="database.dbconfig"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="mhome.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Progress Update</title>
    
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f6fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 90%;
            max-width: 1400px;
            margin: 5px auto;
            background-color: #ffffff;
            border-radius: 1px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        h1 {
            color: #151542;
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 3px solid #151542;
        }

        .top-buttons {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            justify-content: center;
        }

        .btn-back, .btn-assign {
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            color: white;
            font-weight: bold;
            transition: all 0.3s;
        }

        .btn-back { background-color: #17a2b8; }
        .btn-back:hover { background-color: #138496; transform: translateY(-2px); }

        .btn-assign { background-color: #28a745; }
        .btn-assign:hover { background-color: #218838; transform: translateY(-2px); }

        .info-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        .info-table th, .info-table td {
            padding: 10px;
            border: 1px solid #dee2e6;
        }

        .info-table th {
            background-color: #151542;
            color: white;
            text-align: left;
        }

        .info-table tr:nth-child(even) { background-color: #f1f1f1; }

        /* Form Row Layout */
        form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: 700;
            margin-bottom: 5px;
        }

        input[type="text"], input[type="date"], select {
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            box-sizing: border-box;
        }

        input[readonly], select[readonly] {
            background-color: #e9ecef;
            cursor: not-allowed;
        }

        .btn-container {
            grid-column: 1 / -1;
            display: flex;
            gap: 5px;
            justify-content: center;
            margin-top: 5px;
        }

        .btn-primary {
            flex: 1;
            background-color: #151542;
            color: white;
            border: none;
            padding: 12px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .btn-primary:hover { background-color: #0d0d2b; }

        .btn-secondary {
            flex: 1;
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 12px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .btn-secondary:hover { background-color: #5a6268; }

        .alert {
            padding: 15px;
            border-radius: 5px;
            text-align: center;
            margin-bottom: 20px;
        }

        .alert-warning { background-color: #fff3cd; color: #856404; border: 1px solid #ffeaa7; }
        .alert-danger { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>
    <div class="container">
        <%
            String id = request.getParameter("id");
            String cname = "", email = "", phono = "", title = "", requirements = "", description = "", deadline = "", status = "";

            if(id == null || id.trim().isEmpty()) {
        %>
                <div class="alert alert-warning">
                    <strong>Error!</strong> No project selected. Please go back and select a project.
                </div>
                <a href="clientrequirements.jsp" class="btn btn-primary" style="display:block; text-align:center; text-decoration:none;">Go Back to Projects</a>
        <%
            } else {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = new dbconfig().getConnection();
                    String sql = "SELECT * FROM requirements WHERE id=?";
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setInt(1, Integer.parseInt(id));
                    ResultSet res = ps.executeQuery();

                    if(res.next()) {
                        cname = res.getString("cname");
                        email = res.getString("email");
                        phono = res.getString("phono");
                        title = res.getString("title");
                        requirements = res.getString("requirements");
                        description = res.getString("description");
                        deadline = res.getString("deadline");
                        status = res.getString("status");
        %>

        <!-- Top Buttons -->
        <div class="top-buttons">
            <a href="mclientrequirement.jsp" class="btn-back">← Back to Projects</a>
            <!---<a href="assigntask.jsp?id=<%= id %>" class="btn-assign">→ Assign Task to Employee</a>---->
        </div>

        <!-- Page Title -->
        <h1>Add Progress Update</h1>

        <!-- Project Info Table -->
        <table class="info-table">
            <tr>
                <th>Field</th>
                <th>Value</th>
            </tr>
            <tr><td>Project ID</td><td><%= id %></td></tr>
            <tr><td>Project Title</td><td><%= title %></td></tr>
            <tr><td>Client Name</td><td><%= cname %></td></tr>
            <tr><td>Email</td><td><%= email %></td></tr>
            <tr><td>Phone</td><td><%= phono %></td></tr>
            <tr><td>Deadline</td><td><%= deadline %></td></tr>
            <tr><td>Status</td><td style="color:#28a745; font-weight:bold;"><%= status %></td></tr>
        </table>

        <!-- Progress Form in Rows -->
        <form action="addprogressdb" method="POST">
            <input type="hidden" name="project_id" value="<%= id %>">
            <input type="hidden" name="phono" value="<%= phono %>">

            <div class="form-group">
                <label>Update Title <span style="color:red;">*</span></label>
                <input type="text" name="update_title" placeholder="e.g., Design Phase Completed" required>
            </div>

            <div class="form-group">
                <label>Progress Status <span style="color:red;">*</span></label>
                <select id="progress_status" name="progress_status" required>
                    <option value="">-- Select Status --</option>
                    <option value="On Hold">On Hold</option>
                    <option value="Planning">Planning</option>
                    <option value="In Progress">In Progress</option>
                    <option value="Design Phase">Design Phase</option>
                    <option value="Development Phase">Development Phase</option>
                    <option value="Testing Phase">Testing Phase</option>
                    <option value="Review">Review</option>
                    <option value="Deployment">Deployment</option>
                    <option value="Completed">Completed</option>
                </select>
            </div>

            <div class="form-group">
                <label>Progress Completed <span style="color:red;">*</span></label>
                <select id="completion_percentage" name="completion_percentage" required readonly>
                    <option value="">-- Select Percentage --</option>
                    <option value="On Hold (0%)">On Hold (0%)</option>
                    <option value="Planning (10%)">Planning (10%)</option>
                    <option value="In Progress (20%)">In Progress (20%)</option>
                    <option value="Design Phase (30%)">Design Phase (30%)</option>
                    <option value="Development Phase (40%)">Development Phase (40%)</option>
                    <option value="Testing Phase (70%)">Testing Phase (70%)</option>
                    <option value="Review (85%)">Review (85%)</option>
                    <option value="Deployment (95%)">Deployment (95%)</option>
                    <option value="Completed (100%)">Completed (100%)</option>
                </select>
            </div>

            <div class="form-group">
                <label>Progress Description <span style="color:red;">*</span></label>
                <select id="description" name="description" required readonly>
                    <option value="">-- Select Description --</option>
                    <option value="On Hold - Do not yet started">On Hold - Do not yet started</option>
                    <option value="Planning - Gathering requirements, defining scope, and assigning resources">Planning - Gathering requirements, defining scope, and assigning resources</option>
                    <option value="In Progress - Team is executing initial development and implementation tasks">In Progress - Team is executing initial development and implementation tasks</option>
                    <option value="Design Phase - Creating UI/UX, architecture, and technical specifications">Design Phase - Creating UI/UX, architecture, and technical specifications</option>
                    <option value="Development Phase - Core modules are being coded and integrated">Development Phase - Core modules are being coded and integrated</option>
                    <option value="Testing Phase - Bugs are being identified, fixed, and re-tested">Testing Phase - Bugs are being identified, fixed, and re-tested</option>
                    <option value="Review - Code, performance, and functionality are being evaluated">Review - Code, performance, and functionality are being evaluated</option>
                    <option value="Deployment - System is almost ready for production">Deployment - System is almost ready for production</option>
                    <option value="Completed - All tasks, testing, and deployment successfully done">Completed - All tasks, testing, and deployment successfully done</option>
                </select>
            </div>

            <div class="form-group">
                <label>Update Date <span style="color:red;">*</span></label>
                <input type="date" name="update_date" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
            </div>

            <div class="form-group">
                <label>Next Milestone <span style="color:red;">*</span></label>
                <select name="next_milestone" required>
                    <option value="">-- Select Next Milestone --</option>
                    <option value="On Hold (0%)">On Hold (0%)</option>
                    <option value="Planning (10%)">Planning (10%)</option>
                    <option value="In Progress (20%)">In Progress (20%)</option>
                    <option value="Design Phase (30%)">Design Phase (30%)</option>
                    <option value="Development Phase (40%)">Development Phase (40%)</option>
                    <option value="Testing Phase (70%)">Testing Phase (70%)</option>
                    <option value="Review (85%)">Review (85%)</option>
                    <option value="Deployment (95%)">Deployment (95%)</option>
                    <option value="Completed (100%)">Completed (100%)</option>
                </select>
            </div>

            <div class="btn-container">
                <button type="submit" class="btn-primary">Add Progress Update</button>
                <button type="reset" class="btn-secondary">Reset</button>
            </div>
        </form>

        <%
                    } else {
        %>
                    <div class="alert alert-danger">
                        <strong>Error!</strong> Project not found with ID: <%= id %>
                    </div>
                    <a href="clientrequirements.jsp" class="btn btn-primary" style="display:block; text-align:center; text-decoration:none;">Go Back to Projects</a>
        <%
                    }
                    ps.close();
                    con.close();
                } catch(Exception e) {
        %>
                    <div class="alert alert-danger">
                        <strong>Error!</strong> <%= e.getMessage() %>
                    </div>
        <%
                    e.printStackTrace();
                }
            }
        %>
    </div>

    <script>
        // Map progress status to completion & description
        var progressMap = {
            "On Hold": {completion: "On Hold (0%)", description: "On Hold - Do not yet started"},
            "Planning": {completion: "Planning (10%)", description: "Planning - Gathering requirements, defining scope, and assigning resources"},
            "In Progress": {completion: "In Progress (20%)", description: "In Progress - Team is executing initial development and implementation tasks"},
            "Design Phase": {completion: "Design Phase (30%)", description: "Design Phase - Creating UI/UX, architecture, and technical specifications"},
            "Development Phase": {completion: "Development Phase (40%)", description: "Development Phase - Core modules are being coded and integrated"},
            "Testing Phase": {completion: "Testing Phase (70%)", description: "Testing Phase - Bugs are being identified, fixed, and re-tested"},
            "Review": {completion: "Review (85%)", description: "Review - Code, performance, and functionality are being evaluated"},
            "Deployment": {completion: "Deployment (95%)", description: "Deployment - System is almost ready for production"},
            "Completed": {completion: "Completed (100%)", description: "Completed - All tasks, testing, and deployment successfully done"}
        };

        var statusSelect = document.getElementById("progress_status");
        var completionSelect = document.getElementById("completion_percentage");
        var descriptionSelect = document.getElementById("description");

        statusSelect.addEventListener("change", function(){
            var selected = this.value;
            if(progressMap[selected]){
                completionSelect.value = progressMap[selected].completion;
                descriptionSelect.value = progressMap[selected].description;
            } else {
                completionSelect.value = "";
                descriptionSelect.value = "";
            }
        });
    </script>
</body>
</html>
