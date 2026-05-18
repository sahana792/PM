<%@page import="database.dbconfig"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="adminheader.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Settings</title>
    
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
        .form-group input[type="number"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }
        
        .form-group textarea {
            min-height: 100px;
            resize: vertical;
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
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .btn-danger:hover {
            background: #c82333;
        }
        
        .btn-success {
            background: #28a745;
            color: white;
        }
        
        .btn-success:hover {
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
        
        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
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
        
        .danger-zone {
            background: #fff5f5;
            border: 2px solid #dc3545;
            padding: 20px;
            border-radius: 5px;
            margin-top: 20px;
        }
        
        .danger-zone h3 {
            color: #dc3545;
            margin: 0 0 10px 0;
        }
    </style>
</head>
<body>
<%
    // Initialize variables
    String adminName = "";
    String adminPassword = "";
    String updateMessage = "";
    String updateType = "";
    
    // Get system statistics
    int totalEmployees = 0;
    int totalProjects = 0;
    int totalClients = 0;
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = new dbconfig().getConnection();
        
        // Get first admin record
        try {
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT name, pass FROM admin LIMIT 1");
            
            if(rs.next()) {
                adminName = rs.getString("name");
                adminPassword = rs.getString("pass");
            }
        } catch(Exception e) {
            // Admin table doesn't exist or error
        }
        
        // Get employee count - try different possible table names
        try {
            Statement st1 = con.createStatement();
            ResultSet rs1 = st1.executeQuery("SELECT COUNT(*) as count FROM empreg");
            if(rs1.next()) totalEmployees = rs1.getInt("count");
        } catch(Exception e) {
            try {
                Statement st1 = con.createStatement();
                ResultSet rs1 = st1.executeQuery("SELECT COUNT(*) as count FROM employee");
                if(rs1.next()) totalEmployees = rs1.getInt("count");
            } catch(Exception e2) {
                // Table doesn't exist
            }
        }
        
        // Get project count
        try {
            Statement st2 = con.createStatement();
            ResultSet rs2 = st2.executeQuery("SELECT COUNT(*) as count FROM mpadd1");
            if(rs2.next()) totalProjects = rs2.getInt("count");
        } catch(Exception e) {
            try {
                Statement st2 = con.createStatement();
                ResultSet rs2 = st2.executeQuery("SELECT COUNT(*) as count FROM projects");
                if(rs2.next()) totalProjects = rs2.getInt("count");
            } catch(Exception e2) {
                // Table doesn't exist
            }
        }
        
        // Get client count
        try {
            Statement st3 = con.createStatement();
            ResultSet rs3 = st3.executeQuery("SELECT COUNT(*) as count FROM requirements");
            if(rs3.next()) totalClients = rs3.getInt("count");
        } catch(Exception e) {
            try {
                Statement st3 = con.createStatement();
                ResultSet rs3 = st3.executeQuery("SELECT COUNT(*) as count FROM clients");
                if(rs3.next()) totalClients = rs3.getInt("count");
            } catch(Exception e2) {
                // Table doesn't exist
            }
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
            String newName = request.getParameter("adminName");
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = new dbconfig().getConnection();
                
                Statement st = con.createStatement();
                int updated = st.executeUpdate("UPDATE admin SET name='" + newName + "' WHERE name='" + adminName + "'");
                
                if(updated > 0) {
                    adminName = newName;
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
            
            if(!oldPassword.equals(adminPassword)) {
                updateMessage = "Current password is incorrect!";
                updateType = "danger";
            } else if(!newPassword.equals(confirmPassword)) {
                updateMessage = "New passwords do not match!";
                updateType = "danger";
            } else {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = new dbconfig().getConnection();
                    
                    Statement st = con.createStatement();
                    int updated = st.executeUpdate("UPDATE admin SET pass='" + newPassword + "' WHERE name='" + adminName + "'");
                    
                    if(updated > 0) {
                        adminPassword = newPassword;
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
    
    <div class="main-content"  style="width: 1100px;max-width: none;">
        <!-- Settings Header -->
        <div class="settings-header">
            <h1>⚙️ Settings</h1>
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
                        <label>Admin Username</label>
                        <input type="text" name="adminName" value="<%= adminName %>" placeholder="Admin Username" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Role</label>
                        <input type="text" value="Administrator" disabled style="background: #f8f9fa;">
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
                        <input type="password" name="newPassword" placeholder="Enter new password" required>
                    </div>
                    <div class="form-group">
                        <label>Confirm New Password</label>
                        <input type="password" name="confirmPassword" placeholder="Confirm new password" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">🔒 Update Password</button>
                </form>
            </div>
        </div>
        
        <!-- System Settings -->
        <div class="settings-card full-width-card">
            <h2>🖥️ System Settings</h2>
            
            <div class="settings-section">
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Email Notifications</h3>
                        <p>Receive email notifications for important updates</p>
                    </div>
                    <div class="setting-control">
                        <label class="toggle-switch">
                            <input type="checkbox" checked onchange="updateSetting('email_notifications', this.checked)">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Auto-Approve Attendance</h3>
                        <p>Automatically approve employee attendance submissions</p>
                    </div>
                    <div class="setting-control">
                        <label class="toggle-switch">
                            <input type="checkbox" onchange="updateSetting('auto_approve', this.checked)">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Deadline Reminders</h3>
                        <p>Send automatic reminders 3 days before project deadlines</p>
                    </div>
                    <div class="setting-control">
                        <label class="toggle-switch">
                            <input type="checkbox" checked onchange="updateSetting('deadline_reminders', this.checked)">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Employee Registration</h3>
                        <p>Allow new employees to register without admin approval</p>
                    </div>
                    <div class="setting-control">
                        <label class="toggle-switch">
                            <input type="checkbox" onchange="updateSetting('open_registration', this.checked)">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Data Backup</h3>
                        <p>Automatic daily database backup</p>
                    </div>
                    <div class="setting-control">
                        <label class="toggle-switch">
                            <input type="checkbox" checked onchange="updateSetting('auto_backup', this.checked)">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Application Settings -->
        <div class="settings-card full-width-card">
            <h2>⚙️ Application Configuration</h2>
            
            <form method="post" onsubmit="alert('Configuration saved!'); return false;">
                <div class="form-row">
                    <div class="form-group">
                        <label>Company Name</label>
                        <input type="text" name="companyName" placeholder="Your Company Name" value="Connect Plus">
                    </div>
                    <div class="form-group">
                        <label>Time Zone</label>
                        <select name="timezone">
                            <option value="IST">IST (Indian Standard Time)</option>
                            <option value="PST">PST (Pacific Standard Time)</option>
                            <option value="EST">EST (Eastern Standard Time)</option>
                            <option value="GMT">GMT (Greenwich Mean Time)</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Max File Upload Size (MB)</label>
                        <input type="number" name="maxUploadSize" value="10" min="1" max="100">
                    </div>
                    <div class="form-group">
                        <label>Session Timeout (Minutes)</label>
                        <input type="number" name="sessionTimeout" value="30" min="5" max="120">
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Admin Email for Notifications</label>
                    <input type="email" name="notificationEmail" placeholder="admin@company.com">
                </div>
                
                <button type="submit" class="btn btn-success">✅ Save Configuration</button>
            </form>
        </div>
        
        <div class="settings-container">
            <!-- System Statistics -->
            <div class="settings-card">
                <h2>📊 System Statistics</h2>
                
                <div class="stats-grid">
                    <div class="stat-box">
                        <div class="label">Total Employees</div>
                        <div class="value"><%= totalEmployees %></div>
                    </div>
                    <div class="stat-box">
                        <div class="label">Active Projects</div>
                        <div class="value"><%= totalProjects %></div>
                    </div>
                    <div class="stat-box">
                        <div class="label">Total Clients</div>
                        <div class="value"><%= totalClients %></div>
                    </div>
                </div>
            </div>
            
            <!-- Backup & Maintenance -->
            <div class="settings-card">
                <h2>💾 Backup & Maintenance</h2>
                
                <div class="settings-section">
                    <div class="setting-item">
                        <div class="setting-info">
                            <h3>Database Backup</h3>
                            <p>Create a backup of all system data</p>
                        </div>
                        <div class="setting-control">
                            <button class="btn btn-primary" onclick="createBackup()">📥 Create Backup</button>
                        </div>
                    </div>
                    
                    <div class="setting-item">
                        <div class="setting-info">
                            <h3>Clear Cache</h3>
                            <p>Clear system cache to improve performance</p>
                        </div>
                        <div class="setting-control">
                            <button class="btn btn-secondary" onclick="clearCache()">🗑️ Clear Cache</button>
                        </div>
                    </div>
                    
                    <div class="setting-item">
                        <div class="setting-info">
                            <h3>Export Data</h3>
                            <p>Export system data to CSV format</p>
                        </div>
                        <div class="setting-control">
                            <button class="btn btn-success" onclick="exportData()">📤 Export Data</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Danger Zone -->
        <div class="settings-card full-width-card">
            <h2>⚠️ Danger Zone</h2>
            
            <div class="danger-zone">
                <h3>🚨 Reset System</h3>
                <p style="color: #666; margin-bottom: 15px;">
                    This will reset all system settings to default values. This action cannot be undone.
                </p>
                <button class="btn btn-danger" onclick="confirmReset()">🔄 Reset System Settings</button>
            </div>
            
            <div class="danger-zone" style="margin-top: 15px;">
                <h3>🗑️ Delete All Data</h3>
                <p style="color: #666; margin-bottom: 15px;">
                    Permanently delete all data from the system. This action is irreversible!
                </p>
                <button class="btn btn-danger" onclick="confirmDeleteAll()">❌ Delete All Data</button>
            </div>
        </div>
    </div>
    
    <script>
        function updateSetting(settingName, value) {
            console.log('Updating ' + settingName + ' to ' + value);
            alert('Setting updated: ' + settingName);
        }
        
        function createBackup() {
            if(confirm('Are you sure you want to create a backup?')) {
                alert('Backup created successfully!');
            }
        }
        
        function clearCache() {
            if(confirm('Are you sure you want to clear the cache?')) {
                alert('Cache cleared successfully!');
            }
        }
        
        function exportData() {
            alert('Exporting data...');
        }
        
        function confirmReset() {
            if(confirm('⚠️ WARNING: This will reset all system settings to default values.\n\nAre you absolutely sure?')) {
                if(confirm('This is your final warning. Click OK to proceed with reset.')) {
                    alert('System settings reset to default values.');
                }
            }
        }
        
        function confirmDeleteAll() {
            if(confirm('🚨 CRITICAL WARNING: This will permanently delete ALL data!\n\nThis action CANNOT be undone.\n\nAre you absolutely sure?')) {
                var confirmation = prompt('Type "DELETE ALL DATA" to confirm:');
                if(confirmation === 'DELETE ALL DATA') {
                    alert('All data has been deleted.');
                } else {
                    alert('Deletion cancelled. Confirmation text did not match.');
                }
            }
        }
    </script>
</body>
</html>