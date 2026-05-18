<%@page import="database.dbconfig"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="emphome.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Assigned Projects</title>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f6fa;
            margin: 0;
            padding: 0;
        }

        .box {
            width: 95%;
            max-width: 1400px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .box h3 {
            text-align: center;
            color: #151542;
            font-size: 2em;
            margin-bottom: 25px;
            border-bottom: 3px solid #151542;
            padding-bottom: 10px;
        }

        /* ===== STAT CARDS ===== */
        .stats-wrapper {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .stat-card {
            background: linear-gradient(135deg, #151542 0%, #2d2d6e 100%);
            color: white;
            padding: 20px 30px;
            border-radius: 10px;
            text-align: center;
            min-width: 150px;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            border: 3px solid transparent;
            user-select: none;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 28px rgba(0,0,0,0.2);
        }

        /* active/selected card highlight */
        .stat-card.active-total {
            border-color: #fff;
            box-shadow: 0 0 0 3px #151542;
        }

        .stat-card.active-ongoing {
            background: linear-gradient(135deg, #e63946 0%, #c1121f 100%);
            border-color: #fff;
            box-shadow: 0 0 0 3px #e63946;
        }

        .stat-card.active-completed {
            background: linear-gradient(135deg, #2a9d8f 0%, #1b6f66 100%);
            border-color: #fff;
            box-shadow: 0 0 0 3px #2a9d8f;
        }

        .stat-value {
            font-size: 2.5em;
            font-weight: bold;
        }

        .stat-label {
            font-size: 0.95rem;
            margin-top: 4px;
            opacity: 0.9;
        }

        /* ===== ACTIVE FILTER BANNER ===== */
        .filter-banner {
            display: none;
            align-items: center;
            justify-content: space-between;
            padding: 10px 18px;
            border-radius: 8px;
            margin-bottom: 16px;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .filter-banner.show { display: flex; }
        .filter-banner.ongoing-banner  { background: #fde8ea; color: #c1121f; border: 1.5px solid #e63946; }
        .filter-banner.completed-banner{ background: #d9f0ee; color: #1b6f66; border: 1.5px solid #2a9d8f; }

        .filter-banner .clear-btn {
            background: none;
            border: none;
            font-size: 1.1rem;
            cursor: pointer;
            color: inherit;
            font-weight: 700;
        }

        /* ===== TABLE ===== */
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        th, td {
            border: 1px solid #dee2e6;
            padding: 12px;
            text-align: center;
        }

        th {
            background: linear-gradient(135deg, #151542 0%, #2d2d6e 100%);
            color: #fff;
        }

        tr:nth-child(even) { background-color: #f8f9fa; }

        /* hide rows by filter */
        tr.row-ongoing   { }
        tr.row-completed { }
        tr.row-hidden    { display: none; }

        .status-btn {
            padding: 7px 14px;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
        }

        .status-btn.ongoing   { background-color: #e63946; color: #fff; }
        .status-btn.completed { background-color: #2a9d8f; color: #fff; }

        .no-data {
            text-align: center;
            padding: 50px;
            color: #6c757d;
        }

        /* empty state shown when filter yields nothing */
        #emptyMsg {
            display: none;
            text-align: center;
            padding: 30px;
            color: #6c757d;
            font-style: italic;
        }

        /* ===== ALERT BOX ===== */
        .alert-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.5);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        }
        .alert-overlay.show { display: flex; }

        .alert-box {
            background: #fff;
            border-radius: 16px;
            width: 360px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            animation: popUp 0.35s cubic-bezier(0.34,1.56,0.64,1);
            text-align: center;
        }

        @keyframes popUp {
            from { transform: scale(0.6); opacity: 0; }
            to   { transform: scale(1);   opacity: 1; }
        }

        .alert-banner-box {
            padding: 30px 20px 20px;
            background: #2a9d8f;
        }

        .alert-circle {
            width: 68px;
            height: 68px;
            border-radius: 50%;
            background: rgba(255,255,255,0.25);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 12px;
            font-size: 2.2rem;
            animation: bounceIcon 0.5s ease;
        }

        @keyframes bounceIcon {
            0%  { transform: scale(0.3); opacity: 0; }
            60% { transform: scale(1.2); }
            100%{ transform: scale(1);   opacity: 1; }
        }

        .alert-banner-box h3 { color: #fff; margin: 0 0 4px; font-size: 1.35rem; }
        .alert-banner-box p  { color: rgba(255,255,255,0.88); margin: 0; font-size: 0.87rem; }

        .alert-body-box { padding: 16px 24px 8px; }
        .alert-body-box .proj-id { font-size: 1rem; font-weight: 700; color: #151542; }
        .alert-body-box .proj-msg{ font-size: 0.86rem; color: #666; margin-top: 5px; line-height: 1.5; }

        .alert-footer-box { padding: 14px 24px 20px; }
        .alert-ok-btn {
            width: 100%;
            padding: 11px;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 700;
            border: none;
            cursor: pointer;
            background: #2a9d8f;
            color: #fff;
            transition: 0.2s;
        }
        .alert-ok-btn:hover { background: #1b6f66; }

        .alert-prog { height: 5px; background: #e9ecef; }
        .alert-prog-fill {
            height: 100%;
            background: #2a9d8f;
            animation: drain 2.5s linear forwards;
        }

        @keyframes drain {
            from { width: 100%; }
            to   { width: 0%; }
        }
    </style>
</head>

<body>

<!-- ===== COMPLETION ALERT BOX ===== -->
<div class="alert-overlay" id="alertOverlay">
    <div class="alert-box">
        <div class="alert-banner-box">
            <div class="alert-circle">✅</div>
            <h3>Project Completed!</h3>
            <p>Status updated successfully</p>
        </div>
        <div class="alert-body-box">
            <p class="proj-id"  id="alertProjId"></p>
            <p class="proj-msg">This project has been marked as <strong>Completed</strong> and saved in the system.</p>
        </div>
        <div class="alert-footer-box">
            <button class="alert-ok-btn" onclick="closeAlert()">OK</button>
        </div>
        <div class="alert-prog">
            <div class="alert-prog-fill" id="alertBar"></div>
        </div>
    </div>
</div>

<div class="box">
    <h3>📋 My Assigned Projects</h3>

<%
    String mid = (String) session.getAttribute("mid");

    if (mid == null) {
%>
    <div class="no-data">
        <h3>⚠️ Session Expired</h3>
        <a href="emplogin.jsp">Login Again</a>
    </div>
<%
    } else {

        int totalProjects = 0, ongoingCount = 0, completedCount = 0;

        try {
            Connection con = new dbconfig().getConnection();

            PreparedStatement ps1 = con.prepareStatement(
                "SELECT COUNT(*) FROM mpadd1 WHERE mid=?");
            ps1.setString(1, mid);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) totalProjects = rs1.getInt(1);

            PreparedStatement ps2 = con.prepareStatement(
                "SELECT COUNT(*) FROM mpadd1 WHERE mid=? AND (status='Ongoing' OR status IS NULL OR status='')");
            ps2.setString(1, mid);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) ongoingCount = rs2.getInt(1);

            PreparedStatement ps3 = con.prepareStatement(
                "SELECT COUNT(*) FROM mpadd1 WHERE mid=? AND status='Completed'");
            ps3.setString(1, mid);
            ResultSet rs3 = ps3.executeQuery();
            if (rs3.next()) completedCount = rs3.getInt(1);

            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
%>

<!-- ===== STAT CARDS — clickable ===== -->
<div class="stats-wrapper">
    <div class="stat-card active-total" id="cardTotal" onclick="filterRows('all')">
        <div class="stat-value"><%= totalProjects %></div>
        <div class="stat-label">Total Projects</div>
    </div>
    <div class="stat-card" id="cardOngoing" onclick="filterRows('ongoing')">
        <div class="stat-value"><%= ongoingCount %></div>
        <div class="stat-label">Ongoing</div>
    </div>
    <div class="stat-card" id="cardCompleted" onclick="filterRows('completed')">
        <div class="stat-value"><%= completedCount %></div>
        <div class="stat-label">Completed</div>
    </div>
</div>

<!-- ===== ACTIVE FILTER BANNER ===== -->
<div class="filter-banner ongoing-banner"   id="bannerOngoing">
    🔴 Showing Ongoing Projects only
    <button class="clear-btn" onclick="filterRows('all')" title="Show all">✕ Clear</button>
</div>
<div class="filter-banner completed-banner" id="bannerCompleted">
    🟢 Showing Completed Projects only
    <button class="clear-btn" onclick="filterRows('all')" title="Show all">✕ Clear</button>
</div>

<!-- ===== TABLE ===== -->
<table>
<thead>
<tr>
    <th>SL No</th>
    <th>Project ID</th>
    <th>Start Date</th>
    <th>End Date</th>
    <th>Technology</th>
    <th>Actions</th>
</tr>
</thead>
<tbody id="projectTableBody">
<%
    try {
        Connection con = new dbconfig().getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM mpadd1 WHERE mid=? ORDER BY id DESC");
        ps.setString(1, mid);
        ResultSet rs = ps.executeQuery();

        int sl = 1;
        boolean found = false;

        while (rs.next()) {
            found = true;
            String status    = rs.getString("status");
            if (status == null || status.trim().isEmpty()) status = "Ongoing";
            String rowClass  = status.equals("Completed") ? "row-completed" : "row-ongoing";
            String projectId = rs.getString("project_id");
%>
<tr class="<%= rowClass %>">
    <td><%= sl++ %></td>
    <td><%= projectId %></td>
    <td><%= rs.getString("startdate") %></td>
    <td><%= rs.getString("enddate") %></td>
    <td><%= rs.getString("technology") %></td>
    <td>
        <button class="status-btn <%= status.equals("Completed") ? "completed" : "ongoing" %>"
                onclick="markComplete(this, <%= rs.getInt("id") %>, '<%= projectId %>')"
                <%= status.equals("Completed") ? "disabled" : "" %>>
            <%= status.equals("Completed") ? "✔ Completed" : "Mark Complete" %>
        </button>
    </td>
</tr>
<%
        }

        if (!found) {
%>
<tr id="noDataRow">
    <td colspan="6">
        <div class="no-data">📭 No Projects Assigned</div>
    </td>
</tr>
<%
        }

        con.close();
    } catch(Exception e) {
        out.println(e);
    }
%>
</tbody>
</table>

<div id="emptyMsg">📭 No projects found for this filter.</div>

<%
    } // end else
%>
</div>

<!-- ===== JS ===== -->
<script>

    /* ---- Filter rows by clicking stat cards ---- */
    let currentFilter = 'all';

    function filterRows(type) {
        currentFilter = type;

        const allRows       = document.querySelectorAll('#projectTableBody tr.row-ongoing, #projectTableBody tr.row-completed');
        const bannerOngoing  = document.getElementById('bannerOngoing');
        const bannerCompleted= document.getElementById('bannerCompleted');
        const cardTotal     = document.getElementById('cardTotal');
        const cardOngoing   = document.getElementById('cardOngoing');
        const cardCompleted = document.getElementById('cardCompleted');

        /* reset card styles */
        cardTotal.className    = 'stat-card';
        cardOngoing.className  = 'stat-card';
        cardCompleted.className= 'stat-card';

        /* hide both banners */
        bannerOngoing.classList.remove('show');
        bannerCompleted.classList.remove('show');

        let visibleCount = 0;

        allRows.forEach(row => {
            if (type === 'all') {
                row.classList.remove('row-hidden');
                visibleCount++;
            } else if (type === 'ongoing') {
                if (row.classList.contains('row-ongoing')) {
                    row.classList.remove('row-hidden');
                    visibleCount++;
                } else {
                    row.classList.add('row-hidden');
                }
            } else if (type === 'completed') {
                if (row.classList.contains('row-completed')) {
                    row.classList.remove('row-hidden');
                    visibleCount++;
                } else {
                    row.classList.add('row-hidden');
                }
            }
        });

        /* highlight active card */
        if (type === 'all')       { cardTotal.className    = 'stat-card active-total'; }
        if (type === 'ongoing')   { cardOngoing.className  = 'stat-card active-ongoing';
                                    bannerOngoing.classList.add('show'); }
        if (type === 'completed') { cardCompleted.className= 'stat-card active-completed';
                                    bannerCompleted.classList.add('show'); }

        /* show empty message if nothing visible */
        document.getElementById('emptyMsg').style.display = (visibleCount === 0) ? 'block' : 'none';
    }

    /* ---- Mark Complete + show alert ---- */
    let _alertTimer = null;

    function markComplete(btn, id, projectId) {
        /* update UI immediately */
        btn.textContent = '✔ Completed';
        btn.classList.remove('ongoing');
        btn.classList.add('completed');
        btn.disabled = true;

        /* change row class so filter still works */
        const row = btn.closest('tr');
        row.classList.remove('row-ongoing');
        row.classList.add('row-completed');

        /* show success alert */
        document.getElementById('alertProjId').textContent = 'Project ID: ' + projectId;

        /* restart progress bar animation */
        const bar = document.getElementById('alertBar');
        bar.style.animation = 'none';
        void bar.offsetWidth;
        bar.style.animation = '';

        document.getElementById('alertOverlay').classList.add('show');

        clearTimeout(_alertTimer);
        _alertTimer = setTimeout(closeAlert, 2500);

        /* save to server */
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "updatestatus.jsp", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.send("id=" + id + "&status=Completed");
    }

    function closeAlert() {
        clearTimeout(_alertTimer);
        document.getElementById('alertOverlay').classList.remove('show');

        /* re-apply current filter so completed row hides if in ongoing view */
        filterRows(currentFilter);

        /* update stat card counts on page */
        updateCounts();
    }

    /* update stat card numbers without full reload */
    function updateCounts() {
        const ongoing   = document.querySelectorAll('#projectTableBody tr.row-ongoing').length;
        const completed = document.querySelectorAll('#projectTableBody tr.row-completed').length;
        const total     = ongoing + completed;

        document.querySelector('#cardTotal .stat-value').textContent    = total;
        document.querySelector('#cardOngoing .stat-value').textContent  = ongoing;
        document.querySelector('#cardCompleted .stat-value').textContent= completed;
    }

</script>
</body>
</html>