<%@page import="database.dbconfig"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="adminheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Client Requirements</title>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f6fa;
        }

        .container {
            width: calc(100% - 250px);
            margin-left: 150px;
            padding: 20px;
            background-color: #fff;
            overflow-x: hidden;
            box-sizing: border-box;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            word-wrap: break-word;
        }

        h2 {
            text-align: center;
            color: #151542;
            font-weight: 700;
            font-size: 2rem;
            margin: 0 0 20px 0;
            border-bottom: 3px solid #151542;
            padding-bottom: 6px;
        }

        .tabs {
            display: flex;
            border-bottom: 2px solid #ddd;
            margin-bottom: 20px;
        }

        .tab {
            padding: 12px 25px;
            cursor: pointer;
            font-weight: 600;
            color: #555;
            border-bottom: 3px solid transparent;
            transition: 0.3s;
            flex-grow: 1;
            text-align: center;
        }

        .tab.active {
            color: #151542;
            border-bottom: 3px solid #151542;
        }

        th, td {
            padding: 10px 12px;
            border: 1px solid #dee2e6;
            vertical-align: top;
        }

        th {
            background-color: #151542;
            color: white;
            font-weight: 600;
        }

        tr:nth-child(even) { background-color: #f8f9fa; }
        tr:hover { background-color: #e9ecef; }

        .btn {
            padding: 6px 12px;
            border-radius: 5px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            margin: 3px 0;
            width: 100%;
            font-size: 14px;
        }

        .btn-success { background-color: #28a745; color: white; }
        .btn-success:hover { background-color: #218838; }
        .btn-danger  { background-color: #dc3545; color: white; }
        .btn-danger:hover  { background-color: #c82333; }

        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 6px;
            width: 100%;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 5px;
            font-weight: 600;
            display: inline-block;
        }

        .status-pending  { background-color: #ffc107; color: black; }
        .status-accepted { background-color: #28a745; color: white; }
        .status-rejected { background-color: #dc3545; color: white; }

        .tab-content { display: none; }
        .tab-content.active { display: table; }
        .details-preview { max-width: 280px; }

        .toggle-btn {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1.1em;
            font-weight: bold;
            color: #151542;
        }

        .no-data {
            text-align: center;
            padding: 25px;
            color: #666;
            font-style: italic;
        }

        .error-message {
            color: red;
            text-align: center;
            padding: 15px;
            background-color: #ffe6e6;
            border-radius: 5px;
        }

        /* =====================================================
           ALERT BOX
        ===================================================== */
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
            width: 380px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            animation: popUp 0.35s cubic-bezier(0.34,1.56,0.64,1);
            text-align: center;
        }

        @keyframes popUp {
            from { transform: scale(0.6); opacity: 0; }
            to   { transform: scale(1);   opacity: 1; }
        }

        /* top coloured banner */
        .alert-banner {
            padding: 32px 20px 22px;
        }
        .alert-banner.green { background: #28a745; }
        .alert-banner.red   { background: #dc3545; }

        .alert-circle {
            width: 72px;
            height: 72px;
            border-radius: 50%;
            background: rgba(255,255,255,0.25);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 14px;
            font-size: 2.4rem;
            animation: bounceIcon 0.5s ease;
        }

        @keyframes bounceIcon {
            0%  { transform: scale(0.3); opacity: 0; }
            60% { transform: scale(1.2); }
            100%{ transform: scale(1);   opacity: 1; }
        }

        .alert-banner h3 {
            color: #fff;
            font-size: 1.45rem;
            font-weight: 700;
            margin: 0 0 4px;
        }

        .alert-banner p {
            color: rgba(255,255,255,0.88);
            font-size: 0.88rem;
            margin: 0;
        }

        /* body */
        .alert-body {
            padding: 18px 26px 6px;
        }

        .alert-body .alert-client {
            font-size: 1rem;
            font-weight: 700;
            color: #151542;
        }

        .alert-body .alert-detail {
            font-size: 0.87rem;
            color: #666;
            margin-top: 6px;
            line-height: 1.5;
        }

        /* OK button */
        .alert-footer {
            padding: 16px 26px 22px;
        }

        .alert-ok {
            width: 100%;
            padding: 11px;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 700;
            border: none;
            cursor: pointer;
            color: #fff;
            transition: 0.2s;
        }
        .alert-ok.green { background: #28a745; }
        .alert-ok.green:hover { background: #218838; }
        .alert-ok.red   { background: #dc3545; }
        .alert-ok.red:hover   { background: #c82333; }

        /* shrinking progress bar */
        .alert-progress {
            height: 5px;
            background: #e9ecef;
        }
        .alert-progress-fill {
            height: 100%;
            animation: drain 2.5s linear forwards;
        }
        .alert-progress-fill.green { background: #28a745; }
        .alert-progress-fill.red   { background: #dc3545; }

        @keyframes drain {
            from { width: 100%; }
            to   { width: 0%; }
        }

    </style>
</head>
<body>

<!-- ===================== ALERT BOX ===================== -->
<div class="alert-overlay" id="alertOverlay">
    <div class="alert-box">

        <div class="alert-banner" id="alertBanner">
            <div class="alert-circle" id="alertIcon"></div>
            <h3 id="alertTitle"></h3>
            <p  id="alertSubtitle"></p>
        </div>

        <div class="alert-body">
            <p class="alert-client" id="alertClient"></p>
            <p class="alert-detail" id="alertDetail"></p>
        </div>

        <div class="alert-footer">
            <button class="alert-ok" id="alertOkBtn" onclick="closeAndGo()">OK</button>
        </div>

        <div class="alert-progress">
            <div class="alert-progress-fill" id="alertBar"></div>
        </div>

    </div>
</div>

<div class="container">
    <h2>Client Requirements</h2>

    <div class="tabs">
        <div class="tab active" data-tab="pending">Pending Projects</div>
        <div class="tab" data-tab="accepted">Accepted Projects</div>
        <div class="tab" data-tab="rejected">Rejected Projects</div>
    </div>

    <!-- ===================== PENDING PROJECTS ===================== -->
    <table id="pending" class="tab-content active">
        <thead>
        <tr>
            <th>SL.no</th>
            <th>Client Name</th>
            <th>Email</th>
            <th>Phone No</th>
            <th>Title</th>
            <th>Requirements &amp; Description</th>
            <th>Deadline</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                int slno = 0;
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = new dbconfig().getConnection();
                Statement stat = con.createStatement();
                ResultSet res = stat.executeQuery(
                    "SELECT * FROM requirements WHERE status='Pending' OR status='pending' OR status IS NULL OR status=''"
                );
                boolean hasData = false;

                while (res.next()) {
                    hasData = true;
                    slno++;
                    String requirements = res.getString("requirements");
                    String description  = res.getString("description");
                    String reqShort  = requirements.length() > 50 ? requirements.substring(0,50)+"..." : requirements;
                    String descShort = description.length()  > 50 ? description.substring(0,50)+"..."  : description;
                    String clientName = res.getString("cname");
                    String rowId      = res.getString("id");
                    String safe       = clientName.replace("'", "\\'");
        %>
        <tr>
            <td><%= slno %></td>
            <td><%= clientName %></td>
            <td><%= res.getString("email") %></td>
            <td><%= res.getString("phono") %></td>
            <td><%= res.getString("title") %></td>
            <td>
                <div class="details-preview">
                    <strong>Req:</strong> <%= reqShort %><br>
                    <strong>Desc:</strong> <%= descShort %>
                </div>
            </td>
            <td><%= res.getString("deadline") %></td>
            <td><span class="status-badge status-pending">Pending</span></td>

            <td class="action-buttons">
                <!-- Accept button: shows green alert then redirects -->
                <button class="btn btn-success"
                    onclick="showAlert('accept', 'clientacept?id=<%= rowId %>', '<%= safe %>')">
                    Accept
                </button>
                <!-- Reject button: shows red alert then redirects -->
                <button class="btn btn-danger"
                    onclick="showAlert('reject', 'clientdel1?id=<%= rowId %>', '<%= safe %>')">
                    Reject
                </button>
            </td>
        </tr>
        <%
                }
                if (!hasData) {
        %>
            <tr><td colspan="9" class="no-data">No pending projects found.</td></tr>
        <%
                }
                res.close(); stat.close(); con.close();
            } catch (Exception e) {
        %>
            <tr><td colspan="9" class="error-message">Error: <%= e.getMessage() %></td></tr>
        <%
            }
        %>
        </tbody>
    </table>

    <!-- ===================== ACCEPTED PROJECTS ===================== -->
    <table id="accepted" class="tab-content">
        <thead>
        <tr>
            <th>SL.no</th>
            <th>Client Name</th>
            <th>Email</th>
            <th>Phone No</th>
            <th>Title</th>
            <th>Requirements &amp; Description</th>
            <th>Deadline</th>
            <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                int slno = 0;
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = new dbconfig().getConnection();
                PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM requirements WHERE LOWER(status)='accepted'"
                );
                ResultSet res = ps.executeQuery();
                boolean hasData = false;
                while (res.next()) { hasData = true; slno++;
        %>
        <tr>
            <td><%= slno %></td>
            <td><%= res.getString("cname") %></td>
            <td><%= res.getString("email") %></td>
            <td><%= res.getString("phono") %></td>
            <td><%= res.getString("title") %></td>
            <td><%= res.getString("requirements") %><br><br><%= res.getString("description") %></td>
            <td><%= res.getString("deadline") %></td>
            <td><span class="status-badge status-accepted">Accepted</span></td>
        </tr>
        <%
                }
                if (!hasData) {
        %>
            <tr><td colspan="8" class="no-data">No accepted projects found.</td></tr>
        <%
                }
                res.close(); ps.close(); con.close();
            } catch (Exception e) {
        %>
            <tr><td colspan="8" class="error-message">Error: <%= e.getMessage() %></td></tr>
        <%
            }
        %>
        </tbody>
    </table>

    <!-- ===================== REJECTED PROJECTS ===================== -->
    <table id="rejected" class="tab-content">
        <thead>
        <tr>
            <th>SL.no</th>
            <th>Client Name</th>
            <th>Email</th>
            <th>Phone No</th>
            <th>Title</th>
            <th>Requirements &amp; Description</th>
            <th>Deadline</th>
            <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                int slno = 0;
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = new dbconfig().getConnection();
                PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM requirements WHERE LOWER(status)='rejected'"
                );
                ResultSet res = ps.executeQuery();
                boolean hasData = false;
                while (res.next()) { hasData = true; slno++;
        %>
        <tr>
            <td><%= slno %></td>
            <td><%= res.getString("cname") %></td>
            <td><%= res.getString("email") %></td>
            <td><%= res.getString("phono") %></td>
            <td><%= res.getString("title") %></td>
            <td><%= res.getString("requirements") %><br><br><%= res.getString("description") %></td>
            <td><%= res.getString("deadline") %></td>
            <td><span class="status-badge status-rejected">Rejected</span></td>
        </tr>
        <%
                }
                if (!hasData) {
        %>
            <tr><td colspan="8" class="no-data">No rejected projects found.</td></tr>
        <%
                }
                res.close(); ps.close(); con.close();
            } catch (Exception e) {
        %>
            <tr><td colspan="8" class="error-message">Error: <%= e.getMessage() %></td></tr>
        <%
            }
        %>
        </tbody>
    </table>

</div>

<!-- ===================== JS ===================== -->
<script>

    /* ---- Tab switching ---- */
    document.querySelectorAll('.tab').forEach(tab => {
        tab.addEventListener('click', () => {
            document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
            tab.classList.add('active');
            document.getElementById(tab.dataset.tab).classList.add('active');
        });
    });

    /* ---- Alert box ---- */
    let _redirectUrl = '';
    let _timer       = null;

    function showAlert(type, url, clientName) {
        _redirectUrl = url;

        const isAccept = (type === 'accept');

        /* fill content */
        document.getElementById('alertBanner').className   = 'alert-banner ' + (isAccept ? 'green' : 'red');
        document.getElementById('alertIcon').textContent    = isAccept ? '✅' : '❌';
        document.getElementById('alertTitle').textContent   = isAccept ? 'Project Accepted!' : 'Project Rejected!';
        document.getElementById('alertSubtitle').textContent= isAccept ? 'Successfully accepted' : 'Marked as rejected';
        document.getElementById('alertClient').textContent  = clientName;
        document.getElementById('alertDetail').textContent  = isAccept
            ? 'The project has been accepted successfully. The client will be notified.'
            : 'The project has been rejected. This action has been recorded in the system.';
        document.getElementById('alertOkBtn').className     = 'alert-ok ' + (isAccept ? 'green' : 'red');

        /* reset & restart progress bar animation */
        const bar = document.getElementById('alertBar');
        bar.className = '';
        void bar.offsetWidth; /* force reflow to restart animation */
        bar.className = 'alert-progress-fill ' + (isAccept ? 'green' : 'red');

        /* show overlay */
        document.getElementById('alertOverlay').classList.add('show');

        /* auto-redirect after 2.5s */
        clearTimeout(_timer);
        _timer = setTimeout(closeAndGo, 2500);
    }

    function closeAndGo() {
        clearTimeout(_timer);
        document.getElementById('alertOverlay').classList.remove('show');
        if (_redirectUrl) window.location.href = _redirectUrl;
    }

</script>

</body>
</html>