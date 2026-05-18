<%@page import="database.dbconfig"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="clientheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Client Settings</title>
    
    <style>
        body {
            background: #f5f7fa;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        
        .main-content {
            margin-left: 200px;
            margin-right: 10px;
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
            border-bottom: 2px solid #007bff;
        }
        
        .settings-section {
            margin-bottom: 25px;
        }
        
        .settings-section:last-child {
            margin-bottom: 0;
        }
        
        .setting-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .setting-item:last-child {
            border-bottom: none;
        }
        
        .setting-info {
            flex: 1;
        }
        
        .setting-info h3 {
            margin: 0 0 5px 0;
            color: #333;
            font-size: 16px;
        }
        
        .setting-info p {
            margin: 0;
            color: #666;
            font-size: 13px;
        }
        
        .setting-control {
            margin-left: 20px;
        }
        
        /* Toggle Switch */
        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
        }
        
        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 24px;
        }
        
        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        
        input:checked + .slider {
            background-color: #007bff;
        }
        
        input:checked + .slider:before {
            transform: translateX(26px);
        }
        
        /* Form Elements */
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
        .form-group input[type="tel"],
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
            background: #007bff;
            color: white;
        }
        
        .btn-primary:hover {
            background: #0056b3;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
        }
        
        .btn-success {
            background: #28a745;
            color: white;
        }
        
        .btn-success:hover {
            background: #218838;
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .btn-danger:hover {
            background: #c82333;
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
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(1, 1fr);
            gap: 15px;
            margin-top: 15px;
        }
        
        .stat-box {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            text-align: center;
        }
        
        .stat-box .label {
            color: #666;
            font-size: 12px;
            margin-bottom: 5px;
        }
        
        .stat-box .value {
            color: #007bff;
            font-size: 24px;
            font-weight: bold;
        }
        
        .info-card {
            background: #e7f3ff;
            border-left: 4px solid #007bff;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        
        .info-card h3 {
            margin: 0 0 5px 0;
            color: #007bff;
            font-size: 16px;
        }
        
        .info-card p {
            margin: 0;
            color: #666;
            font-size: 14px;
        }
    </style>
</head>
<body>
<%
    // Get client info from session
    String clientName = (String) session.getAttribute("name");
    String clientPhone = (String) session.getAttribute("phono");
    String clientEmail = (String) session.getAttribute("email");
    String clientPassword = (String) session.getAttribute("pass");
    
    // Redirect if not logged in
    if(clientPhone == null || clientPhone.isEmpty()) {
        response.sendRedirect("clientlogin.jsp");
        return;
    }
    
    String updateMessage = "";
    String updateType = "";
    
    // Get client statistics
    int totalProjects = 0;
    int activeProjects = 0;
    int completedProjects = 0;
    int totalRequirements = 0;
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = new dbconfig().getConnection();
        
        // Refresh client data from database
        PreparedStatement ps = con.prepareStatement("SELECT * FROM userlogin WHERE phono=?");
        ps.setString(1, clientPhone);
        ResultSet rs = ps.executeQuery();
        
        if(rs.next()) {
            clientName = rs.getString("name");
            clientEmail = rs.getString("email");
            clientPassword = rs.getString("pass");
        }
        rs.close();
        ps.close();
        
        // Get project progress statistics
        try {
            PreparedStatement ps1 = con.prepareStatement("SELECT COUNT(*) as count FROM projectprogress1 WHERE phono=?");
            ps1.setString(1, clientPhone);
            ResultSet rs1 = ps1.executeQuery();
            if(rs1.next()) totalProjects = rs1.getInt("count");
            rs1.close();
            ps1.close();
        } catch(Exception e) {}
        
        try {
            PreparedStatement ps2 = con.prepareStatement("SELECT COUNT(*) as count FROM projectprogress1 WHERE phono=? AND progress_status='Completed'");
            ps2.setString(1, clientPhone);
            ResultSet rs2 = ps2.executeQuery();
            if(rs2.next()) completedProjects = rs2.getInt("count");
            rs2.close();
            ps2.close();
        } catch(Exception e) {}
        
        try {
            PreparedStatement ps3 = con.prepareStatement("SELECT COUNT(*) as count FROM projectprogress1 WHERE phono=? AND progress_status!='Completed'");
            ps3.setString(1, clientPhone);
            ResultSet rs3 = ps3.executeQuery();
            if(rs3.next()) activeProjects = rs3.getInt("count");
            rs3.close();
            ps3.close();
        } catch(Exception e) {}
        
        try {
            PreparedStatement ps4 = con.prepareStatement("SELECT COUNT(*) as count FROM requirements WHERE phono=?");
            ps4.setString(1, clientPhone);
            ResultSet rs4 = ps4.executeQuery();
            if(rs4.next()) totalRequirements = rs4.getInt("count");
            rs4.close();
            ps4.close();
        } catch(Exception e) {}
        
        con.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
    
    // Handle form submissions
    if(request.getMethod().equalsIgnoreCase("POST")) {
        String action = request.getParameter("action");
        
        if("updateProfile".equals(action)) {
            String newName = request.getParameter("name");
            String newEmail = request.getParameter("email");
            String newPhone = request.getParameter("phono");
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = new dbconfig().getConnection();
                
                PreparedStatement ps = con.prepareStatement("UPDATE userlogin SET name=?, email=?, phono=? WHERE phono=?");
                ps.setString(1, newName);
                ps.setString(2, newEmail);
                ps.setString(3, newPhone);
                ps.setString(4, clientPhone);
                
                int updated = ps.executeUpdate();
                
                if(updated > 0) {
                    session.setAttribute("name", newName);
                    session.setAttribute("email", newEmail);
                    session.setAttribute("phono", newPhone);
                    clientName = newName;
                    clientEmail = newEmail;
                    clientPhone = newPhone;
                    updateMessage = "Profile updated successfully!";
                    updateType = "success";
                } else {
                    updateMessage = "Failed to update profile.";
                    updateType = "danger";
                }
                
                ps.close();
                con.close();
            } catch(Exception e) {
                updateMessage = "Error: " + e.getMessage();
                updateType = "danger";
            }
        }
        else if("changePassword".equals(action)) {
            String currentPass = request.getParameter("currentPassword");
            String newPass = request.getParameter("newPassword");
            String confirmPass = request.getParameter("confirmPassword");
            
            if(currentPass.equals(clientPassword)) {
                if(newPass.equals(confirmPass)) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = new dbconfig().getConnection();
                        
                        PreparedStatement ps = con.prepareStatement("UPDATE userlogin SET pass=? WHERE phono=?");
                        ps.setString(1, newPass);
                        ps.setString(2, clientPhone);
                        
                        int updated = ps.executeUpdate();
                        
                        if(updated > 0) {
                            session.setAttribute("pass", newPass);
                            clientPassword = newPass;
                            updateMessage = "Password changed successfully!";
                            updateType = "success";
                        } else {
                            updateMessage = "Failed to change password.";
                            updateType = "danger";
                        }
                        
                        ps.close();
                        con.close();
                    } catch(Exception e) {
                        updateMessage = "Error: " + e.getMessage();
                        updateType = "danger";
                    }
                } else {
                    updateMessage = "New password and confirm password do not match!";
                    updateType = "danger";
                }
            } else {
                updateMessage = "Current password is incorrect!";
                updateType = "danger";
            }
        }
    }
