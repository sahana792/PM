<%@page import="java.sql.*"%>
<%@page import="database.dbconfig"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="mhome.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manager Dashboard</title>

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 90%;
            margin: 30px auto;
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2, h3 {
            text-align: center;
            color: #333;
            border-bottom: 3px solid #007bff;
            padding-bottom: 10px;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            border-radius: 6px;
            overflow: hidden;
        }

        th, td {
            border: 1px solid #b5b5b5;
            padding: 12px;
            text-align: center;
            font-size: 15px;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) { background-color: #f4f9ff; }
        tr:hover { background-color: #e7f1ff; }

        .chart-container {
            width: 100%;
            max-width: 900px;
            margin: 30px auto;
        }

        .filter-box label {
            font-weight: bold;
            margin-right: 5px;
        }

        .filter-box input {
            padding: 6px;
            margin: 0 10px;
            border: 1px solid #007bff;
            border-radius: 4px;
        }

        .filter-box button {
            padding: 7px 15px;
            background:#007bff;
            color:white;
            border:none;
            border-radius:4px;
            cursor:pointer;
        }
    </style>
</head>

<body>

<!-- =============================================================== -->
<!-- 1️⃣ EMPLOYEE ATTENDANCE GRAPH (BEAUTIFUL DESIGN) -->
<!-- =============================================================== -->

<div class="container">
    <h2>Daily Employee Attendance</h2>

    <!-- Filter Form -->
    <form method="get" class="filter-box" style="text-align:center; margin-bottom:20px;">
        <label>From:</label>
        <input type="date" name="from" required>
        <label>To:</label>
        <input type="date" name="to" required>
        <button type="submit">Filter</button>
    </form>

    <%
        StringBuilder dates = new StringBuilder("[");
        StringBuilder counts = new StringBuilder("[");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = new dbconfig().getConnection();

            String from = request.getParameter("from");
            String to = request.getParameter("to");

            String query = (from != null && to != null)
                ? "SELECT date, COUNT(*) AS total FROM employeeattendance WHERE date BETWEEN '" 
                    + from + "' AND '" + to + "' GROUP BY date ORDER BY date ASC"
                : "SELECT date, COUNT(*) AS total FROM employeeattendance GROUP BY date ORDER BY date ASC";

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(query);

            while(rs.next()) {
                dates.append("'").append(rs.getString("date")).append("',");
                counts.append(rs.getInt("total")).append(",");
            }

            if (dates.length() > 1) dates.setLength(dates.length() - 1);
            if (counts.length() > 1) counts.setLength(counts.length() - 1);

            dates.append("]");
            counts.append("]");

            con.close();

        } catch(Exception e) {
            out.println("<p style='color:red;'>Error: "+e+"</p>");
        }
    %>

    <!-- Beautiful Gradient Chart -->
    <div class="chart-container">
        <canvas id="attendanceChart"></canvas>
    </div>

    <script>
        const ctx = document.getElementById("attendanceChart").getContext("2d");

        // Gradient background
        const gradient = ctx.createLinearGradient(0, 0, 0, 400);
        gradient.addColorStop(0, "rgba(0, 123, 255, 0.8)");
        gradient.addColorStop(1, "rgba(0, 123, 255, 0.2)");

        new Chart(ctx, {
            type: "bar",
            data: {
                labels: <%= dates.toString() %>,
                datasets: [{
                    label: "Employees Present",
                    data: <%= counts.toString() %>,
                    backgroundColor: gradient,
                    borderColor: "#0056D6",
                    borderWidth: 2,
                    borderRadius: 8,
                    hoverBackgroundColor: "rgba(0, 123, 255, 1)"
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    tooltip: {
                        backgroundColor: "#0056d6",
                        titleColor: "#fff",
                        bodyColor: "#fff",
                        padding: 12,
                        borderColor: "#003c99",
                        borderWidth: 1,
                        cornerRadius: 8
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        title: { display: true, text: "No. of Employees" },
                        ticks: { font: { size: 14 } },
                        grid: { color: "rgba(0,0,0,0.05)" }
                    },
                    x: {
                        title: { display: true, text: "Date" },
                        ticks: { font: { size: 14 } },
                        grid: { display: false }
                    }
                },
                animation: {
                    duration: 1500,
                    easing: "easeOutBounce"
                }
            }
        });
    </script>

</div>

<!-- =============================================================== -->
<!-- 2️⃣ UPCOMING PROJECT DEADLINES TABLE (ACCEPTED PROJECTS ONLY) -->
<!-- =============================================================== -->

<div class="container">
    <h3>📅 Upcoming Project Deadlines</h3>

    <table>
        <tr>
            <th>Project Title</th>
            <th>Deadline</th>
        </tr>

        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = new dbconfig().getConnection();
                Statement st = con.createStatement();

                // 🔥 Updated query: use 'requirements' table with 'title' and 'deadline' columns
                ResultSet rs = st.executeQuery(
                    "SELECT title, deadline FROM requirements " +
                    "WHERE deadline > CURDATE() AND status = 'accepted' " +
                    "ORDER BY deadline ASC"
                );

                boolean hasResults = false;
                while(rs.next()) {
                    hasResults = true;
        %>
        <tr>
            <td><%= rs.getString("title") %></td>
            <td style="color:red; font-weight:bold;"><%= rs.getString("deadline") %></td>
        </tr>
        <%
                }
                
                if(!hasResults) {
        %>
        <tr>
            <td colspan="2" style="text-align:center; color:#666;">No upcoming deadlines for accepted projects</td>
        </tr>
        <%
                }
                
                con.close();
            } catch(Exception e) {
                out.println("<tr><td colspan='2' style='color:red;'>Error: "+e+"</td></tr>");
            }
        %>
    </table>
</div>


</body>
</html>
