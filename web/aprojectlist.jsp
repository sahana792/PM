
<%@ include file="adminheader.jsp" %>
<%@page import="database.dbconfig"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            width: calc(100vw - 250px); /* Adjust 250px to your sidebar width */
            padding: 15px 20px;
            margin-left: 150px; /* Adjust if sidebar width changes */
            background-color: #fff;
            overflow-x: visible;
        }

        h2 {
            display: block;
            text-align: center;
            color: #151542;
            font-weight: 700;
            font-size: 2rem;
            margin: 0 auto 20px auto;
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
            transition: all 0.3s ease;
            text-align: center;
            flex-grow: 1;
        }

        .tab.active {
            color: #151542;
            border-bottom: 3px solid #151542;
        }

        .tab:hover {
            background-color: #f0f0f0;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            table-layout: auto;
        }

        th, td {
            padding: 10px 12px;
            border: 1px solid #dee2e6;
            text-align: left;
            vertical-align: top;
            word-wrap: break-word;
        }

        th {
            background-color: #151542;
            color: white;
            font-weight: 600;
        }

        tr:nth-child(even) { 
            background-color: #f8f9fa; 
        }
        
        tr:hover { 
            background-color: #e9ecef; 
        }

        .btn {
            padding: 6px 12px;
            border-radius: 5px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            margin: 2px 2px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .btn-success { 
            background-color: #28a745; 
            color: white; 
        }
        
        .btn-success:hover {
            background-color: #218838;
        }
        
        .btn-danger { 
            background-color: #dc3545; 
            color: white; 
        }
        
        .btn-danger:hover {
            background-color: #c82333;
        }
        
        .btn-info { 
            background-color: #17a2b8; 
            color: white; 
        }
        
        .btn-info:hover {
            background-color: #138496;
        }
        
        .btn-disabled { 
            background-color: #ccc; 
            color: #666; 
            cursor: not-allowed; 
            opacity: 0.6;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 5px;
            font-weight: 600;
            display: inline-block;
            font-size: 13px;
        }
        
        .status-pending { 
            background-color: #ffc107; 
            color: black; 
        }
        
        .status-accepted { 
            background-color: #28a745; 
            color: white; 
        }
        
        .status-rejected { 
            background-color: #dc3545; 
            color: white; 
        }

        .tab-content { 
            display: none; 
        }
        
        .tab-content.active { 
            display: table; 
        }

        /* Collapsible details column */
        .details-preview { 
            text-align: left;
            max-width: 300px;
        }
        
        .toggle-btn {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1.2em;
            margin-left: 5px;
            color: #151542;
            font-weight: bold;
            padding: 0 5px;
        }
        
        .toggle-btn:hover {
            background-color: #e9ecef;
            border-radius: 3px;
        }

        .short-text, .full-text {
            display: inline-block;
        }

        .no-data {
            text-align: center;
            padding: 30px;
            color: #666;
            font-style: italic;
        }

        .error-message {
            color: red;
            text-align: center;
            padding: 20px;
            background-color: #ffe6e6;
            border-radius: 5px;
            margin: 10px 0;
        }

        .action-buttons {
            white-space: nowrap;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Client Requirements</h2>

   
             
   
   <!-- Accepted Projects -->
<table class="tab-container">
    <thead>
        <tr>
            <th>SL.no</th>
            <th>Client Name</th>
            <th>Email</th>
            <th>Phone No</th>
            <th>Title</th>
            <th>Requirements & Description</th>
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

            String sql = "SELECT * FROM requirements WHERE LOWER(status) = 'accepted'";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet res = ps.executeQuery();

            boolean hasData = false;
            while (res.next()) {
                hasData = true;
                slno++;

                String cname = res.getString("cname");
                String email = res.getString("email");
                String phono = res.getString("phono");
                String title = res.getString("title");
                String requirements = res.getString("requirements");
                String description = res.getString("description");
                String deadline = res.getString("deadline");
                String id = res.getString("id");

                String reqShort = requirements.length() > 50 ? requirements.substring(0,50) + "..." : requirements;
                String descShort = description.length() > 50 ? description.substring(0,50) + "..." : description;
    %>
        <tr>
            <td><%= slno %></td>
            <td><%= cname %></td>
            <td><%= email %></td>
            <td><%= phono %></td>
            <td><%= title %></td>
            <td>
                <div class="details-preview">
                    <span class="short-text">
                        <strong>Req:</strong> <%= reqShort %><br>
                        <strong>Desc:</strong> <%= descShort %>
                    </span>
                    <span class="full-text" style="display:none;">
                        <strong>Requirements:</strong> <%= requirements %><br><br>
                        <strong>Description:</strong> <%= description %>
                    </span>
                    <button class="toggle-btn" onclick="toggleDetails(this)" title="Show more">⌄</button>
                </div>
            </td>
            <td><%= deadline %></td>
            <td><span class="status-badge status-accepted">Accepted</span></td>
            
        </tr>
    <%
            }

            if(!hasData) {
    %>
        <tr><td colspan="9" class="no-data">No accepted projects found.</td></tr>
    <%
            }

            res.close();
            ps.close();
            con.close();
        } catch(Exception e){
    %>
        <tr><td colspan="9" class="error-message">Error: <%= e.getMessage() %></td></tr>
    <%
        }
    %>
    </tbody>
</table>

  
</div>

<script>
    // Tab switching
    const tabs = document.querySelectorAll('.tab');
    const tables = document.querySelectorAll('.tab-content');

    tabs.forEach(tab => {
        tab.addEventListener('click', () => {
            tabs.forEach(t => t.classList.remove('active'));
            tables.forEach(table => table.classList.remove('active'));
            tab.classList.add('active');
            document.getElementById(tab.getAttribute('data-tab')).classList.add('active');
        });
    });

    // Toggle details
    function toggleDetails(btn) {
        const parent = btn.parentElement;
        const shortText = parent.querySelector('.short-text');
        const fullText = parent.querySelector('.full-text');

        if (fullText.style.display === "none" || fullText.style.display === "") {
            fullText.style.display = "inline";
            shortText.style.display = "none";
            btn.textContent = "⌃"; // Chevron up
            btn.title = "Show less";
        } else {
            fullText.style.display = "none";
            shortText.style.display = "inline";
            btn.textContent = "⌄"; // Chevron down
            btn.title = "Show more";
        }
    }
</script>
</body>
</html>