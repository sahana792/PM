<%@page import="java.sql.*"%>
<%@page import="database.dbconfig"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="adminheader.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Attendance List</title>

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 90%;
            margin: 50px auto;
            background: #ffffff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #333333;
            margin-bottom: 30px;
            border-bottom: 3px solid #007bff;
            padding-bottom: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            border: 2px solid #007bff;
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

        tr:nth-child(even) {
            background-color: #f4f9ff;
        }

        tr:hover {
            background-color: #e7f1ff;
        }

        .filter-box {
            margin-bottom: 20px;
            text-align: center;
        }

        .filter-box input {
            padding: 8px;
            font-size: 15px;
            margin: 5px;
        }

        .filter-btn {
            padding: 8px 18px;
            background: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }

        .filter-btn:hover {
            background: #0056cc;
        }

        .chart-container {
            width: 100%;
            margin: 30px 0;
        }
    </style>
</head>

<body>

    <div class="container" >
        <h2>Daily Employee Attendance</h2>

        <!-- Filter Form -->
        <form method="get" class="filter-box">
            <label>From: </label>
            <input type="date" name="from" required>
            <label>To: </label>
            <input type="date" name="to" required>
            <button type="submit" class="filter-btn">Filter</button>
        </form>

        <!-- Graph Data Fetch -->
        <%
            StringBuilder dates = new StringBuilder("[");
            StringBuilder counts = new StringBuilder("[");

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con2 = new dbconfig().getConnection();

                String from = request.getParameter("from");
                String to = request.getParameter("to");

                String graphQuery = "";

                if (from != null && to != null) {
                    graphQuery = "SELECT date, COUNT(*) AS total FROM employeeattendance " +
                                 "WHERE date BETWEEN '" + from + "' AND '" + to + "' " +
                                 "GROUP BY date ORDER BY date ASC";
                } else {
                    graphQuery = "SELECT date, COUNT(*) AS total FROM employeeattendance " +
                                 "GROUP BY date ORDER BY date ASC";
                }

                Statement st2 = con2.createStatement();
                ResultSet rs2 = st2.executeQuery(graphQuery);

                while (rs2.next()) {
                    dates.append("'").append(rs2.getString("date")).append("',");
                    counts.append(rs2.getInt("total")).append(",");
                }

                if (dates.length() > 1) dates.setLength(dates.length() - 1);
                if (counts.length() > 1) counts.setLength(counts.length() - 1);

                dates.append("]");
                counts.append("]");

                con2.close();

            } catch (Exception e) {
                out.println("Error: " + e);
            }
        %>

        <!-- Attendance Chart -->
        <div class="chart-container">
            <canvas id="attendanceChart"></canvas>
        </div>

        <script>
            const ctx = document.getElementById('attendanceChart').getContext('2d');

            new Chart(ctx, {
                type: 'line',   // Change to "bar" if you want a bar chart
                data: {
                    labels: <%= dates.toString() %>,
                    datasets: [{
                        label: 'Daily Login Count',
                        data: <%= counts.toString() %>,
                        borderColor: '#007bff',
                        backgroundColor: 'rgba(0, 123, 255, 0.2)',
                        borderWidth: 2,
                        fill: true,
                        tension: 0.3
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: { display: true, text: 'Employees Logged In' }
                        },
                        x: {
                            title: { display: true, text: 'Date' }
                        }
                    }
                }
            });
        </script>

        <!-- Attendance Table -->
        <table>
            <tr>
                <th>Sl no</th>
                <th>Employee ID</th>
                <th>Name</th>
                <th>Date</th>
                <th>Login Time</th>
            </tr>

            <%
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = new dbconfig().getConnection();
                    
                    String from = request.getParameter("from");
                    String to = request.getParameter("to");

                    String query = "";

                    if (from != null && to != null) {
                        query = "SELECT * FROM employeeattendance WHERE date BETWEEN '" +
                                 from + "' AND '" + to + "' ORDER BY date DESC, logintime DESC";
                    } else {
                        query = "SELECT * FROM employeeattendance ORDER BY date DESC, logintime DESC";
                    }

                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery(query);

                    int count = 1;

                    while(rs.next()) {
            %>

            <tr>
                <td><%= count++ %></td>
                <td><%= rs.getString("mid") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("date") %></td>
                <td><%= rs.getString("logintime") %></td>
            </tr>

            <%  }

                con.close();
            } catch(Exception e) {
                out.println("<tr><td colspan='5'>Error: " + e + "</td></tr>");
            }
            %>
        </table>
    </div>

</body>
</html>
