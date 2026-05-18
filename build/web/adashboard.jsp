<%@page import="database.dbconfig"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="adminheader.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Complete Analytics</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    
    <style>
        body {
            background: #f5f7fa;
            font-family: 'Poppins', Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        
        .main-content {
            margin-left: 10px;
            padding: 20px;
        }
        
        .dashboard-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            margin-bottom: 20px;
        }
        
        .dashboard-header h1 {
            margin: 0 0 10px 0;
            font-size: 32px;
        }
        
        .dashboard-header p {
            margin: 0;
            opacity: 0.9;
        }
        
        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-left: 4px solid #667eea;
            transition: transform 0.3s;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 16px rgba(0,0,0,0.15);
        }
        
        .stat-card h4 {
            color: #666;
            font-size: 13px;
            margin: 0 0 10px 0;
            text-transform: uppercase;
        }
        
        .stat-card .value {
            color: #667eea;
            font-size: 36px;
            font-weight: bold;
            margin: 10px 0;
        }
        
        .stat-card .label {
            color: #999;
            font-size: 12px;
        }
        
        /* Charts Grid */
        .charts-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .chart-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .chart-card h3 {
            color: #333;
            font-size: 18px;
            margin: 0 0 20px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .chart-container {
            position: relative;
            height: 300px;
        }
        
        /* Full Width Chart */
        .full-width-chart {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .full-width-chart h3 {
            color: #333;
            font-size: 18px;
            margin: 0 0 20px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .full-width {
            grid-column: 1/-1;
        }
        
        /* Table Styles */
        .table-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .table-card h3 {
            color: #333;
            font-size: 18px;
            margin: 0 0 15px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .search-box {
            margin-bottom: 15px;
        }
        
        .search-box input {
            width: 300px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th {
            background: #667eea;
            color: white;
            padding: 12px;
            text-align: left;
            font-size: 13px;
        }
        
        td {
            padding: 10px 12px;
            border-bottom: 1px solid #eee;
            font-size: 13px;
        }
        
        tr:nth-child(even) {
            background: #f8f9fa;
        }
        
        tr:hover {
            background: #e9ecef;
        }
        
        .badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: bold;
        }
        
        .badge-success { background: #d4edda; color: #155724; }
        .badge-warning { background: #fff3cd; color: #856404; }
        .badge-info { background: #d1ecf1; color: #0c5460; }
        .badge-danger { background: #f8d7da; color: #721c24; }
        
        .deadline-date {
            color: #dc3545;
            font-weight: bold;
        }
        
        @media(max-width:768px) {
            .main-content {
                margin-left: 0;
            }
            .charts-grid {
                grid-template-columns: 1fr;
            }
            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <%
        // Summary Statistics Variables
        int totalTasks = 0;
        int completedTasks = 0;
        int inProgressTasks = 0;
        int notStartedTasks = 0;
        int onHoldTasks = 0;
        int totalEmployees = 0;
        double avgPercent = 0;
        
        // Chart Data
        StringBuilder employeeNames = new StringBuilder();
        StringBuilder employeeTasks = new StringBuilder();
        StringBuilder dateLabels = new StringBuilder();
        StringBuilder dateProgress = new StringBuilder();
        StringBuilder statusLabels = new StringBuilder("[");
        StringBuilder statusData = new StringBuilder("[");
        StringBuilder monthLabels = new StringBuilder("[");
        StringBuilder monthData = new StringBuilder("[");
        StringBuilder empLabels = new StringBuilder("[");
        StringBuilder empData = new StringBuilder("[");
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = new dbconfig().getConnection();
            
            // Get Time Tracking Summary Stats - FIXED IN PROGRESS COUNT
            Statement st1 = con.createStatement();
            ResultSet rs1 = st1.executeQuery(
                "SELECT COUNT(*) as total, " +
                "SUM(CASE WHEN progress_status='Completed' THEN 1 ELSE 0 END) as comp, " +
                "SUM(CASE WHEN progress_status NOT IN ('Completed', 'On Hold') THEN 1 ELSE 0 END) as prog, " +
                "SUM(CASE WHEN progress_status='Not Started' THEN 1 ELSE 0 END) as notstart, " +
                "SUM(CASE WHEN progress_status='On Hold' THEN 1 ELSE 0 END) as onhold, " +
                "AVG(CAST(REPLACE(completion_percentage, '%', '') AS DECIMAL)) as avg " +
                "FROM projectprogress1"
            );
            
            if(rs1.next()) {
                totalTasks = rs1.getInt("total");
                completedTasks = rs1.getInt("comp");
                inProgressTasks = rs1.getInt("prog");
                notStartedTasks = rs1.getInt("notstart");
                onHoldTasks = rs1.getInt("onhold");
                avgPercent = rs1.getDouble("avg");
            }
            rs1.close();
            st1.close();
            
            // Get total employees from employee table
            Statement stEmp = con.createStatement();
            ResultSet rsEmp = stEmp.executeQuery("SELECT COUNT(*) as emp_count FROM employee");
            if(rsEmp.next()) {
                totalEmployees = rsEmp.getInt("emp_count");
            }
            rsEmp.close();
            stEmp.close();
            
            // Status Distribution for Pie Chart
            Statement st2 = con.createStatement();
            ResultSet rs2 = st2.executeQuery(
                "SELECT progress_status, COUNT(*) as count FROM projectprogress1 GROUP BY progress_status ORDER BY count DESC"
            );
            
            boolean firstStatus = true;
            while(rs2.next()) {
                if(!firstStatus) {
                    statusLabels.append(",");
                    statusData.append(",");
                }
                statusLabels.append("'").append(rs2.getString("progress_status")).append("'");
                statusData.append(rs2.getInt("count"));
                firstStatus = false;
            }
            statusLabels.append("]");
            statusData.append("]");
            rs2.close();
            st2.close();
            
            // Get Employee Task Count
            Statement st3 = con.createStatement();
            ResultSet rs3 = st3.executeQuery(
                "SELECT phono, COUNT(*) as task_count " +
                "FROM projectprogress1 " +
                "GROUP BY phono " +
                "ORDER BY task_count DESC " +
                "LIMIT 10"
            );
            
            boolean firstEmp = true;
            while(rs3.next()) {
                if(!firstEmp) {
                    employeeNames.append(",");
                    employeeTasks.append(",");
                    empLabels.append(",");
                    empData.append(",");
                }
                String phone = rs3.getString("phono");
                int taskCount = rs3.getInt("task_count");
                employeeNames.append("'").append(phone).append("'");
                employeeTasks.append(taskCount);
                empLabels.append("'").append(phone).append("'");
                empData.append(taskCount);
                firstEmp = false;
            }
            if(empLabels.length() > 1) empLabels.append("]");
            if(empData.length() > 1) empData.append("]");
            rs3.close();
            st3.close();
            
            // Get Progress Trend
            Statement st4 = con.createStatement();
            ResultSet rs4 = st4.executeQuery(
                "SELECT update_date, AVG(CAST(REPLACE(completion_percentage, '%', '') AS DECIMAL)) as avg_progress " +
                "FROM projectprogress1 " +
                "WHERE update_date IS NOT NULL " +
                "GROUP BY update_date " +
                "ORDER BY update_date DESC " +
                "LIMIT 7"
            );
            
            boolean firstDate = true;
            while(rs4.next()) {
                if(!firstDate) {
                    dateLabels.append(",");
                    dateProgress.append(",");
                }
                dateLabels.append("'").append(rs4.getString("update_date")).append("'");
                dateProgress.append(String.format("%.1f", rs4.getDouble("avg_progress")));
                firstDate = false;
            }
            rs4.close();
            st4.close();
            
            // Monthly Progress Trend
            Statement st5 = con.createStatement();
            ResultSet rs5 = st5.executeQuery(
                "SELECT DATE_FORMAT(update_date, '%Y-%m') as month, COUNT(*) as count " +
                "FROM projectprogress1 " +
                "WHERE update_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) " +
                "GROUP BY month ORDER BY month"
            );
            
            boolean firstMonth = true;
            while(rs5.next()) {
                if(!firstMonth) {
                    monthLabels.append(",");
                    monthData.append(",");
                }
                monthLabels.append("'").append(rs5.getString("month")).append("'");
                monthData.append(rs5.getInt("count"));
                firstMonth = false;
            }
            monthLabels.append("]");
            monthData.append("]");
            rs5.close();
            st5.close();
            
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    %>
    
    <div class="main-content" style=" width: 4000px; max-width: none;">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <h1>📊 Admin Dashboard - Complete Analytics</h1>
            <p>Comprehensive project progress tracking and performance metrics</p>
        </div>
        
        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <h4>Total Tasks</h4>
                <div class="value"><%= totalTasks %></div>
                <div class="label">Progress updates tracked</div>
            </div>
            <div class="stat-card" style="border-left-color:#28a745;">
                <h4>Completed</h4>
                <div class="value" style="color:#28a745;"><%= completedTasks %></div>
                <div class="label"><%= totalTasks > 0 ? (completedTasks*100/totalTasks) : 0 %>% completion rate</div>
            </div>
            <div class="stat-card" style="border-left-color:#ffc107;">
                <h4>In Progress</h4>
                <div class="value" style="color:#ffc107;"><%= inProgressTasks %></div>
                <div class="label">Active development</div>
            </div>
            <div class="stat-card" style="border-left-color:#dc3545;">
                <h4>On Hold</h4>
                <div class="value" style="color:#dc3545;"><%= onHoldTasks %></div>
                <div class="label">Needs attention</div>
            </div>
            <div class="stat-card" style="border-left-color:#17a2b8;">
                <h4>Avg Progress</h4>
                <div class="value" style="color:#17a2b8;"><%= String.format("%.0f", avgPercent) %>%</div>
                <div class="label">Overall completion</div>
            </div>
            <div class="stat-card" style="border-left-color:#6f42c1;">
                <h4>Total Employees</h4>
                <div class="value" style="color:#6f42c1;"><%= totalEmployees %></div>
                <div class="label">Registered employees</div>
            </div>
        </div>
        
        <!-- All Charts in One Row (3 Columns) -->
        <div class="charts-grid" style="grid-template-columns: repeat(3, 1fr);">
            <!-- Task Status Distribution -->
            <div class="chart-card">
                <h3>📊 Task Status Distribution</h3>
                <div class="chart-container">
                    <canvas id="statusChart"></canvas>
                </div>
            </div>
            
            <!-- Tasks by Employee -->
            <div class="chart-card">
                <h3>👥 Tasks by Employee (Top 10)</h3>
                <div class="chart-container">
                    <canvas id="employeeChart"></canvas>
                </div>
            </div>
            
            <!-- Progress Overview -->
            <div class="chart-card">
                <h3>🎯 Progress Overview</h3>
                <div class="chart-container">
                    <canvas id="overviewDoughnutChart"></canvas>
                </div>
            </div>
        </div>
        
        <!-- Monthly Trend -->
        <div class="full-width-chart">
            <h3>📅 Monthly Progress Trend (Last 6 Months)</h3>
            <div class="chart-container">
                <canvas id="monthlyLineChart"></canvas>
            </div>
        </div>
        
        <!-- Recent Tasks Table -->
        <div class="table-card">
            <h3>⏱️ Recent Time Tracking Updates</h3>
            <div class="search-box">
                <input type="text" id="searchInput1" placeholder="🔍 Search tasks..." onkeyup="searchTable('dataTable1', 'searchInput1')">
            </div>
            
            <table id="dataTable1">
                <thead>
                    <tr>
                        <th>Employee</th>
                        <th>Task</th>
                        <th>Status</th>
                        <th>Progress</th>
                        <th>Date</th>
                        <th>Milestone</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = new dbconfig().getConnection();
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery(
                                "SELECT phono, update_title, progress_status, completion_percentage, update_date, next_milestone " +
                                "FROM projectprogress1 ORDER BY update_date DESC LIMIT 20"
                            );
                            
                            while(rs.next()) {
                                String status = rs.getString("progress_status");
                                String badgeClass = "badge-warning";
                                if(status != null && status.equals("Completed")) badgeClass = "badge-success";
                                else if(status != null && status.equals("In Progress")) badgeClass = "badge-info";
                                else if(status != null && status.equals("On Hold")) badgeClass = "badge-danger";
                    %>
                    <tr>
                        <td><strong><%= rs.getString("phono") %></strong></td>
                        <td><%= rs.getString("update_title") %></td>
                        <td><span class="badge <%= badgeClass %>"><%= status %></span></td>
                        <td><strong><%= rs.getString("completion_percentage") %></strong></td>
                        <td><%= rs.getString("update_date") %></td>
                        <td><%= rs.getString("next_milestone") != null ? rs.getString("next_milestone") : "-" %></td>
                    </tr>
                    <%
                            }
                            con.close();
                        } catch(Exception e) {
                    %>
                    <tr>
                        <td colspan="6" style="text-align:center;color:red;">Error: <%= e.getMessage() %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        
        <!-- Upcoming Project Deadlines Table - ACCEPTED PROJECTS ONLY -->
        <div class="table-card">
            <h3>📅 Upcoming Project Deadlines (Accepted Projects)</h3>
            <div class="search-box">
                <input type="text" id="searchInput2" placeholder="🔍 Search projects..." onkeyup="searchTable('dataTable2', 'searchInput2')">
            </div>
            
            <table id="dataTable2">
                <thead>
                    <tr>
                        <th>Project Title</th>
                        <th>Client Name</th>
                        <th>Email</th>
                        <th>Deadline</th>
                        <th>Days Left</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conT = new dbconfig().getConnection();
                            Statement stT = conT.createStatement();
                            
                            // Get accepted projects with upcoming deadlines
                            ResultSet rsT = stT.executeQuery(
                                "SELECT title, cname, email, deadline, " +
                                "DATEDIFF(deadline, CURDATE()) as days_left " +
                                "FROM requirements " +
                                "WHERE deadline > CURDATE() AND status = 'accepted' " +
                                "ORDER BY deadline ASC"
                            );
                            
                            boolean hasDeadlines = false;
                            while(rsT.next()) {
                                hasDeadlines = true;
                                int daysLeft = rsT.getInt("days_left");
                                String statusBadge = "badge-info";
                                String daysText = daysLeft + " days";
                                
                                if(daysLeft == 0) {
                                    statusBadge = "badge-danger";
                                    daysText = "Today!";
                                } else if(daysLeft == 1) {
                                    statusBadge = "badge-warning";
                                    daysText = "Tomorrow";
                                } else if(daysLeft <= 3) {
                                    statusBadge = "badge-warning";
                                } else if(daysLeft <= 7) {
                                    statusBadge = "badge-info";
                                }
                    %>
                    <tr>
                        <td><strong><%= rsT.getString("title") %></strong></td>
                        <td><%= rsT.getString("cname") %></td>
                        <td><%= rsT.getString("email") %></td>
                        <td class="deadline-date"><%= rsT.getString("deadline") %></td>
                        <td><span class="badge <%= statusBadge %>"><%= daysText %></span></td>
                    </tr>
                    <%
                            }
                            
                            if(!hasDeadlines) {
                    %>
                    <tr>
                        <td colspan="5" style="text-align:center;color:#28a745;padding:30px;">
                            <strong>✅ No upcoming deadlines for accepted projects!</strong>
                        </td>
                    </tr>
                    <%
                            }
                            
                            rsT.close();
                            stT.close();
                            conT.close();
                        } catch(Exception e) {
                    %>
                    <tr>
                        <td colspan="5" style="text-align:center;color:red;">Error: <%= e.getMessage() %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    
    <script>
        // Color Palettes
        const statusColors = [
            '#ffc107', '#17a2b8', '#6f42c1', '#007bff', 
            '#fd7e14', '#20c997', '#e83e8c', '#28a745', '#dc3545'
        ];
        
        const gradientColors = [
            'rgba(102, 126, 234, 0.8)',
            'rgba(118, 75, 162, 0.8)',
            'rgba(240, 147, 251, 0.8)',
            'rgba(245, 87, 108, 0.8)',
            'rgba(79, 172, 254, 0.8)',
            'rgba(0, 242, 254, 0.8)'
        ];
        
        // 1. Task Status Distribution Pie Chart
        const statusCtx = document.getElementById('statusChart').getContext('2d');
        new Chart(statusCtx, {
            type: 'pie',
            data: {
                labels: <%= statusLabels.toString() %>,
                datasets: [{
                    data: <%= statusData.toString() %>,
                    backgroundColor: statusColors,
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'bottom' },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                let label = context.label || '';
                                let value = context.parsed || 0;
                                let total = context.dataset.data.reduce((a, b) => a + b, 0);
                                let percentage = ((value / total) * 100).toFixed(1);
                                return label + ': ' + value + ' (' + percentage + '%)';
                            }
                        }
                    }
                }
            }
        });
        
        // 2. Employee Tasks Bar Chart
        const employeeCtx = document.getElementById('employeeChart').getContext('2d');
        new Chart(employeeCtx, {
            type: 'bar',
            data: {
                labels: [<%= employeeNames.toString() %>],
                datasets: [{
                    label: 'Tasks',
                    data: [<%= employeeTasks.toString() %>],
                    backgroundColor: gradientColors,
                    borderRadius: 5
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });
        
        // 4. Overview Doughnut Chart
        const overviewCtx = document.getElementById('overviewDoughnutChart').getContext('2d');
        new Chart(overviewCtx, {
            type: 'doughnut',
            data: {
                labels: ['Completed', 'In Progress', 'On Hold', 'Not Started'],
                datasets: [{
                    data: [
                        <%= completedTasks %>, 
                        <%= inProgressTasks %>, 
                        <%= onHoldTasks %>, 
                        <%= notStartedTasks %>
                    ],
                    backgroundColor: ['#28a745', '#ffc107', '#dc3545', '#6c757d'],
                    borderWidth: 3,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });
        
        // 5. Monthly Trend Line Chart
        const monthlyCtx = document.getElementById('monthlyLineChart').getContext('2d');
        new Chart(monthlyCtx, {
            type: 'line',
            data: {
                labels: <%= monthLabels.toString() %>,
                datasets: [{
                    label: 'Progress Updates',
                    data: <%= monthData.toString() %>,
                    borderColor: '#667eea',
                    backgroundColor: 'rgba(102, 126, 234, 0.1)',
                    borderWidth: 3,
                    fill: true,
                    tension: 0.4,
                    pointBackgroundColor: '#667eea',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    pointRadius: 5
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: true }
                },
                scales: {
                    y: { 
                        beginAtZero: true,
                        ticks: { stepSize: 1 }
                    }
                }
            }
        });
        
        // Search Function for Tables
        function searchTable(tableId, inputId) {
            var input = document.getElementById(inputId);
            var filter = input.value.toLowerCase();
            var table = document.getElementById(tableId);
            var tr = table.getElementsByTagName("tr");
            
            for (var i = 1; i < tr.length; i++) {
                var td = tr[i].getElementsByTagName("td");
                var found = false;
                
                for (var j = 0; j < td.length; j++) {
                    if (td[j]) {
                        var txtValue = td[j].textContent || td[j].innerText;
                        if (txtValue.toLowerCase().indexOf(filter) > -1) {
                            found = true;
                            break;
                        }
                    }
                }
                
                tr[i].style.display = found ? "" : "none";
            }
        }
    </script>
</body>
</html>