%>
    
    <div class="main-content" style="width: 1000px;max-width: none;">
        <!-- Settings Header -->
        <div class="settings-header">
            <h1>⚙️ Client Settings</h1>
        </div>
        
        <!-- Success/Error Messages -->
        <% if(!updateMessage.isEmpty()) { %>
        <div class="alert alert-<%= updateType %>">
            <%= updateMessage %>
        </div>
        <% } %>
        
        <div class="settings-container">
            <!-- Profile Settings -->
            <div class="settings-card">
                <h2>👤 Profile Settings</h2>
                
                <form method="post">
                    <input type="hidden" name="action" value="updateProfile">
                    
                    <div class="form-group">
                        <label>Full Name</label>
                        <input type="text" name="name" value="<%= clientName != null ? clientName : "" %>" placeholder="Your Full Name" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email" value="<%= clientEmail != null ? clientEmail : "" %>" placeholder="your@email.com" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="tel" name="phono" value="<%= clientPhone != null ? clientPhone : "" %>" placeholder="Phone Number" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Account Type</label>
                        <input type="text" value="Client Account" disabled style="background: #f8f9fa;">
                    </div>
                    
                    <div class="button-group">
                        <button type="submit" class="btn btn-primary">💾 Save Changes</button>
                        <button type="reset" class="btn btn-secondary">🔄 Reset</button>
                    </div>
                </form>
            </div>
            
            <!-- My Statistics -->
            <div class="settings-card">
                <h2>📊 My Statistics</h2>
                
                <div class="stats-grid">
                    <div class="stat-box">
                        <div class="label">Total Projects</div>
                        <div class="value"><%= totalProjects %></div>
                    </div>
                    <div class="stat-box">
                        <div class="label">Active Projects</div>
                        <div class="value"><%= activeProjects %></div>
                    </div>
                    <div class="stat-box">
                        <div class="label">Completed Projects</div>
                        <div class="value"><%= completedProjects %></div>
                    </div>
                    <div class="stat-box">
                        <div class="label">Total Requirements</div>
                        <div class="value"><%= totalRequirements %></div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Security Settings -->
        <div class="settings-card full-width-card">
            <h2>🔒 Security Settings</h2>
            
            <form method="post">
                <input type="hidden" name="action" value="changePassword">
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Current Password</label>
                        <input type="password" name="currentPassword" placeholder="Enter current password" required>
                    </div>
                    <div></div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>New Password</label>
                        <input type="password" name="newPassword" placeholder="Enter new password" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Confirm New Password</label>
                        <input type="password" name="confirmPassword" placeholder="Confirm new password" required>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-danger">🔑 Change Password</button>
            </form>
        </div>
        
        <!-- Notification Preferences -->
        <div class="settings-card full-width-card">
            <h2>🔔 Notification Preferences</h2>
            
            <div class="settings-section">
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Project Status Updates</h3>
                        <p>Get notified when your project status changes</p>
                    </div>
                    <div class="setting-control">
                        <label class="toggle-switch">
                            <input type="checkbox" checked onchange="updateSetting('project_status', this.checked)">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Progress Updates</h3>
                        <p>Receive notifications when project progress is updated</p>
                    </div>
                    <div class="setting-control">
                        <label class="toggle-switch">
                            <input type="checkbox" checked onchange="updateSetting('progress_updates', this.checked)">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Milestone Completion</h3>
                        <p>Get notified when project milestones are completed</p>
                    </div>
                    <div class="setting-control">
                        <label class="toggle-switch">
                            <input type="checkbox" checked onchange="updateSetting('milestone_completion', this.checked)">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Requirement Status</h3>
                        <p>Receive updates when your requirements are accepted or rejected</p>
                    </div>
                    <div class="setting-control">
                        <label class="toggle-switch">
                            <input type="checkbox" checked onchange="updateSetting('requirement_status', this.checked)">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Email Notifications</h3>
                        <p>Send email notifications for all updates</p>
                    </div>
                    <div class="setting-control">
                        <label class="toggle-switch">
                            <input type="checkbox" onchange="updateSetting('email_notifications', this.checked)">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>SMS Notifications</h3>
                        <p>Receive SMS alerts for important updates</p>
                    </div>
                    <div class="setting-control">
                        <label class="toggle-switch">
                            <input type="checkbox" onchange="updateSetting('sms_notifications', this.checked)">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Account Information -->
        <div class="settings-card full-width-card">
            <h2>ℹ️ Account Information</h2>
            
            <div class="info-card">
                <h3>Client Details</h3>
                <p><strong>Name:</strong> <%= clientName %></p>
                <p><strong>Email:</strong> <%= clientEmail %></p>
                <p><strong>Phone:</strong> <%= clientPhone %></p>
                <p><strong>Account Type:</strong> Client</p>
            </div>
            
            <div style="margin-top: 15px; padding: 15px; background: #fff3cd; border-left: 4px solid #ffc107; border-radius: 5px;">
                <p style="margin: 0; color: #856404; font-size: 14px;">
                    <strong>Privacy:</strong> Your information is secure and will not be shared with third parties.
                </p>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div class="settings-card full-width-card">
            <h2>⚡ Quick Actions</h2>
            
            <div class="info-card">
                <h3>💡 Tip</h3>
                <p>Use these quick actions to manage your projects and download reports for your records.</p>
            </div>
            
            <div class="settings-section">
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Export My Projects</h3>
                        <p>Download all your project details as PDF</p>
                    </div>
                    <div class="setting-control">
                        <button class="btn btn-primary" onclick="exportProjects()">📥 Export Projects</button>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Download Progress Report</h3>
                        <p>Generate and download detailed progress report</p>
                    </div>
                    <div class="setting-control">
                        <button class="btn btn-success" onclick="downloadReport()">📊 Download Report</button>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>View All Requirements</h3>
                        <p>See all your submitted project requirements</p>
                    </div>
                    <div class="setting-control">
                        <button class="btn btn-primary" onclick="window.location.href='clientrequirements.jsp'">📋 View Requirements</button>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Contact Support</h3>
                        <p>Get help with your projects or account</p>
                    </div>
                    <div class="setting-control">
                        <button class="btn btn-secondary" onclick="contactSupport()">💬 Contact Support</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function updateSetting(settingName, value) {
            console.log('Updating ' + settingName + ' to ' + value);
            
            // Show confirmation
            const messages = {
                'project_status': 'Project status notifications ' + (value ? 'enabled' : 'disabled'),
                'progress_updates': 'Progress update notifications ' + (value ? 'enabled' : 'disabled'),
                'milestone_completion': 'Milestone completion alerts ' + (value ? 'enabled' : 'disabled'),
                'requirement_status': 'Requirement status notifications ' + (value ? 'enabled' : 'disabled'),
                'email_notifications': 'Email notifications ' + (value ? 'enabled' : 'disabled'),
                'sms_notifications': 'SMS notifications ' + (value ? 'enabled' : 'disabled')
            };
            
            alert(messages[settingName] || 'Setting updated');
        }
        
        function exportProjects() {
            if(confirm('Export all your project details to PDF?')) {
                alert('Exporting projects...');
                // Add actual export logic here
                // window.location.href = 'exportClientProjects.jsp';
            }
        }
        
        function downloadReport() {
            if(confirm('Generate detailed progress report for all your projects?')) {
                alert('Generating progress report...');
                // Add actual download logic here
                // window.location.href = 'downloadProgressReport.jsp';
            }
        }
        
        function contactSupport() {
            if(confirm('Contact support team?\n\nYou will be redirected to the support page.')) {
                alert('Opening support page...');
                // Add actual contact logic here
                // window.location.href = 'contactsupport.jsp';
            }
        }
    </script>
</body>
</html>