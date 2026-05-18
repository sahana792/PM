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
        /* Container box */
        .box {
            width: 95%;
            max-width: 1400px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            font-family: 'Poppins', sans-serif;
        }

        /* Heading */
        .box h3 {
            text-align: center;
            color: #151542;
            font-size: 2em;
            margin-bottom: 25px;
            border-bottom: 3px solid #151542;
            display: inline-block;
            padding-bottom: 5px;
        }

        /* Table wrapper */
        .table-wrapper {
            width: 100%;
            overflow-x: hidden; /* Prevent horizontal scroll */
        }

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        th, td {
            border: 1px solid #dee2e6;
            padding: 12px 10px;
            text-align: center;
            word-break: break-word;
        }

        th {
            background-color: #151542;
            color: #ffffff;
            font-weight: 600;
            position: sticky;
            top: 0;
            z-index: 2;
        }

        tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        tr:hover {
            background-color: #e0f0ff;
            transition: background-color 0.3s ease;
        }

        /* Buttons */
        .status-btn, .update-btn {
            padding: 7px 14px;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            font-size: 13px;
            transition: 0.25s ease-in-out;
        }

        .status-btn.ongoing { background-color: #e63946; color: #fff; }
        .status-btn.ongoing:hover { background-color: #d62828; transform: translateY(-2px); }
        .status-btn.completed { background-color: #2a9d8f; color: #fff; }
        .update-btn { background-color: #457b9d; color: white; }
        .update-btn:hover { background-color: #1d3557; transform: translateY(-2px); }

        /* Responsive: mobile-friendly */
        @media (max-width: 1000px) {
            table, thead, tbody, th, td, tr { display: block; }
            thead { display: none; }

            tr {
                margin-bottom: 20px;
                background-color: #fff;
                border-radius: 10px;
                padding: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            }

            td {
                text-align: right;
                padding-left: 50%;
                position: relative;
                border: none;
                border-bottom: 1px solid #eee;
            }

            td:last-child { border-bottom: none; }

            td:before {
                content: attr(data-label);
                position: absolute;
                left: 15px;
                width: 45%;
                font-weight: bold;
                text-align: left;
                color: #151542;
            }
        }
    </style>
</head>

<body>
<div class="box">
    <center><h3>My Assigned Projects</h3></center>

    <div class="table-wrapper">
        <table>
            <tr>
                <th>SL No</th>
                <th>Project ID</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Technology</th>
                <th>MID</th>
                <th>Status</th>
            </tr>

            <%
                try {
                    String mid = (String) session.getAttribute("mid");

                    if (mid == null) {
                        out.println("<tr><td colspan='10' style='color:red;text-align:center;'>Session expired. Please login again.</td></tr>");
                    } else {

                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = new dbconfig().getConnection();
                        Statement st = con.createStatement();
                        String query = "SELECT * FROM mpadd1 WHERE mid='" + mid + "'";
                        ResultSet rs = st.executeQuery(query);

                        int sl = 1;
                        boolean found = false;

                        while (rs.next()) {
                            found = true;
                            String status = rs.getString("status");
            %>

            <tr>
                <td data-label="SL No"><%= sl++ %></td>
                <td data-label="Project ID"><strong>#<%= rs.getInt("project_id") %></strong></td>
                <td data-label="Start Date"><%= rs.getString("startdate") %></td>
                <td data-label="End Date"><%= rs.getString("enddate") %></td>
                <td data-label="Technology"><%= rs.getString("technology") %></td>
               
                <td data-label="MID"><%= rs.getString("mid") %></td>

                <td data-label="Status">
                    <button class="status-btn <%= "Completed".equalsIgnoreCase(status) ? "completed" : "ongoing" %>"
                            <%= "Completed".equalsIgnoreCase(status) ? "disabled" : "" %>
                            onclick="toggleStatus(this, <%= rs.getInt("id") %>)">
                        <%= (status != null && !status.trim().isEmpty()) ? status : "Ongoing" %>
                    </button>
                </td>
            </tr>

            <%
                        }

                        if (!found) {
                            out.println("<tr><td colspan='10' style='text-align:center;color:gray;'>No tasks assigned to you.</td></tr>");
                        }

                        con.close();
                    }

                } catch (Exception e) {
                    out.println("<tr><td colspan='10' style='color:red;'>Error: " + e + "</td></tr>");
                }
            %>
        </table>
    </div>
</div>

<script>
function toggleStatus(btn, id) {
    if(btn.classList.contains('ongoing')) {
        btn.classList.remove('ongoing');
        btn.classList.add('completed');
        btn.textContent = 'Completed';
        btn.disabled = true;

        var xhr = new XMLHttpRequest();
        xhr.open("POST", "updatestatus.jsp", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.send("id=" + id + "&status=Completed");

        xhr.onreadystatechange = function() {
            if(xhr.readyState === 4 && xhr.status !== 200) {
                alert("Failed to update status in database.");
            }
        }
    }
}
</script>

</body>
</html>
