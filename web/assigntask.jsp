<%@page import="database.dbconfig"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="mhome.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Assign Task</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        html, body {
            height: 100%;
            overflow: hidden;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #f7f9fc;
            color: #1a202c;
        }

        .page-content {
            margin-left: 80px;
            width: 1500px;
            padding: 20px;
            height: 750px;
            overflow-y: auto;
        }

        .form-container {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .form-header {
            padding: 10px 20px;
            border-bottom: 1px solid #e2e8f0;
        }

        .back-link {
            color: #3182ce;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
        }

        .form-title {
            font-size: 24px;
            font-weight: 700;
            margin-top: 6px;
        }

        .form-body {
            padding: 20px;
        }

        .section-title {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 10px;
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 4px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        label {
            font-size: 12px;
            font-weight: 500;
        }

        input, select, textarea {
            padding: 8px 12px;
            border: 1px solid #cbd5e0;
            border-radius: 6px;
            font-size: 14px;
        }

        input[readonly], textarea[readonly] {
            background-color: #edf2f7;
        }

        select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12'%3E%3Cpath fill='%234a5568' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 10px center;
            padding-right: 30px;
        }

        .employee-section {
            background: #f8fafc;
            padding: 16px;
            border-radius: 8px;
            margin-top: 12px;
            border: 1px solid #e2e8f0;
        }

        .employee-card {
            background: white;
            padding: 16px;
            border-radius: 8px;
            margin-bottom: 12px;
            border: 1px solid #e2e8f0;
        }

        .employee-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .employee-number {
            font-weight: 600;
            color: #3182ce;
        }

        .remove-btn {
            background: #fee;
            color: #c53030;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 12px;
        }

        .add-employee-btn {
            background: #ebf8ff;
            color: #3182ce;
            border: 2px dashed #3182ce;
            padding: 12px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            width: 100%;
        }

        .button-group {
            display: flex;
            gap: 12px;
            margin-top: 16px;
            padding-top: 12px;
            border-top: 1px solid #e2e8f0;
        }

        .btn-primary {
            background-color: #3182ce;
            color: white;
            padding: 10px;
            border-radius: 6px;
            border: none;
            flex: 1;
            font-weight: 600;
        }

        .btn-secondary {
            background-color: #e2e8f0;
            padding: 10px;
            border-radius: 6px;
            border: none;
            font-weight: 600;
        }
    </style>
</head>

<body>

<%
    String id = request.getParameter("id");
    String projectId="", projectTitle="", clientName="", email="", phone="", 
           requirements="", description="", deadline="", projectStatus="";

    if (id != null) {
        Connection con = new dbconfig().getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM requirements WHERE id=?");
        ps.setInt(1, Integer.parseInt(id));
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            projectId = rs.getString("id");
            projectTitle = rs.getString("title");
            clientName = rs.getString("cname");
            email = rs.getString("email");
            phone = rs.getString("phono");
            requirements = rs.getString("requirements");
            description = rs.getString("description");
            deadline = rs.getString("deadline");
            projectStatus = rs.getString("status");
        }
        con.close();
    }
%>

<div class="page-content">
    <div class="form-container">
        <div class="form-header">
            <a href="addprogress.jsp?id=<%= id %>" class="back-link">← Back to Progress</a>
            <h1 class="form-title">Assign Task to Multiple Employees</h1>
        </div>

        <div class="form-body">
            <form action="assigndb" method="POST" id="assignForm">
                <input type="hidden" name="project_id" value="<%= projectId %>">

                <h2 class="section-title">Project Information</h2>
                <div class="form-grid">
                    <div class="form-group"><label>Project ID</label><input value="<%= projectId %>" readonly></div>
                    <div class="form-group"><label>Project Title</label><input value="<%= projectTitle %>" readonly></div>
                    <div class="form-group"><label>Client Name</label><input value="<%= clientName %>" readonly></div>
                    <div class="form-group"><label>Email</label><input value="<%= email %>" readonly></div>
                    <div class="form-group"><label>Phone</label><input value="<%= phone %>" readonly></div>
                    <div class="form-group"><label>Deadline</label><input value="<%= deadline %>" readonly></div>
                    <div class="form-group"><label>Project Status</label><input value="<%= projectStatus %>" readonly></div>
                    <div class="form-group full-width"><label>Requirements</label><textarea readonly><%= requirements %></textarea></div>
                    <div class="form-group full-width"><label>Description</label><textarea readonly><%= description %></textarea></div>
                </div>

                <h2 class="section-title" style="margin-top:18px;">Assignment Details</h2>
                <div class="form-grid">
                    <div class="form-group">
                        <label>Start Date</label>
                        <input type="date" name="startdate" required>
                    </div>
                    <div class="form-group">
                        <label>End Date</label>
                        <input type="date" name="enddate" value="<%= deadline %>" required>
                    </div>
                    <div class="form-group">
                        <label>Status</label>
                        <select name="status" required>
                            <option value="pending">Pending</option>
                            <option value="ongoing">Ongoing</option>
                            <option value="completed">Completed</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Technology</label>
                        <select name="technology" required>
                            <option>Web Development</option>
                            <option>Mobile Development</option>
                            <option>App Development</option>
                            <option>Game Development</option>
                            <option>AI/ML</option>
                        </select>
                    </div>
                </div>

                <h2 class="section-title" style="margin-top:18px;">Employee Assignments (2–3 Required)</h2>
                <div class="employee-section">
                    <div id="employeeContainer">
                        <div class="employee-card">
                            <div class="employee-header"><span class="employee-number">Employee 1 *</span></div>
                            <select name="mid[]" required>
                                <option value="">Select Employee</option>
                                <option value="pa123">pa123</option>
                                <option value="emp002">emp002</option>
                                <option value="emp003">emp003</option>
                                <option value="emp004">emp004</option>
                                <option value="emp005">emp005</option>
                            </select>
                        </div>

                        <div class="employee-card">
                            <div class="employee-header"><span class="employee-number">Employee 2 *</span></div>
                            <select name="mid[]" required>
                                <option value="">Select Employee</option>
                                <option value="pa123">pa123</option>
                                <option value="emp002">emp002</option>
                                <option value="emp003">emp003</option>
                                <option value="emp004">emp004</option>
                                <option value="emp005">emp005</option>
                            </select>
                        </div>
                    </div>

                    <button type="button" class="add-employee-btn" id="addEmployeeBtn" onclick="addEmployee()">+ Add Third Employee (Optional)</button>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn-primary">Assign Task</button>
                    <button type="reset" class="btn-secondary">Reset</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
let employeeCount = 2;

function addEmployee() {
    if (employeeCount >= 3) return;
    employeeCount++;

    const container = document.getElementById("employeeContainer");
    const div = document.createElement("div");
    div.className = "employee-card";
    div.innerHTML = `
        <div class="employee-header">
            <span class="employee-number">Employee ${employeeCount}</span>
            <button type="button" class="remove-btn" onclick="this.parentElement.parentElement.remove(); employeeCount--; document.getElementById('addEmployeeBtn').disabled=false;">Remove</button>
        </div>
        <select name="mid[]">
            <option value="">Select Employee</option>
            <option value="pa123">pa123</option>
            <option value="emp002">emp002</option>
            <option value="emp003">emp003</option>
            <option value="emp004">emp004</option>
            <option value="emp005">emp005</option>
        </select>
    `;
    container.appendChild(div);

    if (employeeCount >= 3) {
        document.getElementById("addEmployeeBtn").disabled = true;
    }
}
</script>

</body>
</html>
