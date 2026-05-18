<%@page import="database.dbconfig"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="emphome.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Dashboard</title>
    
    <style>
        body {
            background: #f5f7fa;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }
        
        .main-content {
            margin-left: 125px;
            margin-right: 10px;
            padding: 20px;
            max-width: 800px;
        }
        
        .dashboard-header {
            background: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 15px;
        }
        
        .dashboard-header h1 {
            color: #333;
            margin: 0;
            font-size: 24px;
        }
        
        .dashboard-header .welcome-text {
            color: #666;
            font-size: 13px;
            margin-top: 5px;
        }
        
        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .stat-card {
            background: white;
            padding: 18px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            position: relative;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
        }
        
        .stat-card.blue::before { background: #007bff; }
        .stat-card.green::before { background: #28a745; }
        .stat-card.orange::before { background: #fd7e14; }
        .stat-card.red::before { background: #dc3545; }
        .stat-card.purple::before { background: #6f42c1; }
        
        .stat-icon {
            font-size: 32px;
            margin-bottom: 8px;
        }
        
        .stat-card h3 {
            color: #666;
            font-size: 12px;
            margin: 0 0 8px 0;
            text-transform: uppercase;
            font-weight: 600;
        }
        
        .stat-value {
            font-size: 28px;
            font-weight: bold;
            margin: 8px 0;
        }
        
        .stat-card.blue .stat-value { color: #007bff; }
        .stat-card.green .stat-value { color: #28a745; }
        .stat-card.orange .stat-value { color: #fd7e14; }
        .stat-card.red .stat-value { color: #dc3545; }
        .stat-card.purple .stat-value { color: #6f42c1; }
        
        .stat-description {
            color: #999;
            font-size: 11px;
            margin-top: 8px;
        }
        
        .stat-trend {
            display: inline-block;
            padding: 2px 6px;
            border-radius: 12px;
            font-size: 10px;
            font-weight: bold;
            margin-top: 8px;
        }
        
        .trend-up {
            background: #d4edda;
            color: #155724;
        }
        
        .trend-down {
            background: #f8d7da;
            color: #721c24;
        }
        
        /* Section Card */
        .section-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 15px;
        }
        
        .section-title {
            font-size: 16px;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .tasks-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .tasks-table thead {
            background: #f8f9fa;
        }
        
        .tasks-table th {
            padding: 10px 8px;
            text-align: left;
            font-weight: 600;
            color: #495057;
            font-size: 12px;
            border-bottom: 2px solid #dee2e6;
        }
        
        .tasks-table td {
            padding: 10px 8px;
            border-bottom: 1px solid #f0f0f0;
            font-size: 13px;
        }
        
        .tasks-table tbody tr:hover {
            background: #f8f9fa;
        }
        
        .status-badge {
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }
        
        .status-completed {
            background: #d4edda;
            color: #155724;
        }
        
        .status-progress {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-pending {
            background: #f8d7da;
            color: #721c24;
        }
        
        .status-assigned {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .no-data {
            text-align: center;
            padding: 25px;
            color: #999;
        }
        
        .progress-bar-container {
            background: #e9ecef;
            border-radius: 10px;
            height: 6px;
            overflow: hidden;
            margin-top: 5px;
        }
        
        .progress-bar {
            height: 100%;
            background: linear-gradient(90deg, #007bff, #0056b3);
            border-radius: 10px;
            transition: width 0.3s;
        }
        
        .two-column {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .compact-section {
            max-height: 400px;
            overflow-y: auto;
        }
        
        .quick-actions {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        
        .quick-action-btn {
            padding: 12px;
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 6px;
            text-align: center;
            text-decoration: none;
            color: #495057;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .quick-action-btn:hover {
            background: #007bff;
            color: white;
            border-color: #007bff;
            transform: translateY(-2px);
        }
        
        .activity-item {
            padding: 12px;
            border-left: 3px solid #007bff;
            margin-bottom: 10px;
            background: #f8f9fa;
            border-radius: 4px;
        }
        
        .activity-time {
            font-size: 11px;
            color: #999;
        }
        
        /* Responsive */
        @media (max-width: 1200px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .two-column {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 10px;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <%
        // Get employee info from session
        String employeePhone = (String) session.getAttribute("phono");
        String employeeName = "";
        String empMid = (String) session.getAttribute("mid");
        
        // Stats variables
        int totalProjects = 0;
        int ongoingProjects = 0;
        int completedProjects = 0;
        int myAssignedTasks = 0;
        int dueThisWeek = 0;
        
        // Get current date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String today = sdf.format(new Date());
        
        // Calculate week end date
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, 7);
        String weekEnd = sdf.format(cal.getTime());
        
        Connection con = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = new dbconfig().getConnection();
            
            // Get employee name
            if(employeePhone != null && !employeePhone.isEmpty()) {
                try {
                    PreparedStatement ps = con.prepareStatement("SELECT name FROM empreg WHERE phono=?");
                    ps.setString(1, employeePhone);
                    ResultSet rs = ps.executeQuery();
                    if(rs.next()) {
                        employeeName = rs.getString("name");
                    }
                    rs.close();
                    ps.close();
                } catch(Exception e) {
                    employeeName = "Employee";
                }
            }
            
            // Get project statistics
            if(empMid != null) {
                try {
                    PreparedStatement psTotal = con.prepareStatement("SELECT COUNT(*) as total FROM mpadd1 WHERE mid=?");
                    psTotal.setString(1, empMid);
                    ResultSet rsTotal = psTotal.executeQuery();
                    if(rsTotal.next()) totalProjects = rsTotal.getInt("total");
                    rsTotal.close();
                    psTotal.close();
                    
                    PreparedStatement psOngoing = con.prepareStatement("SELECT COUNT(*) as total FROM mpadd1 WHERE mid=? AND (status='Ongoing' OR status IS NULL OR status='')");
                    psOngoing.setString(1, empMid);
                    ResultSet rsOngoing = psOngoing.executeQuery();
                    if(rsOngoing.next()) ongoingProjects = rsOngoing.getInt("total");
                    rsOngoing.close();
                    psOngoing.close();
                    
                    PreparedStatement psCompleted = con.prepareStatement("SELECT COUNT(*) as total FROM mpadd1 WHERE mid=? AND status='Completed'");
                    psCompleted.setString(1, empMid);
                    ResultSet rsCompleted = psCompleted.executeQuery();
                    if(rsCompleted.next()) completedProjects = rsCompleted.getInt("total");
                    rsCompleted.close();
                    psCompleted.close();
                } catch(Exception e) {
                    e.printStackTrace();
                }
            }
            
            // Get total assigned tasks for this employee
            try {
                PreparedStatement ps1 = con.prepareStatement("SELECT COUNT(*) as count FROM assigntask WHERE phono=?");
                ps1.setString(1, employeePhone);
                ResultSet rs1 = ps1.executeQuery();
                if(rs1.next()) myAssignedTasks = rs1.getInt("count");
                rs1.close();
                ps1.close();
            } catch(Exception e) {
                e.printStackTrace();
            }
            
            // Get tasks due this week
            try {
                PreparedStatement ps5 = con.prepareStatement("SELECT COUNT(*) as count FROM assigntask WHERE phono=? AND enddate BETWEEN ? AND ?");
                ps5.setString(1, employeePhone);
                ps5.setString(2, today);
                ps5.setString(3, weekEnd);
                ResultSet rs5 = ps5.executeQuery();
                if(rs5.next()) dueThisWeek = rs5.getInt("count");
                rs5.close();
                ps5.close();
            } catch(Exception e) {
                e.printStackTrace();
            }
    %>
    
    <div class="main-content" style="width:1200px;max-width: none;padding: 20px;">

        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <h1>👋 Welcome, <%= employeeName %>!</h1>
            <div class="welcome-text">Here's your work overview for today</div>
        </div>
        
        <!-- Stats Cards -->
        <div class="stats-grid">
            <!-- Total Projects -->
            <div class="stat-card blue">
                <div class="stat-icon">📁</div>
                <h3>Total Projects</h3>
                <div class="stat-value"><%= totalProjects %></div>
                <div class="stat-description">All assigned projects</div>
            </div>
            
            <!-- Ongoing Projects -->
            <div class="stat-card orange">
                <div class="stat-icon">⏳</div>
                <h3>Ongoing Projects</h3>
                <div class="stat-value"><%= ongoingProjects %></div>
                <div class="stat-description">Currently in progress</div>
            </div>
            
            <!-- Completed Projects -->
            <div class="stat-card green">
                <div class="stat-icon">✅</div>
                <h3>Completed Projects</h3>
                <div class="stat-value"><%= completedProjects %></div>
                <div class="stat-description">Successfully finished</div>
                <% if(totalProjects > 0) { 
                    int completionRate = (completedProjects * 100) / totalProjects;
                %>
                    <div class="stat-trend trend-up">
                        <%= completionRate %>% completion rate
                    </div>
                <% } %>
            </div>
            
            <!-- Due This Week -->
            <div class="stat-card red">
                <div class="stat-icon">📅</div>
                <h3>Due This Week</h3>
                <div class="stat-value"><%= dueThisWeek %></div>
                <div class="stat-description">Tasks due in 7 days</div>
            </div>
        </div>
        
        <!-- My Assigned Projects Section -->
        <div class="section-card">
            <div class="section-title" style="display: flex; justify-content: space-between; align-items: center;">
                <span>🗂️ My Assigned Projects</span>
                <a href="myprojects.jsp" style="font-size: 14px; color: #007bff; text-decoration: none; font-weight: 500;">View All →</a>
            </div>
            
            <div class="compact-section">
                <table class="tasks-table">
                    <thead>
                        <tr>
                            <th>Project ID</th>
                            <th>Technology</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        if(empMid != null) {
                            PreparedStatement psProjects = con.prepareStatement("SELECT * FROM mpadd1 WHERE mid=? ORDER BY enddate DESC LIMIT 5");
                            psProjects.setString(1, empMid);
                            ResultSet rsProjects = psProjects.executeQuery();
                            
                            boolean hasProjects = false;
                            while(rsProjects.next()) {
                                hasProjects = true;
                                int projectId = rsProjects.getInt("project_id");
                                String technology = rsProjects.getString("technology");
                                String startdate = rsProjects.getString("startdate");
                                String enddate = rsProjects.getString("enddate");
                                String status = rsProjects.getString("status");
                                if(status == null || status.trim().isEmpty()) status = "Ongoing";
                                
                                String statusClass = status.equalsIgnoreCase("Completed") ? "status-completed" : "status-progress";
                    %>
                        <tr>
                            <td><strong>#<%= projectId %></strong></td>
                            <td><span class="status-badge status-assigned"><%= technology %></span></td>
                            <td><%= startdate %></td>
                            <td><%= enddate %></td>
                            <td><span class="status-badge <%= statusClass %>"><%= status %></span></td>
                        </tr>
                    <%
                            }
                            
                            if(!hasProjects) {
                    %>
                        <tr>
                            <td colspan="7" class="no-data">No projects assigned yet</td>
                        </tr>
                    <%
                            }
                            rsProjects.close();
                            psProjects.close();
                        } else {
                    %>
                        <tr>
                            <td colspan="7" class="no-data">Session expired. Please login again.</td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- Two Column Layout for Quick Actions and Recent Progress -->
        <div class="two-column">
            <!-- Quick Actions -->
            <div class="section-card">
                <div class="section-title">⚡ Quick Actions</div>
                <div class="quick-actions">
                    <a href="emptask.jsp" class="quick-action-btn">📋 My Tasks</a>
                    <a href="empproject.jsp" class="quick-action-btn">🔄 Update Progress</a>
                    <a href="alllogin.jsp" class="quick-action-btn">🏖️ Leave Request</a>
                </div>
            </div>
            
            <!-- Recent Progress Updates -->
            <div class="section-card">
                <div class="section-title">🔄 Recent Progress Updates</div>
                <div class="compact-section" style="max-height: 200px;">
                <%
                    PreparedStatement psProgress = con.prepareStatement("SELECT * FROM projectprogress1 WHERE phono=? ORDER BY update_date DESC LIMIT 3");
                    psProgress.setString(1, employeePhone);
                    ResultSet rsProgress = psProgress.executeQuery();
                    
                    boolean hasProgress = false;
                    while(rsProgress.next()) {
                        hasProgress = true;
                        String updateTitle = rsProgress.getString("update_title");
                        String progressStatus = rsProgress.getString("progress_status");
                        String updateDate = rsProgress.getString("update_date");
                        String completion = rsProgress.getString("completion_percentage");
                        
                        String percentText = "0";
                        if(completion != null && completion.contains("%")) {
                            percentText = completion.replaceAll("[^0-9]", "");
                        }
                %>
                    <div class="activity-item">
                        <div><strong><%= updateTitle %></strong></div>
                        <div style="font-size: 12px; color: #666; margin: 5px 0;">
                            Status: <%= progressStatus %>
                        </div>
                        <div class="progress-bar-container">
                            <div class="progress-bar" style="width: <%= percentText %>%;"></div>
                        </div>
                        <div class="activity-time"><%= updateDate %></div>
                    </div>
                <%
                    }
                    
                    if(!hasProgress) {
                %>
                    <div class="no-data" style="padding: 20px;">
                        No progress updates yet
                    </div>
                <%
                    }
                    rsProgress.close();
                    psProgress.close();
                %>
                </div>
            </div>
        </div>
    </div>
    
    <%
        } catch(Exception e) {
            e.printStackTrace();
    %>
        <div class="main-content">
            <div class="section-card">
                <div style="color: #dc3545; text-align: center; padding: 20px;">
                    <h3>⚠️ Error Loading Dashboard</h3>
                    <p><%= e.getMessage() %></p>
                </div>
            </div>
        </div>
    <%
        } finally {
            if(con != null) {
                try {
                    con.close();
                } catch(Exception e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>
