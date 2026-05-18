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
    <title>Update Progress</title>
    
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 95%;
            max-width: 1400px;
            margin: 40px auto;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            padding: 0;
            overflow: hidden;
        }

        .header {
            background-color: #ffffff;
            padding: 25px 40px;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-buttons {
            display: flex;
            gap: 15px;
        }

        .btn-back-header {
            background-color: #17a2b8;
            color: white;
            text-decoration: none;
            padding: 10px 25px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 500;
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-back-header:hover {
            background-color: #138496;
        }

        .btn-assign {
            background-color: #28a745;
            color: white;
            text-decoration: none;
            padding: 10px 25px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 500;
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-assign:hover {
            background-color: #218838;
        }

        h1 {
            color: #2c3e50;
            text-align: center;
            margin: 0;
            font-size: 28px;
            font-weight: 600;
        }

        .content-wrapper {
            padding: 40px;
        }

        .info-table {
            width: 100%;
            margin-bottom: 30px;
            border-collapse: collapse;
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
        }

        .info-table thead {
            background-color: #1a1a3e;
        }

        .info-table thead th {
            color: #ffffff;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-table tbody tr {
            border-bottom: 1px solid #e0e0e0;
        }

        .info-table tbody tr:last-child {
            border-bottom: none;
        }

        .info-table tbody td {
            padding: 15px;
            font-size: 14px;
            color: #495057;
        }

        .info-table tbody td:first-child {
            font-weight: 500;
            color: #6c757d;
            background-color: #f8f9fa;
            width: 200px;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 600;
        }

        .status-accepted {
            background-color: #d4edda;
            color: #155724;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 25px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        label span {
            color: #dc3545;
            margin-left: 3px;
        }

        input[type="text"],
        input[type="date"],
        select,
        textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            box-sizing: border-box;
            transition: all 0.3s;
            font-size: 14px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #ffffff;
        }

        input:focus,
        select:focus,
        textarea:focus {
            border-color: #1a1a3e;
            box-shadow: 0 0 0 0.2rem rgba(26, 26, 62, 0.15);
            outline: none;
        }

        select {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23333' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            padding-right: 35px;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        input[readonly] {
            background-color: #e9ecef;
            cursor: not-allowed;
        }

        .btn-container {
            display: flex;
            gap: 15px;
            margin-top: 35px;
            justify-content: center;
        }

        .btn {
            padding: 14px 40px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s;
            min-width: 200px;
        }

        .btn-primary {
            background-color: #1a1a3e;
            color: white;
        }

        .btn-primary:hover {
            background-color: #0d0d2b;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(26, 26, 62, 0.3);
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
        }

        .alert {
            padding: 15px 20px;
            margin-bottom: 25px;
            border-radius: 5px;
            text-align: center;
            font-size: 14px;
        }

        .alert-warning {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .sync-indicator {
            background-color: #d4edda;
            color: #155724;
            padding: 8px 12px;
            border-radius: 5px;
            font-size: 12px;
            margin-top: 8px;
            display: none;
            border-left: 3px solid #28a745;
        }

        .sync-indicator.show {
            display: block;
            animation: fadeIn 0.3s;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-5px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 20px;
            }

            .header-buttons {
                width: 100%;
                flex-direction: column;
            }

            .btn-back-header,
            .btn-assign {
                width: 100%;
                justify-content: center;
            }

            .content-wrapper {
                padding: 20px;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .btn-container {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="header">
            <h1>Update Progress</h1>
            <div class="header-buttons">
                <a href="mviewprogress.jsp" class="btn-back-header">← Back to Projects</a>
                <a href="#" class="btn-assign">→ Assign Task to Employee</a>
            </div>
        </div>
        
        <div class="content-wrapper">
        <%
            String id = request.getParameter("id");
            
            if (id == null || id.trim().isEmpty()) {
        %>
                <div class="alert alert-warning">
                    <strong>Error!</strong> No progress record selected. Please go back and select a record.
                </div>
                <a href="mviewprogress.jsp" class="btn btn-primary" style="display: block; text-align: center; text-decoration: none;">Go Back to Progress List</a>
        <%
            } else {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = new dbconfig().getConnection();
                    
                    String sql = "SELECT * FROM projectprogress1 WHERE id = ?";
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setInt(1, Integer.parseInt(id));
                    ResultSet res = ps.executeQuery();
                    
                    if (res.next()) {
                        String phono = res.getString("phono");
                        String updateTitle = res.getString("update_title");
                        String progressStatus = res.getString("progress_status");
                        String completionPercentage = res.getString("completion_percentage");
                        String description = res.getString("description");
                        String updateDate = res.getString("update_date");
                        String nextMilestone = res.getString("next_milestone");
        %>
        
        <table class="info-table">
            <thead>
                <tr>
                    <th>Field</th>
                    <th>Value</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Progress ID</td>
                    <td><%= id %></td>
                </tr>
                <tr>
                    <td>Phone Number</td>
                    <td><%= phono %></td>
                </tr>
                <tr>
                    <td>Last Updated</td>
                    <td><%= updateDate %></td>
                </tr>
            </tbody>
        </table>
        
        <form action="updateprogressdb1" method="POST">
            <input type="hidden" name="id" value="<%= id %>">
            <input type="hidden" name="phono" value="<%= phono %>">
            
            <div class="form-row">
                <div class="form-group">
                    <label>Update Title <span>*</span></label>
                    <input type="text" name="update_title" value="<%= updateTitle %>" placeholder="e.g., Design Phase Completed" required>
                </div>
                
                <div class="form-group">
                    <label>Progress Status <span>*</span></label>
                    <select name="progress_status" id="progressStatus" required onchange="syncStatusFields()">
                        <option value="">-- Select Status --</option>
                        <option value="On Hold" <%= progressStatus.equals("On Hold") ? "selected" : "" %>>On Hold</option>
                        <option value="Planning" <%= progressStatus.equals("Planning") ? "selected" : "" %>>Planning</option>
                        <option value="In Progress" <%= progressStatus.equals("In Progress") ? "selected" : "" %>>In Progress</option>
                        <option value="Design Phase" <%= progressStatus.equals("Design Phase") ? "selected" : "" %>>Design Phase</option>
                        <option value="Development Phase" <%= progressStatus.equals("Development Phase") ? "selected" : "" %>>Development Phase</option>
                        <option value="Testing Phase" <%= progressStatus.equals("Testing Phase") ? "selected" : "" %>>Testing Phase</option>
                        <option value="Review" <%= progressStatus.equals("Review") ? "selected" : "" %>>Review</option>
                        <option value="Deployment" <%= progressStatus.equals("Deployment") ? "selected" : "" %>>Deployment</option>
                        <option value="Completed" <%= progressStatus.equals("Completed") ? "selected" : "" %>>Completed</option>
                    </select>
                    <div id="syncIndicator" class="sync-indicator">
                        ✓ Progress Completed and Description auto-updated!
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Progress Completed <span>*</span></label>
                    <select name="completion_percentage" id="completionPercentage" required>
                        <option value="">-- Select Percentage --</option>
                        <option value="On Hold (0%)" <%= completionPercentage.equals("On Hold (0%)") ? "selected" : "" %>>On Hold (0%)</option>
                        <option value="Planning (10%)" <%= completionPercentage.equals("Planning (10%)") ? "selected" : "" %>>Planning (10%)</option>
                        <option value="In Progress (20%)" <%= completionPercentage.equals("In Progress (20%)") ? "selected" : "" %>>In Progress (20%)</option>
                        <option value="Design Phase (30%)" <%= completionPercentage.equals("Design Phase (30%)") ? "selected" : "" %>>Design Phase (30%)</option>
                        <option value="Development Phase (40%)" <%= completionPercentage.equals("Development Phase (40%)") ? "selected" : "" %>>Development Phase (40%)</option>
                        <option value="Testing Phase (70%)" <%= completionPercentage.equals("Testing Phase (70%)") ? "selected" : "" %>>Testing Phase (70%)</option>
                        <option value="Review (85%)" <%= completionPercentage.equals("Review (85%)") ? "selected" : "" %>>Review (85%)</option>
                        <option value="Deployment (95%)" <%= completionPercentage.equals("Deployment (95%)") ? "selected" : "" %>>Deployment (95%)</option>
                        <option value="Completed (100%)" <%= completionPercentage.equals("Completed (100%)") ? "selected" : "" %>>Completed (100%)</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Update Date <span>*</span></label>
                    <input type="date" name="update_date" value="<%= updateDate %>" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label>Progress Description <span>*</span></label>
                    <select name="description" id="descriptionField" required>
                        <option value="">-- Select Description --</option>
                        <option value="On Hold - Do not yet started" <%= description.contains("On Hold") ? "selected" : "" %>>On Hold - Do not yet started</option>
                        <option value="Planning - Project is in planning stage. Gathering requirements, defining scope, and assigning resources." <%= description.contains("Planning") ? "selected" : "" %>>Planning - Gathering requirements, defining scope, and assigning resources</option>
                        <option value="In Progress - Core work has started. Team is executing initial development and implementation tasks." <%= description.contains("In Progress") ? "selected" : "" %>>In Progress - Team is executing initial development and implementation tasks</option>
                        <option value="Design Phase - System design is under progress. Creating UI/UX, architecture, and technical specifications." <%= description.contains("Design Phase") ? "selected" : "" %>>Design Phase - Creating UI/UX, architecture, and technical specifications</option>
                        <option value="Development Phase - Major development is ongoing. Core modules are being coded and integrated." <%= description.contains("Development Phase") ? "selected" : "" %>>Development Phase - Core modules are being coded and integrated</option>
                        <option value="Testing Phase - System testing is in progress. Bugs are being identified, fixed, and re-tested." <%= description.contains("Testing") ? "selected" : "" %>>Testing Phase - Bugs are being identified, fixed, and re-tested</option>
                        <option value="Review - Final review underway. Code, performance, and functionality are being evaluated." <%= description.contains("Review") ? "selected" : "" %>>Review - Code, performance, and functionality are being evaluated</option>
                        <option value="Deployment - Deployment is being prepared or executed. System is almost ready for production." <%= description.contains("Deployment") ? "selected" : "" %>>Deployment - System is almost ready for production</option>
                        <option value="Completed - Project fully completed. All tasks, testing, and deployment successfully done." <%= description.contains("Completed") ? "selected" : "" %>>Completed - All tasks, testing, and deployment successfully done</option>
                    </select>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label>Next Milestone <span>*</span></label>
                    <select name="next_milestone" required>
                        <option value="">-- Select Next Milestone --</option>
                        <option value="On Hold (0%)" <%= nextMilestone.equals("On Hold (0%)") ? "selected" : "" %>>On Hold (0%)</option>
                        <option value="Planning (10%)" <%= nextMilestone.equals("Planning (10%)") ? "selected" : "" %>>Planning (10%)</option>
                        <option value="In Progress (20%)" <%= nextMilestone.equals("In Progress (20%)") ? "selected" : "" %>>In Progress (20%)</option>
                        <option value="Design Phase (30%)" <%= nextMilestone.equals("Design Phase (30%)") ? "selected" : "" %>>Design Phase (30%)</option>
                        <option value="Development Phase (40%)" <%= nextMilestone.equals("Development Phase (40%)") ? "selected" : "" %>>Development Phase (40%)</option>
                        <option value="Testing Phase (70%)" <%= nextMilestone.equals("Testing Phase (70%)") ? "selected" : "" %>>Testing Phase (70%)</option>
                        <option value="Review (85%)" <%= nextMilestone.equals("Review (85%)") ? "selected" : "" %>>Review (85%)</option>
                        <option value="Deployment (95%)" <%= nextMilestone.equals("Deployment (95%)") ? "selected" : "" %>>Deployment (95%)</option>
                        <option value="Completed (100%)" <%= nextMilestone.equals("Completed (100%)") ? "selected" : "" %>>Completed (100%)</option>
                    </select>
                </div>
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn btn-primary">Add Progress Update</button>
                <button type="reset" class="btn btn-secondary">Reset</button>
            </div>
        </form>
        
        <script>
            // Mapping between status and completion percentage
            const statusMapping = {
                "On Hold": "On Hold (0%)",
                "Planning": "Planning (10%)",
                "In Progress": "In Progress (20%)",
                "Design Phase": "Design Phase (30%)",
                "Development Phase": "Development Phase (40%)",
                "Testing Phase": "Testing Phase (70%)",
                "Review": "Review (85%)",
                "Deployment": "Deployment (95%)",
                "Completed": "Completed (100%)"
            };

            // Mapping between status and description
            const descriptionMapping = {
                "On Hold": "On Hold - Do not yet started",
                "Planning": "Planning - Project is in planning stage. Gathering requirements, defining scope, and assigning resources.",
                "In Progress": "In Progress - Core work has started. Team is executing initial development and implementation tasks.",
                "Design Phase": "Design Phase - System design is under progress. Creating UI/UX, architecture, and technical specifications.",
                "Development Phase": "Development Phase - Major development is ongoing. Core modules are being coded and integrated.",
                "Testing Phase": "Testing Phase - System testing is in progress. Bugs are being identified, fixed, and re-tested.",
                "Review": "Review - Final review underway. Code, performance, and functionality are being evaluated.",
                "Deployment": "Deployment - Deployment is being prepared or executed. System is almost ready for production.",
                "Completed": "Completed - Project fully completed. All tasks, testing, and deployment successfully done."
            };

            // Function to sync all related fields when status changes
            function syncStatusFields() {
                const statusSelect = document.getElementById("progressStatus");
                const completionSelect = document.getElementById("completionPercentage");
                const descriptionSelect = document.getElementById("descriptionField");
                const syncIndicator = document.getElementById("syncIndicator");
                
                const selectedStatus = statusSelect.value;
                
                if (selectedStatus && statusMapping[selectedStatus]) {
                    // Auto-select the matching completion percentage
                    completionSelect.value = statusMapping[selectedStatus];
                    
                    // Auto-select the matching description
                    descriptionSelect.value = descriptionMapping[selectedStatus];
                    
                    // Show sync indicator
                    syncIndicator.classList.add("show");
                    
                    // Hide indicator after 2 seconds
                    setTimeout(function() {
                        syncIndicator.classList.remove("show");
                    }, 2000);
                }
            }
        </script>
        
        <%
                    } else {
        %>
                        <div class="alert alert-danger">
                            <strong>Error!</strong> Progress record not found with ID: <%= id %>
                        </div>
                        <a href="mviewprogress.jsp" class="btn btn-primary" style="display: block; text-align: center; text-decoration: none;">Go Back to Progress List</a>
        <%
                    }
                    
                    ps.close();
                    con.close();
                } catch (Exception e) {
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
    </div>
</body>
</html>
