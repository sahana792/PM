<%@page import="database.dbconfig"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="clientheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Track Project Progress</title>
    
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f6fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 95%;
            max-width: 1400px;
            margin: 60px auto;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 40px;
        }

        h1 {
            color: #151542;
            text-align: center;
            margin-bottom: 40px;
            padding-bottom: 15px;
            border-bottom: 3px solid #151542;
            font-size: 2em;
        }

        .project-selector {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .project-selector label {
            font-weight: 600;
            color: #151542;
            font-size: 1.1em;
        }

        .project-selector select {
            flex: 1;
            min-width: 250px;
            padding: 12px;
            border: 2px solid #151542;
            border-radius: 5px;
            font-size: 15px;
            cursor: pointer;
        }

        .timeline {
            position: relative;
            padding: 20px 0;
        }

        .timeline::before {
            content: '';
            position: absolute;
            left: 50px;
            top: 0;
            bottom: 0;
            width: 4px;
            background: linear-gradient(to bottom, #151542, #4a90e2);
        }

        .timeline-item {
            position: relative;
            margin-bottom: 40px;
            padding-left: 100px;
        }

        .timeline-dot {
            position: absolute;
            left: 38px;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background-color: #151542;
            border: 4px solid #ffffff;
            box-shadow: 0 0 0 4px #151542;
            z-index: 1;
        }

        .timeline-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            color: white;
            transition: transform 0.3s;
        }

        .timeline-card:hover {
            transform: translateX(10px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .timeline-card h3 {
            margin: 0 0 15px 0;
            font-size: 1.4em;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .timeline-card .date {
            background-color: rgba(255, 255, 255, 0.2);
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
        }

        .progress-bar-container {
            background-color: rgba(255, 255, 255, 0.3);
            border-radius: 10px;
            height: 25px;
            margin: 15px 0;
            overflow: hidden;
        }

        .progress-bar {
            height: 100%;
            background: linear-gradient(90deg, #4CAF50, #8BC34A);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            transition: width 0.5s;
            color: white;
            font-size: 0.9em;
        }

        .status-badge {
            display: inline-block;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
            background-color: rgba(255, 255, 255, 0.3);
            margin: 10px 0;
        }

        .description {
            background-color: rgba(255, 255, 255, 0.2);
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
            line-height: 1.6;
        }

        .next-milestone {
            background-color: rgba(255, 255, 255, 0.15);
            padding: 12px;
            border-radius: 8px;
            border-left: 4px solid #FFC107;
            margin-top: 15px;
        }

        .next-milestone strong {
            color: #FFC107;
        }

        .no-progress {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }

        .no-progress i {
            font-size: 4em;
            margin-bottom: 20px;
            color: #dee2e6;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
        }

        .alert-warning {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }

        .alert-info {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        @media (max-width: 768px) {
            .timeline::before {
                left: 20px;
            }
            
            .timeline-item {
                padding-left: 60px;
            }
            
            .timeline-dot {
                left: 8px;
            }
            
            .timeline-card h3 {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
        }
    </style>
    
    <script>
        function loadProgress() {
            var phono = document.getElementById("projectSelect").value;
            if (phono) {
                window.location.href = "trackprogress.jsp?phono=" + phono;
            }
        }
    </script>
</head>

<body>
    <div class="container">
        <h1>📊 Track Project Progress</h1>
        
        <%
            String loggedInPhono = (String) session.getAttribute("phono");
            
            if (loggedInPhono == null || loggedInPhono.trim().isEmpty()) {
        %>
                <div class="alert alert-warning">
                    <strong>Please login first to track your projects!</strong>
                </div>
        <%
            } else {
                String selectedPhono = request.getParameter("phono");
                if (selectedPhono == null) {
                    selectedPhono = loggedInPhono;
                }
        %>
        
        <div class="project-selector">
            <label>Select Your Project:</label>
            <select id="projectSelect" onchange="loadProgress()">
                <option value="">-- Select Project --</option>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = new dbconfig().getConnection();
                        
                        String sql = "SELECT phono, pname, cname FROM projectadd1 WHERE phono = ?";
                        PreparedStatement ps = con.prepareStatement(sql);
                        ps.setString(1, loggedInPhono);
                        ResultSet res = ps.executeQuery();
                        
                        while (res.next()) {
                            String phono = res.getString("phono");
                            String pname = res.getString("pname");
                            String cname = res.getString("cname");
                            String selected = phono.equals(selectedPhono) ? "selected" : "";
                %>
                            <option value="<%= phono %>" <%= selected %>><%= pname %> - <%= cname %></option>
                <%
                        }
                        ps.close();
                        con.close();
                    } catch (Exception e) {
                        out.println("<option value=''>Error loading projects</option>");
                    }
                %>
            </select>
        </div>
        
        <%
            if (selectedPhono != null && !selectedPhono.isEmpty()) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = new dbconfig().getConnection();
                    
                    String sql = "SELECT * FROM projectprogress1 WHERE phono = ? ORDER BY update_date DESC";
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setString(1, selectedPhono);
                    ResultSet res = ps.executeQuery();
                    
                    boolean hasProgress = false;
        %>
                    <div class="timeline">
        <%
                    while (res.next()) {
                        hasProgress = true;
                        String updateTitle = res.getString("update_title");
                        String progressStatus = res.getString("progress_status");
                        String completionPercentage = res.getString("completion_percentage");
                        String description = res.getString("description");
                        String updateDate = res.getString("update_date");
                        String nextMilestone = res.getString("next_milestone");
        %>
                        <div class="timeline-item">
                            <div class="timeline-dot"></div>
                            <div class="timeline-card">
                                <h3>
                                    <span><%= updateTitle %></span>
                                    <span class="date">📅 <%= updateDate %></span>
                                </h3>
                                
                                <div class="status-badge">
                                    Status: <%= progressStatus %>
                                </div>
                                
                                <div class="progress-bar-container">
                                    <div class="progress-bar" style="width: <%= completionPercentage %>%">
                                        <%= completionPercentage %>% Complete
                                    </div>
                                </div>
                                
                                <div class="description">
                                    <%= description %>
                                </div>
                                
                                <% if (nextMilestone != null && !nextMilestone.trim().isEmpty()) { %>
                                    <div class="next-milestone">
                                        <strong>🎯 Next Milestone:</strong> <%= nextMilestone %>
                                    </div>
                                <% } %>
                            </div>
                        </div>
        <%
                    }
                    
                    if (!hasProgress) {
        %>
                        <div class="no-progress">
                            <div style="font-size: 4em; margin-bottom: 20px;">📋</div>
                            <h2>No Progress Updates Yet</h2>
                            <p>Your project manager will add updates as the project progresses.</p>
                        </div>
        <%
                    }
        %>
                    </div>
        <%
                    ps.close();
                    con.close();
                } catch (Exception e) {
                    out.println("<div class='alert alert-warning'>Error: " + e.getMessage() + "</div>");
                }
            }
        }
        %>
    </div>
</body>
</html>