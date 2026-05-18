<%@page import="java.sql.*"%>
<%@page import="database.dbconfig"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="mhome.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manager View - All Project Progress</title>
    <style>
        body { font-family:'Poppins',sans-serif; background:#f5f6fa; margin:0; padding:0;}
        .container { width:95%; max-width:1400px; margin:40px auto; background:#fff; padding:30px; border-radius:10px;
                     box-shadow:0 4px 12px rgba(0,0,0,0.1);}
        h1 { text-align:center; color:#151542; margin-bottom:25px; border-bottom:3px solid #151542; padding-bottom:10px;}

        .summary { display:flex; flex-wrap:wrap; gap:20px; margin-bottom:25px; }
        .card { flex:1; min-width:150px; background:#151542; color:white; padding:15px; border-radius:8px; text-align:center; }
        .card h2 { margin:5px 0; }
        .table-container { overflow-x:auto; margin-top:20px; }
        table { width:100%; border-collapse:collapse; background:#fff; box-shadow:0 2px 8px rgba(0,0,0,0.1);}
        thead { background: linear-gradient(135deg, #151542 0%, #2d2d6e 100%); color:white;}
        th, td { padding:12px 10px; text-align:left; font-size:14px; border-bottom:1px solid #e9ecef; white-space:nowrap;}
        tbody tr:hover { background:#f8f9fa; }

        .status-badge { padding:6px 15px; border-radius:20px; font-size:12px; font-weight:600; display:inline-block;}
        .status-planning { background:#ffc107; color:#000; }
        .status-progress { background:#17a2b8; color:white; }
        .status-design { background:#6f42c1; color:white; }
        .status-development { background:#007bff; color:white; }
        .status-testing { background:#fd7e14; color:white; }
        .status-review { background:#20c997; color:white; }
        .status-deployment { background:#e83e8c; color:white; }
        .status-completed { background:#28a745; color:white; }
        .status-hold { background:#dc3545; color:white; }

        .completion-badge { padding:5px 12px; border-radius:15px; font-size:12px; font-weight:600; display:inline-block;}
        .completion-low { background:#f8d7da; color:#721c24; }
        .completion-medium { background:#fff3cd; color:#856404; }
        .completion-high { background:#d1ecf1; color:#0c5460; }
        .completion-complete { background:#d4edda; color:#155724; }

        .btn-edit { background:#ffc107; color:#000; padding:6px 15px; border-radius:4px; font-size:13px; text-decoration:none; font-weight:600; }
        .btn-edit:hover { background:#e0a800; }

        .description-cell { max-width:300px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }

        @media(max-width:768px){ .container{width:98%; padding:15px;} table{font-size:12px;} th,td{padding:8px 5px;} }
    </style>
</head>

<body>
<div class="container">
    <h1>📊 Manager View - All Project Progress</h1>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = new dbconfig().getConnection();

        // Aggregate summary
        String summarySql = "SELECT COUNT(*) AS total, AVG(CAST(completion_percentage AS UNSIGNED)) AS avg_completion, " +
                            "SUM(progress_status='On Hold') AS on_hold, SUM(progress_status='Completed') AS completed " +
                            "FROM projectprogress1";
        PreparedStatement psSummary = con.prepareStatement(summarySql);
        ResultSet rsSummary = psSummary.executeQuery();

        int totalUpdates = 0;
        int avgCompletion = 0;
        int onHoldCount = 0;
        int completedCount = 0;

        if(rsSummary.next()){
            totalUpdates = rsSummary.getInt("total");
            avgCompletion = rsSummary.getInt("avg_completion");
            onHoldCount = rsSummary.getInt("on_hold");
            completedCount = rsSummary.getInt("completed");
        }
        rsSummary.close();
        psSummary.close();
%>
    <div class="summary">
        <div class="card">
            <h2><%= totalUpdates %></h2>
            Total Updates
        </div>
        <div class="card">
            <h2><%= avgCompletion %> %</h2>
            Average Completion
        </div>
        <div class="card" style="background:#dc3545;">
            <h2><%= onHoldCount %></h2>
            On Hold
        </div>
        <div class="card" style="background:#28a745;">
            <h2><%= completedCount %></h2>
            Completed
        </div>
    </div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Phone</th>
                    <th>Update Title</th>
                    <th>Status</th>
                    <th>Completion</th>
                    <th>Description</th>
                    <th>Update Date</th>
                    <th>Next Milestone</th>
                    <th>Created At</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
<%
        // All updates
        String sql = "SELECT * FROM projectprogress1 ORDER BY update_date DESC, created_at DESC";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        int rowNum = 0;
        boolean hasData = false;

        while(rs.next()){
            hasData = true;
            rowNum++;

            String phono = rs.getString("phono");
            String updateTitle = rs.getString("update_title");
            String progressStatus = rs.getString("progress_status");
            String completionPercentage = rs.getString("completion_percentage");
            String description = rs.getString("description");
            String updateDate = rs.getString("update_date");
            String nextMilestone = rs.getString("next_milestone");
            String createdAt = rs.getString("created_at");
            String id = rs.getString("id");

            // Status Badge
            String statusClass = "status-progress";
            if(progressStatus != null){
                String st = progressStatus.toLowerCase();
                if(st.equals("planning")) statusClass="status-planning";
                else if(st.equals("in progress")) statusClass="status-progress";
                else if(st.equals("design phase")) statusClass="status-design";
                else if(st.equals("development phase")) statusClass="status-development";
                else if(st.equals("testing phase")) statusClass="status-testing";
                else if(st.equals("review")) statusClass="status-review";
                else if(st.equals("deployment")) statusClass="status-deployment";
                else if(st.equals("completed")) statusClass="status-completed";
                else if(st.equals("on hold")) statusClass="status-hold";
            }

            // Completion Badge
            int cp = 0;
            try{ cp = Integer.parseInt(completionPercentage);}catch(Exception e){}
            String completionClass="completion-low";
            if(cp>=100) completionClass="completion-complete";
            else if(cp>=70) completionClass="completion-high";
            else if(cp>=40) completionClass="completion-medium";
%>
            <tr>
                <td><%= rowNum %></td>
                <td><%= phono %></td>
                <td><%= updateTitle %></td>
                <td><span class="status-badge <%= statusClass %>"><%= progressStatus %></span></td>
                <td><span class="completion-badge <%= completionClass %>"><%= completionPercentage %>%</span></td>
                <td class="description-cell" title="<%= description %>"><%= description %></td>
                <td><%= updateDate %></td>
                <td><%= (nextMilestone!=null && !nextMilestone.trim().isEmpty())?nextMilestone:"-" %></td>
                <td><%= createdAt %></td>
                <td>
                    <a href="editprogress.jsp?id=<%= id %>" class="btn-edit">✏️ Update</a>
                </td>
            </tr>
<%
        }

        if(!hasData){
%>
            <tr>
                <td colspan="10" style="text-align:center; padding:30px; color:#6c757d;">
                    No progress records found.
                </td>
            </tr>
<%
        }

        rs.close();
        ps.close();
        con.close();
    } catch(Exception e){
%>
        <tr>
            <td colspan="10" style="text-align:center; color:red;">Error: <%= e.getMessage() %></td>
        </tr>
<%
    }
%>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
