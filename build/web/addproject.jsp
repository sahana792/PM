<%-- 
    Document   : addproject
    Created on : 6 Nov, 2025, 6:41:56 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="clientheader.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Project</title>
    </head>
    <body>
  <style>
      /* Ensure header and sidebar line up perfectly */
.app-topstrip {
  background-color: #0d47a1;
  border-bottom: 3px solid #0d47a1;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  z-index: 1000;
}

.page-wrapper {
  display: flex;
  flex-direction: row;
}

#main-wrapper [data-sidebartype="full"] {
  background-color: #0d47a1;
  border-right: 3px solid #0d47a1;
  height: 100vh;
  position: fixed;
  top: 0;
  left: 0;
}

.page-content {
  margin-top: 80px;
  margin-left: 260px;
  padding: 20px;
}

center {
    width: 100%;
    max-width: 500px;
    padding: 30px;
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    margin: 20px auto;
    text-align: left; 
}

h1 {
    color: #333;
    text-align: center;
    margin-bottom: 30px;
    padding-bottom: 10px;
    padding-top: 50px;
    border-bottom: 3px solid #007bff;
}

.addclient {
    margin-bottom: 20px;
    display: flex;
    flex-direction: column;
}

label {
    font-weight: 600;
    color: #495057;
    margin-bottom: 8px;
    text-align: left;
}

input[type="text"],
input[type="email"],
input[type="date"],
select,
textarea {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ced4da;
    border-radius: 5px;
    box-sizing: border-box;
    transition: border-color 0.3s, box-shadow 0.3s;
    font-size: 16px;
}

input:focus,
select:focus,
textarea:focus {
    border-color: #007bff;
    box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
    outline: none;
}

textarea {
    resize: vertical;
    min-height: 80px;
}

.btn-primary {
    background-color: #007bff;
    color: white;
    padding: 12px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 18px;
    font-weight: bold;
    width: 100%;
    margin-top: 10px;
    transition: background-color 0.3s;
}

.btn-primary:hover {
    background-color: #0056b3;
}

.btn-secondary {
    background-color: #6c757d;
    color: white;
    padding: 12px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 18px;
    font-weight: bold;
    width: 100%;
    margin-top: 15px;
    transition: background-color 0.3s;
}

.btn-secondary:hover {
    background-color: #5a6268;
}

input[readonly] {
    background-color: #e9ecef;
    cursor: not-allowed;
}
  </style>

   <center>
        <h1>Add Project</h1>
        
        <%
            String loggedInPhono = (String) session.getAttribute("phono");
            
            if (loggedInPhono == null || loggedInPhono.trim().isEmpty()) {
        %>
                <div style="padding: 15px; background-color: #fff3cd; color: #856404; border: 1px solid #ffeaa7; border-radius: 4px; text-align: center; margin-bottom: 20px;">
                    <strong>Please login first to add a project!</strong>
                </div>
        <%
            } else {
        %>
        
        <form action="proadd" method="GET">
            <div class="addclient">
                <label>Project Name:</label>
                <input type="text" name="pname" class="form-control" required>
            </div>
            
            <div class="addclient">
                <label>Client Name:</label>
                <input type="text" name="cname" class="form-control" required>
            </div>
         
            <div class="addclient">
                <label>Phone:</label>
                <input type="text" placeholder="Enter phone number" name="phono" value="<%= loggedInPhono %>" readonly required>
            </div>
            
            <div class="addclient">
                <label>Description:</label>
                <input type="text" name="description" class="form-control" required>
            </div>
            
            <div class="addclient">
                <label>Start Date</label>
                <input type="date" name="startdate" required>
            </div>
            
            <div class="addclient">
                <label>End Date</label>
                <input type="date" name="enddate" required>
            </div>
            
            <div class="addclient">
                <label>Budget</label>
                <select name="budget" class="form-control">
                    <option value="Low">10000-50000</option>
                    <option value="Medium">50000-100000</option>
                    <option value="High">100000-200000</option>
                </select>
            </div>

            <div class="addclient">
                <label>Status</label>
                <select name="status" class="form-control">
                    <option value="Student">Student</option>
                    <option value="Employee">Employee</option>
                    <option value="Merchant">Merchant</option>
                </select>
            </div>

            <div class="addclient">
                <label>Type</label>
                <select name="type" class="form-control">
                    <option value="Corporate">Corporate</option>
                    <option value="Startup">Startup</option>
                    <option value="Freelancer">Freelancer</option>
                    <option value="Government">Government</option>
                    <option value="Non-Profit">Non-Profit</option>
                </select>
            </div>

            <div class="addclient">
                <label>Technology:</label>
                <select name="technology" class="form-control">
                    <option value="App">App Development</option>
                    <option value="Web">Web Development</option>
                    <option value="Game">Game Development</option>
                    <option value="Mobilee">Mobile Applications</option>
                    <option value="Desktop">Desktop Applications</option>
                </select>
            </div>
            
            <div class="addclient">
                <label>Progress:</label>
                <select name="progress" class="form-control">
                    <option value="Pending">Pending</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary">Add Project</button>
            <button type="reset" class="btn btn-secondary">Reset</button>
        </form>

        <% } %>
    </center>
    </body>
</html>
