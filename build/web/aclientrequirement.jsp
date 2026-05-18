<%@page import="database.dbconfig"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="adminheader.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Client Requirements</title>

<style>
    .main-content {
        width: 100%;
        max-width: 1200px;
        margin: 5px auto;
        padding: 30px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }

    table { width: 100%; border-collapse: collapse; }
    th {
        background:#151542;
        color:#fff;
        padding:12px;
        border:1px solid #dee2e6;
        text-align:left;
    }
    td {
        padding:10px;
        border:1px solid #dee2e6;
        vertical-align: top;
        font-size:14px;
    }

    tr:nth-child(even){ background:#f8f9fa; }

    /* Req + Desc box */
    .reqdesc-box {
        line-height: 1.4;
        font-size: 14px;
        min-width: 200px;
        position: relative;
    }

    .toggle-arrow {
        cursor: pointer;
        font-size: 18px;
        font-weight: bold;
        color: #151542;
        float: right;
        margin-left: 8px;
    }

    .toggle-arrow:hover {
        color: #000;
    }

    /* Delete Button */
    .btn-delete {
        background:#dc3545;
        color:#fff;
        border:none;
        padding:8px 14px;
        border-radius:5px;
        font-weight:600;
        cursor:pointer;
        width:80px;
    }
</style>

</head>

<body>

<div class="main-content">

<h2 style="color:#151542; text-align:center;">Client Requirements</h2>

<table>
<thead>
<tr>
    <th>SL.no</th>
    <th>Client Name</th>
    <th>Email</th>
    <th>Phone</th>
    <th>Title</th>
    <th>Requirements & Description</th>
    <th>Deadline</th>
    <th>Delete</th>
</tr>
</thead>

<tbody>

<%
try {
    int slno = 0;
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = new dbconfig().getConnection();
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM requirements");

    while (rs.next()) {
        slno++;

        String req = rs.getString("requirements");
        String des = rs.getString("description");

        String reqShort = req.length()>12 ? req.substring(0,12)+"..." : req;
        String desShort = des.length()>12 ? des.substring(0,12)+"..." : des;
%>

<tr>
<td><%= slno %></td>
<td><%= rs.getString("cname") %></td>
<td><%= rs.getString("email") %></td>
<td><%= rs.getString("phono") %></td>
<td><%= rs.getString("title") %></td>

<!-- REQUIREMENTS + DESCRIPTION COLUMN -->
<td>
    <div class="reqdesc-box">
        <!-- SHORT VIEW -->
        <div id="short<%=slno%>">
            <b>Req:</b> <%= reqShort %><br>
            <b>Desc:</b> <%= desShort %>
            <span class="toggle-arrow" onclick="toggle(<%=slno%>)">v</span>
        </div>
        <!-- FULL VIEW -->
        <div id="full<%=slno%>" style="display:none;">
            <b>Requirement:</b> <%= req %><br>
            <b>Description:</b> <%= des %>
            <span class="toggle-arrow" onclick="toggle(<%=slno%>)">^</span>
        </div>
    </div>
</td>

<td><%= rs.getString("deadline") %></td>

<td>
    <form action="clientdel2" method="get"
        onsubmit="return confirm('Are you sure you want to delete this record?');">
        <input type="hidden" name="id" value="<%= rs.getString("id") %>">
        <button class="btn-delete">Delete</button>
    </form>
</td>

</tr>

<%
    }
    con.close();
} catch (Exception e) {
    out.println("<tr><td colspan='8' style='color:red;'>Error: "+e+"</td></tr>");
}
%>

</tbody>
</table>

</div>

<script>
function toggle(id){
    let s = document.getElementById("short" + id);
    let f = document.getElementById("full" + id);

    if(s.style.display === "none"){
        s.style.display = "block";
        f.style.display = "none";
    } else {
        s.style.display = "none";
        f.style.display = "block";
    }
}
</script>

</body>
</html>