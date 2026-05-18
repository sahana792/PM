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
            text-decoration: none;
            text-align: center;
            display: inline-block;
        }

        .btn-warning {
            background-color: #ffc107;
            color: #000;
        }

        .btn-warning:hover {
            background-color: #e0a800;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(255, 193, 7, 0.3);
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
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

        .top-buttons {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            gap: 10px;
        }

        .top-buttons .btn {
            flex: 0 0 auto;
            padding: 10px 20px;
            font-size: 14px;
        }

        .btn-info {
            background-color: #17a2b8;
            color: white;
        }

        .btn-info:hover {
            background-color: #138496;
        }
    </style>
</head>

<body>
    <div class="container">
        <h1>✏️ Update Progress</h1>
        
        <%
            String id = request.getParameter("id");
            String phono = request.getParameter("phono");
            
            if (id == null || id.trim().isEmpty()) {
        %>
                <div class="alert alert-warning">
                    <strong>Error!</strong> No progress update selected. Please go back and try again.
                </div>
        <%
            } else {
                String updateTitle = "";
                String progressStatus = "";
                String completionPercentage = "";
                String description = "";
                String updateDate = "";
                String nextMilestone = "";
                String pname = "";
                String cname = "";
                
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = new dbconfig().getConnection();
                    
                    // Get progress details
                    String sql = "SELECT * FROM projectprogress1 WHERE id = ?";
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setString(1, id);
                    ResultSet rs = ps.executeQuery();
                    
                    if (rs.next()) {
                        phono = rs.getString("phono");
                        updateTitle = rs.getString("update_title");
                        progressStatus = rs.getString("progress_status");
                        completionPercentage = rs.getString("completion_percentage");
                        description = rs.getString("description");
                        updateDate = rs.getString("update_date");
                        nextMilestone = rs.getString("next_milestone");
                        
                        // Handle null values
                        if (nextMilestone == null) nextMilestone = "";
                    }
                    rs.close();
                    ps.close();
                    
                    // Get project details
                    String projectSql = "SELECT pname, cname FROM mpadd1 WHERE phono = ?";
                    PreparedStatement psProject = con.prepareStatement(projectSql);
                    psProject.setString(1, phono);
                    ResultSet rsProject = psProject.executeQuery();
                    
                    if (rsProject.next()) {
                        pname = rsProject.getString("pname");
                        cname = rsProject.getString("cname");
                    }
                    rsProject.close();
                    psProject.close();
                    
                    con.close();
                } catch (Exception e) {
                    out.println("<div class='alert alert-warning'>Error: " + e.getMessage() + "</div>");
                    e.printStackTrace();
                }
        %>
        
        <div class="top-buttons">
            <a href="mviewprogress.jsp?phono=<%= phono %>" class="btn btn-info">📊 View All Progress</a>
        </div>
        
        <div class="info-text">
            <strong>Project:</strong> <%= pname %><br>
            <strong>Client:</strong> <%= cname %><br>
            <strong>Phone:</strong> <%= phono %>
        </div>
        
        <form action="updateprogressdb" method="POST">
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
                    <option value="Planning" <%= progressStatus.equals("Planning") ? "selected" : "" %>>Planning</option>
                    <option value="In Progress" <%= progressStatus.equals("In Progress") ? "selected" : "" %>>In Progress</option>
                    <option value="Design Phase" <%= progressStatus.equals("Design Phase") ? "selected" : "" %>>Design Phase</option>
                    <option value="Development Phase" <%= progressStatus.equals("Development Phase") ? "selected" : "" %>>Development Phase</option>
                    <option value="Testing Phase" <%= progressStatus.equals("Testing Phase") ? "selected" : "" %>>Testing Phase</option>
                    <option value="Review" <%= progressStatus.equals("Review") ? "selected" : "" %>>Review</option>
                    <option value="Deployment" <%= progressStatus.equals("Deployment") ? "selected" : "" %>>Deployment</option>
                    <option value="Completed" <%= progressStatus.equals("Completed") ? "selected" : "" %>>Completed</option>
                    <option value="On Hold" <%= progressStatus.equals("On Hold") ? "selected" : "" %>>On Hold</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>Completion Percentage <span style="color:red;">*</span></label>
                <select name="completion_percentage" required>
                    <option value="">-- Select Percentage --</option>
                    <option value="0" <%= completionPercentage.equals("0") ? "selected" : "" %>>0% - Not Started</option>
                    <option value="10" <%= completionPercentage.equals("10") ? "selected" : "" %>>10%</option>
                    <option value="20" <%= completionPercentage.equals("20") ? "selected" : "" %>>20%</option>
                    <option value="30" <%= completionPercentage.equals("30") ? "selected" : "" %>>30%</option>
                    <option value="40" <%= completionPercentage.equals("40") ? "selected" : "" %>>40%</option>
                    <option value="50" <%= completionPercentage.equals("50") ? "selected" : "" %>>50%</option>
                    <option value="60" <%= completionPercentage.equals("60") ? "selected" : "" %>>60%</option>
                    <option value="70" <%= completionPercentage.equals("70") ? "selected" : "" %>>70%</option>
                    <option value="80" <%= completionPercentage.equals("80") ? "selected" : "" %>>80%</option>
                    <option value="90" <%= completionPercentage.equals("90") ? "selected" : "" %>>90%</option>
                    <option value="100" <%= completionPercentage.equals("100") ? "selected" : "" %>>100% - Completed</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>Description <span style="color:red;">*</span></label>
                <textarea name="description" placeholder="Describe the progress update in detail..." required><%= description %></textarea>
            </div>
            
            <div class="form-group">
                <label>Update Date <span style="color:red;">*</span></label>
                <input type="date" name="update_date" value="<%= updateDate %>" required>
            </div>
            
            <div class="form-group">
                <label>Next Milestone</label>
                <input type="text" name="next_milestone" value="<%= nextMilestone %>" placeholder="e.g., Start Development Phase">
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn btn-warning">💾 Update Progress</button>
                <a href="mviewprogress.jsp?phono=<%= phono %>" class="btn btn-secondary">✖ Cancel</a>
            </div>
        </form>
        
        <% } %>
    </div>
</body>
</html>