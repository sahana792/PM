<%@page import="java.sql.*"%>
<%@page import="database.dbconfig"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="mhome.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Progress</title>
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f5f6fa; margin:0; padding:0; }
        .container { max-width: 600px; margin: 50px auto; background-color: #fff;
                     padding: 30px; border-radius: 10px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        h1 { text-align:center; color:#151542; margin-bottom: 25px; }
        label { display:block; margin-top: 15px; font-weight:600; }
        input[type=text], input[type=number], input[type=date], select, textarea {
            width:100%; padding:10px; margin-top:5px; border-radius:5px; border:1px solid #ccc;
            box-sizing:border-box; font-size:14px;
        }
        textarea { resize:vertical; }
        .btn { margin-top:20px; padding:12px 20px; background-color:#151542; color:white;
               border:none; border-radius:6px; cursor:pointer; font-weight:600; }
        .btn:hover { background-color:#2d2d6e; }
        .alert { padding: 12px; margin-top: 20px; border-radius:6px; }
        .alert-success { background-color:#d4edda; color:#155724; }
        .alert-error { background-color:#f8d7da; color:#721c24; }
    </style>
</head>
<body>
<div class="container">
    <h1>✏️ Update Progress</h1>

<%
    String idParam = request.getParameter("id");
    if(idParam == null || idParam.trim().isEmpty()){
%>
    <div class="alert alert-error">Invalid progress record.</div>
<%
    } else {
        int id = Integer.parseInt(idParam);
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = new dbconfig().getConnection();

            if("POST".equalsIgnoreCase(request.getMethod())){
                // Process update
                String updateTitle = request.getParameter("update_title");
                String progressStatus = request.getParameter("progress_status");
                String completionPercentage = request.getParameter("completion_percentage");
                String description = request.getParameter("description");
                String updateDate = request.getParameter("update_date");
                String nextMilestone = request.getParameter("next_milestone");

                String updateSql = "UPDATE projectprogress1 SET update_title=?, progress_status=?, completion_percentage=?, description=?, update_date=?, next_milestone=? WHERE id=?";
                ps = con.prepareStatement(updateSql);
                ps.setString(1, updateTitle);
                ps.setString(2, progressStatus);
                ps.setString(3, completionPercentage);
                ps.setString(4, description);
                ps.setString(5, updateDate);
                ps.setString(6, nextMilestone);
                ps.setInt(7, id);
                int updated = ps.executeUpdate();
                ps.close();

                if(updated > 0){
%>
    <div class="alert alert-success">Progress updated successfully!</div>
<%
                } else {
%>
    <div class="alert alert-error">Failed to update progress.</div>
<%
                }
            }

            // Fetch current values
            String sql = "SELECT * FROM projectprogress1 WHERE id=?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if(rs.next()){
                String updateTitle = rs.getString("update_title");
                String progressStatus = rs.getString("progress_status");
                String completionPercentage = rs.getString("completion_percentage");
                String description = rs.getString("description");
                String updateDate = rs.getString("update_date");
                String nextMilestone = rs.getString("next_milestone");
%>

    <form method="post">
        <label>Update Title:</label>
        <input type="text" name="update_title" value="<%= updateTitle %>" required>

        <label>Status:</label>
        <select name="progress_status" required>
            <option value="Planning" <%= "Planning".equalsIgnoreCase(progressStatus)?"selected":"" %>>Planning</option>
            <option value="In Progress" <%= "In Progress".equalsIgnoreCase(progressStatus)?"selected":"" %>>In Progress</option>
            <option value="Design Phase" <%= "Design Phase".equalsIgnoreCase(progressStatus)?"selected":"" %>>Design Phase</option>
            <option value="Development Phase" <%= "Development Phase".equalsIgnoreCase(progressStatus)?"selected":"" %>>Development Phase</option>
            <option value="Testing Phase" <%= "Testing Phase".equalsIgnoreCase(progressStatus)?"selected":"" %>>Testing Phase</option>
            <option value="Review" <%= "Review".equalsIgnoreCase(progressStatus)?"selected":"" %>>Review</option>
            <option value="Deployment" <%= "Deployment".equalsIgnoreCase(progressStatus)?"selected":"" %>>Deployment</option>
            <option value="Completed" <%= "Completed".equalsIgnoreCase(progressStatus)?"selected":"" %>>Completed</option>
            <option value="On Hold" <%= "On Hold".equalsIgnoreCase(progressStatus)?"selected":"" %>>On Hold</option>
        </select>

        <label>Completion Percentage:</label>
        <input type="number" name="completion_percentage" min="0" max="100" value="<%= completionPercentage %>" required>

        <label>Description:</label>
        <textarea name="description" rows="4"><%= description %></textarea>

        <label>Update Date:</label>
        <input type="date" name="update_date" value="<%= updateDate %>" required>

        <label>Next Milestone:</label>
        <input type="text" name="next_milestone" value="<%= nextMilestone %>">

        <button type="submit" class="btn">Update Progress</button>
    </form>

<%
            } else {
%>
    <div class="alert alert-error">Progress record not found.</div>
<%
            }

            rs.close();
            ps.close();
            con.close();
        } catch(Exception e){
%>
    <div class="alert alert-error">Error: <%= e.getMessage() %></div>
<%
        }
    }
%>
</div>
</body>
</html>
