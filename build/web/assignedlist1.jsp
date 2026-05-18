<%@page import="database.dbconfig"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="adminheader.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View All Employees</title>
        <style>
        center {
            width: 100%;
            max-width: 1400px;
            margin: 20px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            text-align: center;
        }

        h1, h4 {
            color: #343a40;
            margin-bottom: 25px;
            font-size: 2em;
            border-bottom: 2px solid #28a745;
            padding-bottom: 10px;
        }

        .summary-stats {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-box {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }

        .stat-label {
            color: white;
            font-size: 14px;
            text-transform: uppercase;
            margin-bottom: 5px;
        }

        .stat-value {
            color: white;
            font-size: 32px;
            font-weight: bold;
        }

        /* Status Badge */
        .status-badge {
            padding: 6px 12px;
            border-radius: 5px;
            font-weight: 600;
            display: inline-block;
            font-size: 0.9em;
        }

        .role-manager {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .role-developer {
            background-color: #d4edda;
            color: #155724;
        }

        .role-designer {
            background-color: #fff3cd;
            color: #856404;
        }

        .role-tester {
            background-color: #f8d7da;
            color: #721c24;
        }

        .role-default {
            background-color: #e7f3ff;
            color: #004085;
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 1.1em;
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

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 12px;
            border: 1px solid #dee2e6;
            text-align: left;
            word-wrap: break-word;
            overflow-wrap: break-word;
        }

        table th {
            background-color: #151542;
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 13px;
        }

        table tr:nth-child(even) { 
            background-color: #f8f9fa; 
        }
        
        table tr:hover { 
            background-color: #e9ecef; 
        }

        table td {
            font-size: 14px;
            color: #333;
        }
        </style>
    </head>

    <body>
        <center>
            <h4 class="card-title">👥 All Employees</h4>

            <%
                int totalEmployees = 0;
                double totalSalary = 0;
                
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection countCon = new dbconfig().getConnection();
                    Statement countStat = countCon.createStatement();
                    ResultSet countRes = countStat.executeQuery("SELECT COUNT(*) as total, SUM(CAST(salary AS UNSIGNED)) as totalsalary FROM employee");
                    if(countRes.next()) {
                        totalEmployees = countRes.getInt("total");
                        totalSalary = countRes.getDouble("totalsalary");
                    }
                    countRes.close();
                    countStat.close();
                    countCon.close();
                } catch(Exception e) {
                    out.println("<div class='error-message'>Error getting statistics: " + e.getMessage() + "</div>");
                }
            %>

            <div class="summary-stats">
                <div class="stat-box">
                    <div class="stat-label">Total Employees</div>
                    <div class="stat-value"><%= totalEmployees %></div>
                </div>
                <div class="stat-box">
                    <div class="stat-label">Total Salary</div>
                    <div class="stat-value">₹<%= String.format("%,.0f", totalSalary) %></div>
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Employee ID</th>
                        <th>Name</th>
                        <th>Phone Number</th>
                        <th>Age</th>
                        <th>Role</th>
                        <th>Salary</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = new dbconfig().getConnection();
                            Statement stat = con.createStatement();
                            ResultSet rs = stat.executeQuery("SELECT mid, name, phono, age, roles, salary FROM employee ORDER BY name ASC");
                            
                            boolean hasData = false;
                            while(rs.next()) {
                                hasData = true;
                                String mid = rs.getString("mid");
                                String name = rs.getString("name");
                                String phono = rs.getString("phono");
                                String age = rs.getString("age");
                                String roles = rs.getString("roles");
                                String salary = rs.getString("salary");
                                
                                // Determine role badge class
                                String roleClass = "status-badge role-default";
                                if(roles != null) {
                                    String roleLower = roles.toLowerCase();
                                    if(roleLower.contains("manager")) roleClass = "status-badge role-manager";
                                    else if(roleLower.contains("developer")) roleClass = "status-badge role-developer";
                                    else if(roleLower.contains("designer")) roleClass = "status-badge role-designer";
                                    else if(roleLower.contains("tester")) roleClass = "status-badge role-tester";
                                }
                    %>
                    <tr>
                        <td><strong><%= mid %></strong></td>
                        <td><%= name %></td>
                        <td><%= phono %></td>
                        <td><%= age %></td>
                        <td><span class="<%= roleClass %>"><%= roles %></span></td>
                        <td>₹<%= salary %></td>
                    </tr>
                    <%
                            }
                            
                            if(!hasData) {
                    %>
                    <tr>
                        <td colspan="6" class="no-data">
                            No employees found in the database
                        </td>
                    </tr>
                    <%
                            }
                            
                            rs.close();
                            stat.close();
                            con.close();
                        } catch(Exception e) {
                    %>
                    <tr>
                        <td colspan="6" class="error-message">
                            Error loading employees: <%= e.getMessage() %>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </center>
    </body>
</html>