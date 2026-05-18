<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.dbconfig"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="clientheader.jsp" %>

<%
    String clientPhone = (String) session.getAttribute("phono");
    String clientName = (String) session.getAttribute("name");

    if (clientPhone == null || clientPhone.trim().isEmpty()) {
        response.sendRedirect("clientlogin.jsp");
        return;
    }
    clientPhone = clientPhone.trim();

    // Company contact number
    String companyPhone = "1800-123-456"; // replace with actual company number
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Project Progress</title>

<style>
body { font-family: 'Poppins', sans-serif; background:#f5f6fa; margin:0; }

.container { width:95%; max-width:1200px; margin:40px auto; background:#fff; border-radius:10px; padding:40px; box-shadow:0 4px 12px rgba(0,0,0,0.1); }

.welcome-section { text-align:center; padding:20px; margin-bottom:20px; background:linear-gradient(135deg,#151542,#2d2d6e); color:white; border-radius:10px; }
.filter-buttons { display:flex; justify-content:center; gap:15px; margin:25px 0 35px; }
.filter-btn { padding:10px 22px; border-radius:25px; font-weight:600; border:none; cursor:pointer; color:white; transition:0.3s; }
.filter-btn:hover { transform:translateY(-2px); box-shadow:0 6px 15px rgba(0,0,0,0.2); }
.all-btn { background:#007bff; }
.ongoing-btn { background:#ffc107; color:#000; }
.completed-btn { background:#28a745; }

.project-card { background:white; border-radius:12px; padding:30px; margin-bottom:30px; box-shadow:0 3px 10px rgba(0,0,0,0.08); border-left:5px solid #151542; }
.project-header { display:flex; justify-content:space-between; flex-wrap:wrap; }
.project-title { font-size:1.6em; font-weight:600; }
.update-date { background:#f8f9fa; padding:8px 16px; border-radius:20px; }
.project-info { display:grid; grid-template-columns:repeat(auto-fit,minmax(200px,1fr)); gap:15px; background:#f8f9fa; padding:20px; border-radius:8px; margin:25px 0; }
.info-label { font-size:0.8em; color:#6c757d; font-weight:600; }
.info-value { font-size:1em; font-weight:600; }

.progress-container { margin:35px 0; position:relative; }
.progress-bar { height:6px; background:#dcdcdc; border-radius:5px; }
.progress-fill { height:6px; background:linear-gradient(90deg,#151542,#007bff); border-radius:5px; }
.steps { display:flex; justify-content:space-between; margin-top:15px; }
.circle { width:45px; height:45px; border-radius:50%; background:#dcdcdc; display:flex; justify-content:center; align-items:center; font-size:22px; }
.circle.active { background:#007bff; }
.circle.completed { background:#28a745; }

.description-section { background:#f8f9fa; padding:20px; border-radius:8px; }
.contact-number { margin-top:15px; padding:10px 15px; border-radius:20px; background:#e0f7e9; color:#155724; font-weight:bold; display:inline-block; }

</style>
</head>

<body>

<div class="container">

<div class="welcome-section">
    <h1>👋 Welcome, <%= clientName != null ? clientName : "Client" %></h1>
    <p>Track your project progress</p>
</div>

<!-- FILTER BUTTONS -->
<div class="filter-buttons">
    <button class="filter-btn all-btn" onclick="filterProjects('all')">All Projects</button>
    <button class="filter-btn ongoing-btn" onclick="filterProjects('ongoing')">Ongoing</button>
    <button class="filter-btn completed-btn" onclick="filterProjects('completed')">Completed</button>
</div>

<%
try {
    Connection con = new dbconfig().getConnection();

    String[] steps = {"planning","in progress","development phase","testing phase","review","deployment","completed"};
    String[] icons = {"📘","🚀","💻","🧪","📝","📦","🏁"};

    String sql = "SELECT * FROM projectprogress1 WHERE phono=? ORDER BY update_date DESC";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, clientPhone);
    ResultSet rs = ps.executeQuery();

    boolean hasProjects = false;

    while (rs.next()) {
        hasProjects = true;

        String status = rs.getString("progress_status");
        if (status == null) status = "planning";
        String normalizedStatus = status.toLowerCase();

        int index = 0;
        for (int i=0;i<steps.length;i++)
            if (normalizedStatus.contains(steps[i])) index=i;

        int progressPercent = (int)(((double)index/(steps.length-1))*100);
%>

<div class="project-card"
     data-status="<%= normalizedStatus.equals("completed") ? "completed" : "ongoing" %>">

    <div class="project-header">
        <div class="project-title">🎯 <%= rs.getString("update_title") %></div>
        <div class="update-date">📅 <%= rs.getString("update_date") %></div>
    </div>

    <div class="project-info">
        <div>
            <div class="info-label">Status</div>
            <div class="info-value"><%= status %></div>
        </div>
        <div>
            <div class="info-label">Completion</div>
            <div class="info-value"><%= progressPercent %>%</div>
        </div>
    </div>

    <div class="progress-container">
        <div class="progress-bar"></div>
        <div class="progress-fill" style="width:<%=progressPercent%>%"></div>

        <div class="steps">
        <% for(int i=0;i<steps.length;i++){ %>
            <div class="circle <%= i<index?"completed":(i==index?"active":"") %>">
                <%= icons[i] %>
            </div>
        <% } %>
        </div>
    </div>

    <div class="description-section">
        <b>📋 Description:</b><br>
        <%= rs.getString("description") %>

        <% if(normalizedStatus.equals("completed")) { %>
            <div class="contact-number">📞 Company Contact: <%= companyPhone %></div>
        <% } %>
    </div>
</div>

<% }
if(!hasProjects){ %>
<div style="text-align:center;padding:40px;color:#666;">
    📭 No projects found
</div>
<% }

con.close();
} catch(Exception e) { %>
<div style="color:red;text-align:center;">⚠️ <%= e.getMessage() %></div>
<% } %>

</div>

<script>
function filterProjects(type) {
    const cards = document.querySelectorAll('.project-card');
    cards.forEach(card => {
        const status = card.getAttribute('data-status');
        card.style.display = (type==='all' || type===status)?'block':'none';
    });
}
</script>

</body>
</html>
