<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%
    // Get project info from query string
    String project = request.getParameter("project");
    String price = request.getParameter("price");

    if (project == null || price == null) {
        out.println("<h3>Invalid request</h3>");
        return;
    }

    String payeeName = "sahana niranjan"; // Your UPI payee name
    String upiId = "sahananiranjan8@okbank"; // Your UPI ID

    // Generate UPI payment link
    String upiLink = "upi://pay?pa=" + URLEncoder.encode(upiId, "UTF-8")
            + "&pn=" + URLEncoder.encode(payeeName, "UTF-8")
            + "&am=" + price
            + "&cu=INR"
            + "&tn=" + URLEncoder.encode(project, "UTF-8");

    // ✅ Google Drive folder link for Clinic
    String folderLink = "";
    if ("Clinic".equalsIgnoreCase(project)) {
        folderLink = "https://drive.google.com/drive/folders/1mVpyy62mcp7x1tlDTzi2g5ukpQS81eu7";
    } else if ("Ecom".equalsIgnoreCase(project)) {
        folderLink = "https://drive.google.com/drive/folders/13C6RLfnKz-5tg4QrJqsMQi7jrFVTz-Wo";
    }
%>

<jsp:include page="clientheader.jsp" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buy <%= project %></title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7ff;
            margin: 0;
            padding: 0;
        }

        .payment-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-left: 150px;
            text-align: center;
            min-height: 90vh;
            padding: 30px;
        }

        .payment-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
            padding: 40px;
            max-width: 700px;
            width: 90%;
        }

        h2 {
            color: #333;
            font-size: 26px;
            margin-bottom: 10px;
        }

        h2 span {
            color: #007bff;
        }

        p {
            color: #555;
            font-size: 16px;
            margin-bottom: 25px;
        }

        .qr-section {
            display: flex;
            align-items: center;
            justify-content: space-around;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .qr-box {
            text-align: center;
        }

        img.qr {
            width: 250px;
            height: 250px;
            border: 5px solid #eee;
            border-radius: 10px;
        }

        .upi-info {
            margin-top: 10px;
            color: #444;
            font-size: 15px;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 6px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            font-size: 16px;
            transition: 0.3s;
            margin: 10px;
        }

        .pay-btn {
            background-color: #ff5722;
        }
        .pay-btn:hover {
            background-color: #e64a19;
        }

        .download-btn {
            background-color: #28a745;
        }
        .download-btn:hover {
            background-color: #218838;
        }

        @media (max-width: 600px) {
            .qr-section {
                flex-direction: column;
                gap: 20px;
            }
            img.qr {
                width: 220px;
                height: 220px;
            }
        }
    </style>
</head>
<body>
<center>
    <div class="payment-container">
        <div class="payment-card">
            <h2>Buy <span><%= project %></span> — ₹<%= price %></h2>
            <p>Click the QR code to pay via UPI, or use the Pay button below.</p>

            <div class="qr-section">
                <div class="qr-box">
                    <img class="qr" src="assets/images/qrcode.jpg" alt="UPI QR Code">
                    <div class="upi-info">
                        <strong><%= payeeName %></strong><br>
                        UPI ID: <%= upiId %>
                    </div>
                </div>

                <div class="action-box">
                    <a href="<%= upiLink %>">
                        <button class="btn pay-btn">Pay Now</button>
                    </a>
                    <br>
                    <p style="margin-top: 15px;">After payment, open your project folder:</p>

                    <!-- ✅ Updated Folder Access Button -->
                    <a href="<%= folderLink %>" target="_blank">
                        <button class="btn download-btn">Open Folder</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
</center>
</body>
</html>
