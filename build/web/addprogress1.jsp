<%@page import="java.sql.*"%>
<%@page import="database.dbconfig"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="emphome.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Progress</title>

    <style>
        body { font-family: 'Poppins', sans-serif; background:#f4f4f4; }
        .container {
            width: 90%; max-width: 600px; margin: 40px auto;
            background: #fff; padding: 25px; border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        h2 { text-align: center; color:#151542; }
        label { font-weight: 600; margin-top: 10px; display: block; }
        input, textarea, select {
            width:100%; padding:10px; border:1px solid #ccc;
            border-radius: 6px; margin-top: 5px;
        }
        textarea { resize: none; }
        button {
            margin-top:20px; width:100%; padding:12px;
            background:#28a745; color:#fff; border:none;
            font-size:16px; font-weight:600; border-radius:6px;
            cursor:pointer;
        }
        button:hover { background:#1e7e34; }
    </style>
</head>

<body>

<%
    String projectId = request.getParameter("id");
    String pname="", phono="";

    try {
        Connection con = new dbconfig().getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT pname, phono FROM mpadd1 WHERE id=?");
        ps.setString(1, projectId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            pname = rs.getString("pname");
            phono = rs.getString("phono");
        }

        con.close();
    } catch(Exception e) {
        out.println(e);
    }
%>

<div class="container">
    <h2>Add Project Progress</h2>

    <form action="add_progress.jsp" method="post">

        <input type="hidden" name="project_id" value="<%= projectId %>">

        <label>Project Name</label>
        <input type="text" value="<%= pname %>" disabled>

        <label>Phone Number</label>
        <input type="text" name="phono" value="<%= phono %>" readonly>

        <label>Update Title</label>
        <input type="text" name="title" required>

        <label>Status</label>
        <select name="status" required>
            <option value="Planning">Planning</option>
            <option value="In Progress">In Progress</option>
            <option value="Development">Development</option>
            <option value="Testing">Testing</option>
            <option value="Review">Review</option>
            <option value="Deployment">Deployment</option>
            <option value="Completed">Completed</option>
        </select>

        <label>Completion %</label>
        <input type="number" min="0" max="100" name="completion" required>

        <label>Description</label>
        <textarea name="description" rows="4" required></textarea>

        <label>Update Date</label>
        <input type="date" name="udate" required>

        <label>Next Milestone</label>
        <input type="text" name="milestone">

        <button type="submit">Submit Progress</button>
    </form>
</div>

</body>
</html>
