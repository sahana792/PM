<%@page import="database.dbconfig"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="emphome.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Settings</title>
    
    <style>
        body {
            background: #f5f7fa;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        
        .main-content {
            margin-left: 150px;
            margin-right: 30px;
            padding: 20px;
            max-width: 1200px;
        }
        
        .settings-header {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .settings-header h1 {
            color: #333;
            margin: 0;
            font-size: 28px;
        }
        
        .settings-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        
        .full-width-card {
            grid-column: 1 / -1;
        }
        
        .settings-card {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .settings-card h2 {
            color: #333;
            font-size: 20px;
            margin: 0 0 20px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #28a745;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
            font-size: 14px;
        }
        
        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="password"],
        .form-group input[type="number"],
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        .btn-primary {
            background: #28a745;
            color: white;
        }
        
        .btn-primary:hover {
            background: #218838;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
        }
        
        .alert {
            padding: 12px 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        
        .info-box {
            background: #e7f3ff;
            border-left: 4px solid #007bff;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        
        .info-box h3 {
            margin: 0 0 5px 0;
            color: #004085;
        }
        
        .info-box p {
            margin: 0;
            color: #004085;
        }
    </style>
</head>
<body>
<%
    // Check if employee is logged in
    String empId = (String) session.getAttribute("mid");
    if(empId == null) {
        response.sendRedirect("emplogin.jsp");
        return;
    }
    
    // Initialize variables
    String empName = "";
    String empPhone = "";
    int empAge = 0;
    String empRoles = "";
    int empSalary = 0;
    String empPassword = "";
    String updateMessage = "";
    String updateType = "";
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = new dbconfig().getConnection();
        
        // Get employee details
        PreparedStatement pst = con.prepareStatement("SELECT * FROM employee WHERE mid=?");
        pst.setString(1, empId);
        ResultSet rs = pst.executeQuery();
        
        if(rs.next()) {
            empName = rs.getString("name");
            empPhone = rs.getString("phono");
            empAge = rs.getInt("age");
            empRoles = rs.getString("roles");
            empSalary = rs.getInt("salary");
            empPassword = rs.getString("pass");
        }
        
        con.close();
    } catch(Exception e) {
        out.println("<div style='color:red; padding:20px;'>Database Connection Error: " + e.getMessage() + "</div>");
        e.printStackTrace();
    }
    
    // Handle form submissions
    if(request.getMethod().equalsIgnoreCase("POST")) {
        String action = request.getParameter("action");
        
        if("updateProfile".equals(action)) {
            String newName = request.getParameter("empName");
            String newPhone = request.getParameter("empPhone");
            String newAge = request.getParameter("empAge");
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = new dbconfig().getConnection();
                
                PreparedStatement pst = con.prepareStatement(
                    "UPDATE employee SET name=?, phono=?, age=? WHERE mid=?"
                );
                pst.setString(1, newName);
                pst.setString(2, newPhone);
                pst.setString(3, newAge);
                pst.setString(4, empId);
                
                int updated = pst.executeUpdate();
                
                if(updated > 0) {
                    empName = newName;
                    empPhone = newPhone;
                    empAge = Integer.parseInt(newAge);
                    updateMessage = "Profile updated successfully!";
                    updateType = "success";
                } else {
                    updateMessage = "Failed to update profile.";
                    updateType = "danger";
                }
                
                con.close();
            } catch(Exception e) {
                updateMessage = "Error: " + e.getMessage();
                updateType = "danger";
            }
        }
        else if("changePassword".equals(action)) {
            String oldPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            
            if(!oldPassword.equals(empPassword)) {
                updateMessage = "Current password is incorrect!";
                updateType = "danger";
            } else if(!newPassword.equals(confirmPassword)) {
                updateMessage = "New passwords do not match!";
                updateType = "danger";
            } else if(newPassword.length() < 3) {
                updateMessage = "Password must be at least 3 characters long!";
                updateType = "danger";
            } else {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = new dbconfig().getConnection();
                    
                    PreparedStatement pst = con.prepareStatement(
                        "UPDATE employee SET pass=? WHERE mid=?"
                    );
                    pst.setString(1, newPassword);
                    pst.setString(2, empId);
                    
                    int updated = pst.executeUpdate();
                    
                    if(updated > 0) {
                        empPassword = newPassword;
                        updateMessage = "Password changed successfully!";
                        updateType = "success";
                    } else {
                        updateMessage = "Failed to change password.";
                        updateType = "danger";
                    }
                    
                    con.close();
                } catch(Exception e) {
                    updateMessage = "Error: " + e.getMessage();
                    updateType = "danger";
                }
            }
        }
    }
%>
    
    <div class="main-content" style="width: 1100px;max-width: none;">
        <!-- Settings Header -->
        <div class="settings-header">
            <h1>⚙️ My Settings</h1>
        </div>
        
        <!-- Success/Error Messages -->
        <% if(!updateMessage.isEmpty()) { %>
        <div class="alert alert-<%= updateType %>">
            <%= updateMessage %>
        </div>
        <% } %>
        
        <!-- Employee Info Box -->
        <div class="info-box">
            <h3>👤 Employee ID: <%= empId %></h3>
            <p>Role: <%= empRoles %> | Salary: ₹<%= empSalary %></p>
        </div>
        
        <div class="settings-container">
            <!-- Profile Settings -->
            <div class="settings-card">
                <h2>👤 Profile Settings</h2>
                
                <form method="post">
                    <input type="hidden" name="action" value="updateProfile">
                    
                    <div class="form-group">
                        <label>Full Name</label>
                        <input type="text" name="empName" value="<%= empName %>" placeholder="Your Full Name" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text" name="empPhone" value="<%= empPhone %>" placeholder="Your Phone Number" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Age</label>
                        <input type="number" name="empAge" value="<%= empAge %>" min="18" max="100" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Employee ID</label>
                        <input type="text" value="<%= empId %>" disabled style="background: #f8f9fa;">
                    </div>
                    
                    <div class="form-group">
                        <label>Role</label>
                        <input type="text" value="<%= empRoles %>" disabled style="background: #f8f9fa;">
                    </div>
                    
                    <div class="button-group">
                        <button type="submit" class="btn btn-primary">💾 Save Changes</button>
                        <button type="reset" class="btn btn-secondary">🔄 Reset</button>
                    </div>
                </form>
            </div>
            
            <!-- Change Password -->
            <div class="settings-card">
                <h2>🔐 Change Password</h2>
                
                <form method="post">
                    <input type="hidden" name="action" value="changePassword">
                    
                    <div class="form-group">
                        <label>Current Password</label>
                        <input type="password" name="currentPassword" placeholder="Enter current password" required>
                    </div>
                    
                    <div class="form-group">
                        <label>New Password</label>
                        <input type="password" name="newPassword" placeholder="Enter new password" required minlength="3">
                    </div>
                    
                    <div class="form-group">
                        <label>Confirm New Password</label>
                        <input type="password" name="confirmPassword" placeholder="Confirm new password" required minlength="3">
                    </div>
                    
                    <button type="submit" class="btn btn-primary">🔒 Update Password</button>
                </form>
                
                <div style="margin-top: 20px; padding: 15px; background: #fff3cd; border-radius: 5px; border-left: 4px solid #ffc107;">
                    <strong>⚠️ Security Tips:</strong>
                    <ul style="margin: 10px 0 0 0; padding-left: 20px; color: #856404;">
                        <li>Use a strong password</li>
                        <li>Don't share your password</li>
                        <li>Change password regularly</li>
                    </ul>
                </div>
            </div>
        </div>
        
        <!-- Account Information -->
        <div class="settings-card full-width-card">
            <h2>📋 Account Information</h2>
            
            <div class="form-row">
                <div class="form-group">
                    <label>Employee ID</label>
                    <input type="text" value="<%= empId %>" disabled style="background: #f8f9fa;">
                </div>
                <div class="form-group">
                    <label>Role/Position</label>
                    <input type="text" value="<%= empRoles %>" disabled style="background: #f8f9fa;">
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label>Current Salary</label>
                    <input type="text" value="₹ <%= empSalary %>" disabled style="background: #f8f9fa;">
                </div>
                <div class="form-group">
                    <label>Account Status</label>
                    <input type="text" value="Active" disabled style="background: #d4edda; color: #155724;">
                </div>
            </div>
            
            <div style="margin-top: 20px; padding: 15px; background: #d1ecf1; border-radius: 5px; border-left: 4px solid #17a2b8;">
                <strong>ℹ️ Note:</strong> If you need to update your role, salary, or other restricted information, please contact your administrator.
            </div>
        </div>
    </div>
</body>
</html>