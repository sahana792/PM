<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="clientheader.jsp" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Project Management</title>

    <link rel="stylesheet" href="assets/vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="assets/vendors/flag-icon-css/css/flag-icon.min.css">
    <link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="assets/vendors/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" href="assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="shortcut icon" href="assets/images/favicon.png" />

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f6fa;
            margin: 0;
            padding: 0;
        }

        /* Stack domain containers vertically */
        .domains-column {
            display: flex;
            flex-direction: column;
            gap: 50px;
            max-width: 1200px;
            margin: 50px auto;
        }

        .domain-container {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .domain-title {
            font-size: 1.8em;
            text-align: center;
            margin-bottom: 25px;
            color: #151542;
            font-weight: bold;
        }

        .project-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            justify-content: center;
        }

        .project-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
            overflow: hidden;
            width: 350px;
            height: 350px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .project-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.2);
        }

        .project-image {
            width: 100%;
            height: 170px;
            object-fit: cover;
        }

        .project-info {
            padding: 20px;
        }

        .project-name {
            font-size: 1.4em;
            color: #007bff;
            margin: 10px 0;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .project-links a {
            display: inline-block;
            padding: 8px 12px;
            margin: 20px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .demo-btn { background-color: #28a745; color: white; border: 2px solid #28a745; }
        .demo-btn:hover { background-color: #218838; }

        .download-btn { background-color: #ffc107; color: #333; border: 2px solid #ffc107; }
        .download-btn:hover { background-color: #e0a800; }

        .buy-btn { 
            background-color: #ff5722; 
            color: white; 
            border: 2px solid #ff5722; 
            padding: 8px 15px; 
            border-radius: 5px; 
            font-weight: bold; 
            margin-top: 5px;
        }
        .buy-btn:hover { background-color: #e64a19; }

    </style>
</head>

<body>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    boolean hasPaidClinic = false;
    boolean hasPaidEcom = false;

    if (userEmail != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdb", "root", "password");

            PreparedStatement ps = con.prepareStatement(
                "SELECT project_name FROM purchases WHERE user_email=? AND payment_status='SUCCESS'");
            ps.setString(1, userEmail);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String proj = rs.getString("project_name");
                if ("Clinic".equalsIgnoreCase(proj)) hasPaidClinic = true;
                if ("Ecom".equalsIgnoreCase(proj)) hasPaidEcom = true;
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<div class="domains-column">

    <!-- Clinic Domain -->
    <div class="domain-container">
        <div class="domain-title">🏥 Clinic Domain Projects</div>
        <div class="project-grid">
            <!-- Project 1 -->
            <div class="project-card">
                <img src="assets/images/SDC.png" alt="Clinic Project 1" class="project-image">
                <div class="project-info">
                    <div class="project-name">Clinic Website 1</div>
                    <div class="project-links">
                        <a href="https://sahana792.github.io/Shashank-dental-clinic/" class="demo-btn" target="_blank">Demo</a>
                        <% if (hasPaidClinic) { %>
                            <a href="https://drive.google.com/drive/folders/1mVpyy62mcp7x1tlDTzi2g5ukpQS81eu7" class="download-btn">Download</a>
                        <% } %>
                    </div>
                    <a href="https://drive.google.com/drive/folders/1mVpyy62mcp7x1tlDTzi2g5ukpQS81eu7" class="buy-btn">Download</a>
                </div>
            </div>
                    
                    <!-- Project 2 -->
            <div class="project-card">
                <img src="assets/images/SDC.png" alt="Clinic Project 1" class="project-image">
                <div class="project-info">
                    <div class="project-name">Clinic Website 1</div>
                    <div class="project-links">
                        <a href="https://sahana792.github.io/Shashank-dental-clinic/" class="demo-btn" target="_blank">Demo</a>
                        <% if (hasPaidClinic) { %>
                            <a href="https://drive.google.com/drive/folders/1mVpyy62mcp7x1tlDTzi2g5ukpQS81eu7" class="download-btn">Download</a>
                        <% } %>
                    </div>
                    <a href="https://drive.google.com/drive/folders/1mVpyy62mcp7x1tlDTzi2g5ukpQS81eu7" class="buy-btn">Download</a>
                </div>
            </div>
                    
                    <!-- Project 3 -->
            <div class="project-card">
                <img src="assets/images/SDC.png" alt="Clinic Project 1" class="project-image">
                <div class="project-info">
                    <div class="project-name">Clinic Website 1</div>
                    <div class="project-links">
                        <a href="https://sahana792.github.io/Shashank-dental-clinic/" class="demo-btn" target="_blank">Demo</a>
                        <% if (hasPaidClinic) { %>
                            <a href="https://drive.google.com/drive/folders/1mVpyy62mcp7x1tlDTzi2g5ukpQS81eu7" class="download-btn">Download</a>
                        <% } %>
                    </div>
                    <a href="https://drive.google.com/drive/folders/1mVpyy62mcp7x1tlDTzi2g5ukpQS81eu7" class="buy-btn">Download</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Business Domain -->
    <div class="domain-container">
        <div class="domain-title">💼 Business Domain Projects</div>
        <div class="project-grid">
            <!-- Project 1 -->
            <div class="project-card"> 
                <img src="assets/images/Ecom.png" alt="Business Project 1" class="project-image"> 
                <div class="project-info"> 
                    <div class="project-name">Ecommerce Website</div> 
                    <div class="project-links"> 
                        <a href="[Link to Live Demo]" class="demo-btn" target="_blank">Demo</a> 
                        <% if (hasPaidEcom) { %> 
                        <a href="https://drive.google.com/drive/folders/13C6RLfnKz-5tg4QrJqsMQi7jrFVTz-Wo" class="download-btn">Download</a> 
                        <% } %> 
                    </div> 
                        <a href="https://drive.google.com/drive/folders/13C6RLfnKz-5tg4QrJqsMQi7jrFVTz-Wo" class="buy-btn">Download</a> 
                </div> 
            </div>  
                   
                    <!-- Project 2 -->
                    <div class="project-card"> 
                <img src="assets/images/Ecom.png" alt="Business Project 1" class="project-image"> 
                <div class="project-info"> 
                    <div class="project-name">Ecommerce Website</div> 
                    <div class="project-links"> 
                        <a href="[Link to Live Demo]" class="demo-btn" target="_blank">Demo</a> 
                        <% if (hasPaidEcom) { %> 
                        <a href="https://drive.google.com/drive/folders/13C6RLfnKz-5tg4QrJqsMQi7jrFVTz-Wo" class="download-btn">Download</a> 
                        <% } %> 
                    </div> 
                        <a href="https://drive.google.com/drive/folders/13C6RLfnKz-5tg4QrJqsMQi7jrFVTz-Wo" class="buy-btn">Download</a> 
                </div> 
            </div> 
                    <!-- Project 3 -->
                    <div class="project-card"> 
                <img src="assets/images/Ecom.png" alt="Business Project 1" class="project-image"> 
                <div class="project-info"> 
                    <div class="project-name">Ecommerce Website</div> 
                    <div class="project-links"> 
                        <a href="[Link to Live Demo]" class="demo-btn" target="_blank">Demo</a> 
                        <% if (hasPaidEcom) { %> 
                        <a href="https://drive.google.com/drive/folders/13C6RLfnKz-5tg4QrJqsMQi7jrFVTz-Wo" class="download-btn">Download</a> 
                        <% } %> 
                    </div> 
                        <a href="https://drive.google.com/drive/folders/13C6RLfnKz-5tg4QrJqsMQi7jrFVTz-Wo" class="buy-btn">Download</a> 
                </div> 
            </div> 
        </div>
    </div>

</div>

</body>
</html>
