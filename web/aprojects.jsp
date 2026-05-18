<%-- 
    Document   : home
    Created on : 29 Oct, 2025, 6:10:27 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="adminheader.jsp" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Project Management</title>

    <!-- plugins:css -->
    <link rel="stylesheet" href="assets/vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="assets/vendors/flag-icon-css/css/flag-icon.min.css">
    <link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="assets/vendors/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" href="assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="shortcut icon" href="assets/images/favicon.png" />

    <style>
        /* Grid for Cards */
        .project-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 50px;
            justify-content: center;
        }

        .project-card {
            background: white;
            margin-left: 50px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
            overflow: hidden;
            width: 400px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .project-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.2);
        }

        .project-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .project-info {
            padding: 15px;
        }

        .project-name {
            font-size: 1.4em;
            color: #007bff;
            margin: 10px 0;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .project-links a {
            display: inline-block;
            padding: 10px 15px;
            margin: 5px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .demo-btn {
            background-color: #28a745;
            color: white;
            border: 2px solid #28a745;
        }

        .demo-btn:hover {
            background-color: #218838;
        }

        .download-btn {
            background-color: #ffc107;
            color: #333;
            border: 2px solid #ffc107;
        }

        .download-btn:hover {
            background-color: #e0a800;
        }

        .project-price {
            color: #333;
            font-size: 18px;
            font-weight: 600;
            margin-top: 10px;
        }

        .buy-btn {
            background-color: #ff5722;
            color: white;
            border: 2px solid #ff5722;
            padding: 10px 20px;
            display: inline-block;
            border-radius: 5px;
            margin-top: 10px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .buy-btn:hover {
            background-color: #e64a19;
        }

        .purchased-label {
            color: green;
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }
    </style>
</head>

<body>
<%
    // Check if user is logged in
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

<center>
    <div class="container">
        <h1 style="color: black; text-align: center;margin-left: 400px;">Project Demos</h1>
        <p style="text-align: center; margin-bottom: 30px; margin-left: 400px;color: black;">
            Click on the demo links to see the application in action and download to see the files.
        </p>

        <div class="project-grid">

            <!-- ✅ Project 1: Clinic Website -->
            <div class="project-card">
                <img src="assets/images/SDC.png" alt="Clinic Project Screenshot" class="project-image">
                <div class="project-info">
                    <div class="project-name">Clinic Website</div>
                    <div class="project-links">

                        <a href="https://sahana792.github.io/Shashank-dental-clinic/" class="demo-btn" target="_blank">Demo</a>
                        <br>
                        <br>
                        <!-- ⭐ Always visible Folder Link -->
                        <!---<a href="https://drive.google.com/drive/folders/1mVpyy62mcp7x1tlDTzi2g5ukpQS81eu7"
                           class="download-btn" target="_blank">Open Folder</a>---->

                        <% if (hasPaidClinic) { %>
                            <!---<a href="https://drive.google.com/drive/folders/1mVpyy62mcp7x1tlDTzi2g5ukpQS81eu7"
                               class="download-btn">Download</a>---->
                        <% } %>

                    </div>
                </div>
            </div>

            <!-- ✅ Project 2: Ecommerce Website -->
            <div class="project-card">
                <img src="assets/images/Ecom.png" alt="Ecommerce Project Screenshot" class="project-image">
                <div class="project-info">
                    <div class="project-name">Ecommerce Website</div>
                    <div class="project-links">

                        <a href="[Link to Live Demo]" class="demo-btn" target="_blank">Demo</a>
                        <br>
                        <br>

                        <!-- ⭐ Always visible Folder Link -->
                       <!--- <a href="https://drive.google.com/drive/folders/13C6RLfnKz-5tg4QrJqsMQi7jrFVTz-Wo"
                           class="download-btn" target="_blank">Open Folder</a>---->

                        <% if (hasPaidEcom) { %>
                            <!---<a href="https://drive.google.com/drive/folders/13C6RLfnKz-5tg4QrJqsMQi7jrFVTz-Wo"
                               class="download-btn">Download</a>---->
                        <% } %>

                    </div>
                </div>
            </div>

        </div>
    </div>
</center>
</body>
</html>