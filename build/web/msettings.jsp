<%@page import="database.dbconfig"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="mhome.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manager Settings</title>
    
    <style>
        body {
            background: #f5f7fa;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        
        .main-content {
            margin-left: 160px;
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
    // Get manager info from session - try different attribute names
    String managerId = (String) session.getAttribute("mid");
    
    // If mid is null, try other common attribute names
    if(managerId == null || managerId.isEmpty()) {
        managerId = (String) session.getAttribute("managerId");
    }
    if(managerId == null || managerId.isEmpty()) {
        managerId = (String) session.getAttribute("manager_id");
    }
    if(managerId == null || managerId.isEmpty()) {
        managerId = (String) session.getAttribute("id");
    }
    if(managerId == null || managerId.isEmpty()) {
        managerId = (String) session.getAttribute("username");
    }
    
    String managerPassword = "";
    String updateMessage = "";
    String updateType = "";
    
    // Debug output
    out.println("<!-- Debug Info -->");
    out.println("<!-- session.getAttribute('mid') = " + session.getAttribute("mid") + " -->");
    out.println("<!-- session.getAttribute('managerId') = " + session.getAttribute("managerId") + " -->");
    out.println("<!-- session.getAttribute('manager_id') = " + session.getAttribute("manager_id") + " -->");
    out.println("<!-- session.getAttribute('id') = " + session.getAttribute("id") + " -->");
    out.println("<!-- session.getAttribute('username') = " + session.getAttribute("username") + " -->");
    out.println("<!-- Final managerId = " + managerId + " -->");
    
    // Get manager statistics
    int assignedTasks = 0;
    int completedTasks = 0;
    int pendingTasks = 0;
    int totalProjects = 0;
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = new dbconfig().getConnection();
        
        // Get manager details from manager table
        if(managerId != null && !managerId.isEmpty()) {
            try {
                PreparedStatement ps = con.prepareStatement("SELECT pass FROM manager WHERE mid=?");
                ps.setString(1, managerId);
                ResultSet rs = ps.executeQuery();
                
                if(rs.next()) {
                    managerPassword = rs.getString("pass");
                }
            } catch(Exception e) {
                e.printStackTrace();
            }
        }
        
        // Get task statistics
        try {
            Statement st1 = con.createStatement();
            ResultSet rs1 = st1.executeQuery("SELECT COUNT(*) as count FROM assigntask");
            if(rs1.next()) assignedTasks = rs1.getInt("count");
        } catch(Exception e) {}
        
        try {
            Statement st2 = con.createStatement();
            ResultSet rs2 = st2.executeQuery("SELECT COUNT(*) as count FROM projectprogress1 WHERE progress_status='Completed'");
            if(rs2.next()) completedTasks = rs2.getInt("count");
        } catch(Exception e) {}
        
        try {
            Statement st3 = con.createStatement();
            ResultSet rs3 = st3.executeQuery("SELECT COUNT(*) as count FROM projectprogress1 WHERE progress_status='In Progress'");
            if(rs3.next()) pendingTasks = rs3.getInt("count");
        } catch(Exception e) {}
        
        try {
            Statement st4 = con.createStatement();
            ResultSet rs4 = st4.executeQuery("SELECT COUNT(*) as count FROM mpadd1");
            if(rs4.next()) totalProjects = rs4.getInt("count");
        } catch(Exception e) {}
        
        con.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
    
    // Handle form submissions
    if(request.getMethod().equalsIgnoreCase("POST")) {
        String action = request.getParameter("action");
        
        if("updateProfile".equals(action)) {
            String newManagerId = request.getParameter("managerId");
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = new dbconfig().getConnection();
                
                Statement st = con.createStatement();
                int updated = st.executeUpdate("UPDATE manager SET mid='" + newManagerId + "' WHERE mid='" + managerId + "'");
                
                if(updated > 0) {
                    session.setAttribute("mid", newManagerId);
                    managerId = newManagerId;
                    updateMessage = "Manager ID updated successfully!";
                    updateType = "success";
                } else {
                    updateMessage = "Failed to update Manager ID.";
                    updateType = "danger";
                }
                
                con.close();
            } catch(Exception e) {
                updateMessage = "Error: " + e.getMessage();
                updateType = "danger";
            }
        }
    }
%>
    
    <div class="main-content" style="width: 1100px;max-width: none;">
        <!-- Settings Header -->
        <div class="settings-header">
            <h1>⚙️ Manager Settings</h1>
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
                        <label>Manager ID</label>
                        <input type="text" name="managerId" value="<%= managerId != null ? managerId : "" %>" placeholder="Manager ID" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Role</label>
                        <input type="text" value="Manager" disabled style="background: #f8f9fa;">
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
                        <div class="label">Assigned Tasks</div>
                        <div class="value"><%= assignedTasks %></div>
                    </div>
                    <div class="stat-box">
                        <div class="label">Completed Tasks</div>
                        <div class="value"><%= completedTasks %></div>
                    </div>
                    <div class="stat-box">
                        <div class="label">Pending Tasks</div>
                        <div class="value"><%= pendingTasks %></div>
                    </div>
                    <div class="stat-box">
                        <div class="label">Total Projects</div>
                        <div class="value"><%= totalProjects %></div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Notification Preferences -->
        <div class="settings-card full-width-card">
            <h2>🔔 Notification Preferences</h2>
            
            <div class="settings-section">
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Task Assignment Notifications</h3>
                        <p>Get notified when you assign a new task to team members</p>
                    </div>
                    <div class="setting-control">
                        <label class="toggle-switch">
                            <input type="checkbox" checked onchange="updateSetting('task_assignment', this.checked)">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Task Completion Alerts</h3>
                        <p>Receive alerts when assigned tasks are completed</p>
                    </div>
                    <div class="setting-control">
                        <label class="toggle-switch">
                            <input type="checkbox" checked onchange="updateSetting('task_completion', this.checked)">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Progress Update Notifications</h3>
                        <p>Get notified when team members update task progress</p>
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
                        <h3>Deadline Reminders</h3>
                        <p>Receive reminders 2 days before task deadlines</p>
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
            </div>
        </div>
        
        <!-- Task Management Settings -->
        <div class="settings-card full-width-card">
            <h2>📋 Task Management Settings</h2>
            
            <div class="settings-section">
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Auto-assign Tasks</h3>
                        <p>Automatically distribute tasks based on workload</p>
                    </div>
                    <div class="setting-control">
                        <label class="toggle-switch">
                            <input type="checkbox" onchange="updateSetting('auto_assign', this.checked)">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Task Priority Alerts</h3>
                        <p>Highlight high-priority tasks in the dashboard</p>
                    </div>
                    <div class="setting-control">
                        <label class="toggle-switch">
                            <input type="checkbox" checked onchange="updateSetting('priority_alerts', this.checked)">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Show Completed Tasks</h3>
                        <p>Display completed tasks in assigned list for 7 days</p>
                    </div>
                    <div class="setting-control">
                        <label class="toggle-switch">
                            <input type="checkbox" checked onchange="updateSetting('show_completed', this.checked)">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="settings-container">
            <!-- Display Preferences -->
            <div class="settings-card">
                <h2>🎨 Display Preferences</h2>
                
                <form method="post" onsubmit="alert('Display preferences saved!'); return false;">
                    <div class="form-group">
                        <label>Default Dashboard View</label>
                        <select name="defaultView">
                            <option value="overview">Overview</option>
                            <option value="tasks">Tasks</option>
                            <option value="projects">Projects</option>
                            <option value="progress">Progress</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>Items Per Page</label>
                        <select name="itemsPerPage">
                            <option value="10">10</option>
                            <option value="25" selected>25</option>
                            <option value="50">50</option>
                            <option value="100">100</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>Date Format</label>
                        <select name="dateFormat">
                            <option value="dd/mm/yyyy">DD/MM/YYYY</option>
                            <option value="mm/dd/yyyy">MM/DD/YYYY</option>
                            <option value="yyyy-mm-dd">YYYY-MM-DD</option>
                        </select>
                    </div>
                    
                    <button type="submit" class="btn btn-success">✅ Save Preferences</button>
                </form>
            </div>
            
            <!-- Account Information -->
            <div class="settings-card">
                <h2>ℹ️ Account Information</h2>
                
                <div class="info-card">
                    <h3>Manager Details</h3>
                    <p><strong>Manager ID:</strong> <%= managerId %></p>
                    <p><strong>Role:</strong> Manager</p>
                    <p><strong>Access Level:</strong> Full Access</p>
                </div>
                
                <div style="margin-top: 15px; padding: 15px; background: #fff3cd; border-left: 4px solid #ffc107; border-radius: 5px;">
                    <p style="margin: 0; color: #856404; font-size: 14px;">
                        <strong>Note:</strong> For password changes or additional profile updates, please contact the administrator.
                    </p>
                </div>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div class="settings-card full-width-card">
            <h2>⚡ Quick Actions</h2>
            
            <div class="info-card">
                <h3>💡 Tip</h3>
                <p>Use these quick actions to manage your work efficiently. Export reports for analysis or clear completed tasks to declutter your view.</p>
            </div>
            
            <div class="settings-section">
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Export My Tasks</h3>
                        <p>Download all your assigned tasks as CSV</p>
                    </div>
                    <div class="setting-control">
                        <button class="btn btn-primary" onclick="exportTasks()">📥 Export Tasks</button>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Export Progress Report</h3>
                        <p>Generate and download progress report for all tasks</p>
                    </div>
                    <div class="setting-control">
                        <button class="btn btn-success" onclick="exportProgress()">📊 Export Report</button>
                    </div>
                </div>
                
                <div class="setting-item">
                    <div class="setting-info">
                        <h3>Clear Completed Tasks</h3>
                        <p>Remove all completed tasks older than 30 days from view</p>
                    </div>
                    <div class="setting-control">
                        <button class="btn btn-secondary" onclick="clearCompleted()">🗑️ Clear Old Tasks</button>
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
                'task_assignment': 'Task assignment notifications ' + (value ? 'enabled' : 'disabled'),
                'task_completion': 'Task completion alerts ' + (value ? 'enabled' : 'disabled'),
                'progress_updates': 'Progress update notifications ' + (value ? 'enabled' : 'disabled'),
                'deadline_reminders': 'Deadline reminders ' + (value ? 'enabled' : 'disabled'),
                'email_notifications': 'Email notifications ' + (value ? 'enabled' : 'disabled'),
                'auto_assign': 'Auto-assign tasks ' + (value ? 'enabled' : 'disabled'),
                'priority_alerts': 'Priority alerts ' + (value ? 'enabled' : 'disabled'),
                'show_completed': 'Show completed tasks ' + (value ? 'enabled' : 'disabled')
            };
            
            alert(messages[settingName] || 'Setting updated');
        }
        
        function exportTasks() {
            if(confirm('Export all your assigned tasks to CSV?')) {
                alert('Exporting tasks...');
                // Add actual export logic here
                // window.location.href = 'exportManagerTasks.jsp';
            }
        }
        
        function exportProgress() {
            if(confirm('Generate progress report for all your tasks?')) {
                alert('Generating progress report...');
                // Add actual export logic here
                // window.location.href = 'exportProgressReport.jsp';
            }
        }
        
        function clearCompleted() {
            if(confirm('Are you sure you want to clear all completed tasks older than 30 days?\n\nThis will only affect your view, not delete the records.')) {
                alert('Completed tasks cleared from view!');
                // Add actual clear logic here
            }
        }
    </script>
</body>
</html>