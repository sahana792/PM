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
            font-family: 'Poppins', sans-serif;
            background-color: #f5f6fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 90%;
            max-width: 600px;
            margin: 60px auto;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 40px;
        }

        h1 {
            color: #151542;
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 3px solid #151542;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
            display: block;
        }

        input[type="text"],
        input[type="date"],
        select,
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            box-sizing: border-box;
            transition: border-color 0.3s, box-shadow 0.3s;
            font-size: 15px;
            font-family: 'Poppins', sans-serif;
        }

        input:focus,
        select:focus,
        textarea:focus {
            border-color: #151542;
            box-shadow: 0 0 0 0.2rem rgba(21, 21, 66, 0.25);
            outline: none;
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
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-primary {
            background-color: #151542;
            color: white;
        }

        .btn-primary:hover {
            background-color: #0d0d2b;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(21, 21, 66, 0.3);
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .btn-back {
            background-color: #17a2b8;
            color: white;
            text-decoration: none;
            display: inline-block;
            padding: 10px 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .btn-back:hover {
            background-color: #138496;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
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

        .info-text {
            background-color: #e7f3ff;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #151542;
        }

        .info-text strong {
            color: #151542;
        }

        .info-row {
            margin-bottom: 8px;
        }
    </style>
</head>

<body>
    <div class="container">
        <a href="mviewprogress.jsp" class="btn-back">← Back to Progress List</a>
        
        <h1>Update Progress</h1>
        
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
        
        <div class="info-text">
            <div class="info-row"><strong>Progress ID:</strong> <%= id %></div>
            <div class="info-row"><strong>Phone Number:</strong> <%= phono %></div>
            <div class="info-row"><strong>Last Updated:</strong> <%= updateDate %></div>
        </div>
        
        <form action="updateprogressdb1" method="POST">
            <input type="hidden" name="id" value="<%= id %>">
            <input type="hidden" name="phono" value="<%= phono %>">
            
            <div class="form-group">
                <label>Update Title <span style="color:red;">*</span></label>
                <input type="text" name="update_title" value="<%= updateTitle %>" placeholder="e.g., Design Phase Completed" required>
            </div>
            
            <div class="form-group">
                <label>Progress Status <span style="color:red;">*</span></label>
                <select name="progress_status" required>
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
            </div>
            
            <div class="form-group">
                <label>Progress Completed <span style="color:red;">*</span></label>
                <select name="completion_percentage" required>
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
                <label>Progress Description <span style="color:red;">*</span></label>
                <select name="description" required>
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
            
            <div class="form-group">
                <label>Update Date <span style="color:red;">*</span></label>
                <input type="date" name="update_date" value="<%= updateDate %>" required>
            </div>
            
            <div class="form-group">
                <label>Next Milestone <span style="color:red;">*</span></label>
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
            
            <div class="btn-container">
                <button type="submit" class="btn btn-primary">Update Progress</button>
                <a href="mviewprogress.jsp" class="btn btn-secondary" style="text-align: center; text-decoration: none; line-height: 24px;">Cancel</a>
            </div>
        </form>
        
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
</body>
</html>