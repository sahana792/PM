<%@page import="java.sql.*"%>
<%@page import="database.dbconfig"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="adminheader.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Progress Analytics Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { font-family:'Poppins',sans-serif; background:#f5f6fa; margin:0; padding:0;}
        .container { width:95%; max-width:1600px; margin:30px auto; padding:20px; }
        
        .page-header { 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
            color:white; 
            padding:30px; 
            border-radius:10px; 
            margin-bottom:30px;
            box-shadow:0 4px 12px rgba(0,0,0,0.15);
        }
        .page-header h1 { margin:0 0 10px 0; font-size:32px; }
        .page-header p { margin:0; opacity:0.9; }

        .stats-grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(200px,1fr)); gap:20px; margin-bottom:30px; }
        .stat-card { 
            background:white; 
            padding:25px; 
            border-radius:10px; 
            box-shadow:0 2px 8px rgba(0,0,0,0.1);
            border-left:4px solid #667eea;
            transition:transform 0.3s;
        }
        .stat-card:hover { transform:translateY(-5px); box-shadow:0 4px 16px rgba(0,0,0,0.15); }
        .stat-card h3 { color:#666; font-size:13px; margin:0 0 10px 0; text-transform:uppercase; }
        .stat-card .number { font-size:36px; font-weight:bold; color:#667eea; margin:10px 0; }
        .stat-card .label { color:#999; font-size:12px; }

        .charts-grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(450px,1fr)); gap:25px; margin-bottom:30px; }
        .chart-card { 
            background:white; 
            padding:25px; 
            border-radius:10px; 
            box-shadow:0 2px 8px rgba(0,0,0,0.1);
        }
        .chart-card h2 { 
            color:#333; 
            font-size:18px; 
            margin:0 0 20px 0; 
            padding-bottom:10px; 
            border-bottom:2px solid #f0f0f0;
        }
        .chart-container { position:relative; height:300px; }
        .full-width { grid-column:1/-1; }
        
        .filter-section {
            background:white;
            padding:20px;
            border-radius:10px;
            margin-bottom:20px;
            box-shadow:0 2px 8px rgba(0,0,0,0.1);
        }
        .filter-section h3 {
            margin:0 0 15px 0;
            color:#333;
        }
        .filter-controls {
            display:flex;
            gap:15px;
            flex-wrap:wrap;
        }
        .filter-item {
            flex:1;
            min-width:200px;
        }
        .filter-item label {
            display:block;
            font-weight:600;
            margin-bottom:5px;
            color:#495057;
            font-size:13px;
        }
        .filter-item select, .filter-item input {
            width:100%;
            padding:8px;
            border:1px solid #ced4da;
            border-radius:5px;
            font-family:'Poppins',sans-serif;
        }
        
        @media(max-width:768px){ 
            .charts-grid { grid-template-columns:1fr; }
            .stat-card .number { font-size:28px; }
        }
    </style>
</head>

<body>
<div class="container">
    <div class="page-header">
        <h1>📊 Progress Report</h1>
        <p>Comprehensive project progress tracking and performance metrics</p>
    </div>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = new dbconfig().getConnection();

        // Summary Statistics
        PreparedStatement psSummary = con.prepareStatement(
            "SELECT COUNT(*) AS total, " +
            "SUM(CASE WHEN progress_status='Completed' THEN 1 ELSE 0 END) AS completed, " +
            "SUM(CASE WHEN progress_status='On Hold' THEN 1 ELSE 0 END) AS on_hold, " +
            "SUM(CASE WHEN progress_status LIKE '%Progress%' THEN 1 ELSE 0 END) AS in_progress, " +
            "COUNT(DISTINCT phono) AS total_employees " +
            "FROM projectprogress1"
        );
        ResultSet rsSummary = psSummary.executeQuery();
        
        int totalUpdates = 0, completed = 0, onHold = 0, inProgress = 0, totalEmployees = 0;
        if(rsSummary.next()){
            totalUpdates = rsSummary.getInt("total");
            completed = rsSummary.getInt("completed");
            onHold = rsSummary.getInt("on_hold");
            inProgress = rsSummary.getInt("in_progress");
            totalEmployees = rsSummary.getInt("total_employees");
        }
        rsSummary.close();
        psSummary.close();

        // Status Distribution
        PreparedStatement psStatus = con.prepareStatement(
            "SELECT progress_status, COUNT(*) as count FROM projectprogress1 GROUP BY progress_status ORDER BY count DESC"
        );
        ResultSet rsStatus = psStatus.executeQuery();
        
        StringBuilder statusLabels = new StringBuilder("[");
        StringBuilder statusData = new StringBuilder("[");
        boolean firstStatus = true;
        
        while(rsStatus.next()){
            if(!firstStatus){ statusLabels.append(","); statusData.append(","); }
            statusLabels.append("'").append(rsStatus.getString("progress_status")).append("'");
            statusData.append(rsStatus.getInt("count"));
            firstStatus = false;
        }
        statusLabels.append("]");
        statusData.append("]");
        rsStatus.close();
        psStatus.close();

        // Completion Percentage Distribution
        PreparedStatement psCompletion = con.prepareStatement(
            "SELECT " +
            "SUM(CASE WHEN completion_percentage LIKE '0%' THEN 1 ELSE 0 END) AS range_0, " +
            "SUM(CASE WHEN completion_percentage LIKE '10%' THEN 1 ELSE 0 END) AS range_10, " +
            "SUM(CASE WHEN completion_percentage LIKE '20%' THEN 1 ELSE 0 END) AS range_20, " +
            "SUM(CASE WHEN completion_percentage LIKE '30%' THEN 1 ELSE 0 END) AS range_30, " +
            "SUM(CASE WHEN completion_percentage LIKE '40%' THEN 1 ELSE 0 END) AS range_40, " +
            "SUM(CASE WHEN completion_percentage LIKE '70%' THEN 1 ELSE 0 END) AS range_70, " +
            "SUM(CASE WHEN completion_percentage LIKE '85%' THEN 1 ELSE 0 END) AS range_85, " +
            "SUM(CASE WHEN completion_percentage LIKE '95%' THEN 1 ELSE 0 END) AS range_95, " +
            "SUM(CASE WHEN completion_percentage LIKE '100%' THEN 1 ELSE 0 END) AS range_100 " +
            "FROM projectprogress1"
        );
        ResultSet rsCompletion = psCompletion.executeQuery();
        
        String completionData = "[0,0,0,0,0,0,0,0,0]";
        if(rsCompletion.next()){
            completionData = "[" + 
                rsCompletion.getInt("range_0") + "," +
                rsCompletion.getInt("range_10") + "," +
                rsCompletion.getInt("range_20") + "," +
                rsCompletion.getInt("range_30") + "," +
                rsCompletion.getInt("range_40") + "," +
                rsCompletion.getInt("range_70") + "," +
                rsCompletion.getInt("range_85") + "," +
                rsCompletion.getInt("range_95") + "," +
                rsCompletion.getInt("range_100") +
            "]";
        }
        rsCompletion.close();
        psCompletion.close();

        // Monthly Progress Trend (Last 6 months)
        PreparedStatement psMonthly = con.prepareStatement(
            "SELECT DATE_FORMAT(update_date, '%Y-%m') as month, COUNT(*) as count " +
            "FROM projectprogress1 " +
            "WHERE update_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) " +
            "GROUP BY month ORDER BY month"
        );
        ResultSet rsMonthly = psMonthly.executeQuery();
        
        StringBuilder monthLabels = new StringBuilder("[");
        StringBuilder monthData = new StringBuilder("[");
        boolean firstMonth = true;
        
        while(rsMonthly.next()){
            if(!firstMonth){ monthLabels.append(","); monthData.append(","); }
            monthLabels.append("'").append(rsMonthly.getString("month")).append("'");
            monthData.append(rsMonthly.getInt("count"));
            firstMonth = false;
        }
        monthLabels.append("]");
        monthData.append("]");
        rsMonthly.close();
        psMonthly.close();

        // Top Employees by Updates
        PreparedStatement psEmployees = con.prepareStatement(
            "SELECT phono, COUNT(*) as update_count " +
            "FROM projectprogress1 " +
            "GROUP BY phono " +
            "ORDER BY update_count DESC LIMIT 10"
        );
        ResultSet rsEmployees = psEmployees.executeQuery();
        
        StringBuilder empLabels = new StringBuilder("[");
        StringBuilder empData = new StringBuilder("[");
        boolean firstEmp = true;
        
        while(rsEmployees.next()){
            if(!firstEmp){ empLabels.append(","); empData.append(","); }
            empLabels.append("'").append(rsEmployees.getString("phono")).append("'");
            empData.append(rsEmployees.getInt("update_count"));
            firstEmp = false;
        }
        empLabels.append("]");
        empData.append("]");
        rsEmployees.close();
        psEmployees.close();
%>

    <!-- Statistics Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <h3>Total Updates</h3>
            <div class="number"><%= totalUpdates %></div>
            <div class="label">Progress updates tracked</div>
        </div>
        <div class="stat-card" style="border-left-color:#28a745;">
            <h3>Completed</h3>
            <div class="number" style="color:#28a745;"><%= completed %></div>
            <div class="label"><%= totalUpdates > 0 ? (completed*100/totalUpdates) : 0 %>% completion rate</div>
        </div>
        <div class="stat-card" style="border-left-color:#ffc107;">
            <h3>In Progress</h3>
            <div class="number" style="color:#ffc107;"><%= inProgress %></div>
            <div class="label">Active development</div>
        </div>
        <div class="stat-card" style="border-left-color:#dc3545;">
            <h3>On Hold</h3>
            <div class="number" style="color:#dc3545;"><%= onHold %></div>
            <div class="label">Needs attention</div>
        </div>
        <div class="stat-card" style="border-left-color:#17a2b8;">
            <h3>Active Employees</h3>
            <div class="number" style="color:#17a2b8;"><%= totalEmployees %></div>
            <div class="label">Contributing to projects</div>
        </div>
    </div>

    <!-- Charts Section -->
    <div class="charts-grid">
        <!-- Status Distribution Pie Chart -->
        <div class="chart-card">
            <h2>📊 Status Distribution</h2>
            <div class="chart-container">
                <canvas id="statusPieChart"></canvas>
            </div>
        </div>

        <!-- Completion Percentage Bar Chart -->
        <div class="chart-card">
            <h2>📈 Completion Percentage Distribution</h2>
            <div class="chart-container">
                <canvas id="completionBarChart"></canvas>
            </div>
        </div>

        <!-- Monthly Trend Line Chart -->
        <div class="chart-card full-width">
            <h2>📅 Monthly Progress Trend (Last 6 Months)</h2>
            <div class="chart-container">
                <canvas id="monthlyLineChart"></canvas>
            </div>
        </div>

        <!-- Top Employees Horizontal Bar Chart -->
        <div class="chart-card full-width">
            <h2>👥 Top 10 Employees by Update Count</h2>
            <div class="chart-container">
                <canvas id="employeesBarChart"></canvas>
            </div>
        </div>

        <!-- Status Overview Doughnut Chart -->
        <div class="chart-card">
            <h2>🎯 Overall Progress Overview</h2>
            <div class="chart-container">
                <canvas id="overviewDoughnutChart"></canvas>
            </div>
        </div>

        <!-- Completion Rate Polar Chart -->
        <div class="chart-card">
            <h2>⭐ Completion Rate Analysis</h2>
            <div class="chart-container">
                <canvas id="polarChart"></canvas>
            </div>
        </div>
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

    // 1. Status Distribution Pie Chart
    const statusCtx = document.getElementById('statusPieChart').getContext('2d');
    new Chart(statusCtx, {
        type: 'pie',
        data: {
            labels: <%= statusLabels %>,
            datasets: [{
                data: <%= statusData %>,
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

    // 2. Completion Percentage Bar Chart
    const completionCtx = document.getElementById('completionBarChart').getContext('2d');
    new Chart(completionCtx, {
        type: 'bar',
        data: {
            labels: ['0%', '10%', '20%', '30%', '40%', '70%', '85%', '95%', '100%'],
            datasets: [{
                label: 'Number of Projects',
                data: <%= completionData %>,
                backgroundColor: [
                    '#dc3545', '#e74c3c', '#e67e22', '#f39c12',
                    '#f1c40f', '#3498db', '#2ecc71', '#27ae60', '#28a745'
                ],
                borderWidth: 1,
                borderColor: '#fff'
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
                    ticks: { stepSize: 1 }
                }
            }
        }
    });

    // 3. Monthly Trend Line Chart
    const monthlyCtx = document.getElementById('monthlyLineChart').getContext('2d');
    new Chart(monthlyCtx, {
        type: 'line',
        data: {
            labels: <%= monthLabels %>,
            datasets: [{
                label: 'Progress Updates',
                data: <%= monthData %>,
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

    // 4. Top Employees Horizontal Bar Chart
    const employeesCtx = document.getElementById('employeesBarChart').getContext('2d');
    new Chart(employeesCtx, {
        type: 'bar',
        data: {
            labels: <%= empLabels %>,
            datasets: [{
                label: 'Update Count',
                data: <%= empData %>,
                backgroundColor: gradientColors,
                borderWidth: 1,
                borderColor: '#fff'
            }]
        },
        options: {
            indexAxis: 'y',
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false }
            },
            scales: {
                x: { 
                    beginAtZero: true,
                    ticks: { stepSize: 1 }
                }
            }
        }
    });

    // 5. Overview Doughnut Chart
    const overviewCtx = document.getElementById('overviewDoughnutChart').getContext('2d');
    new Chart(overviewCtx, {
        type: 'doughnut',
        data: {
            labels: ['Completed', 'In Progress', 'On Hold', 'Others'],
            datasets: [{
                data: [
                    <%= completed %>, 
                    <%= inProgress %>, 
                    <%= onHold %>, 
                    <%= totalUpdates - completed - inProgress - onHold %>
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

    // 6. Completion Rate Polar Chart
    const polarCtx = document.getElementById('polarChart').getContext('2d');
    new Chart(polarCtx, {
        type: 'polarArea',
        data: {
            labels: ['0-20%', '21-40%', '41-70%', '71-85%', '86-95%', '96-100%'],
            datasets: [{
                data: [
                    <%= completionData %>[0] + <%= completionData %>[1] + <%= completionData %>[2],
                    <%= completionData %>[3] + <%= completionData %>[4],
                    <%= completionData %>[5],
                    <%= completionData %>[6],
                    <%= completionData %>[7],
                    <%= completionData %>[8]
                ],
                backgroundColor: [
                    'rgba(220, 53, 69, 0.7)',
                    'rgba(255, 193, 7, 0.7)',
                    'rgba(23, 162, 184, 0.7)',
                    'rgba(52, 211, 153, 0.7)',
                    'rgba(74, 222, 128, 0.7)',
                    'rgba(34, 197, 94, 0.7)'
                ],
                borderWidth: 2,
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
</script>

<%
        con.close();
    } catch(Exception e){
        out.println("<div style='color:red; padding:20px;'>Error: " + e.getMessage() + "</div>");
        e.printStackTrace();
    }
%>

</body>
</html>