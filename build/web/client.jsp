<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%@ include file="clientheader.jsp" %>
<html>
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Project Management</title>
    <style>
      /* Ensure header and sidebar line up perfectly */
.app-topstrip {
  background-color: #0d47a1; /* or your blue color */
  border-bottom: 3px solid #0d47a1; /* blue border */
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;  /* stretch across full screen */
  z-index: 1000;
}

/* Sidebar alignment fix */
.page-wrapper {
  display: flex;
  flex-direction: row;
}

/* Sidebar styling (example, adjust selector if needed) */
#main-wrapper [data-sidebartype="full"] {
  background-color: #0d47a1;  /* make same color as header */
  border-right: 3px solid #0d47a1;
  height: 100vh;
  position: fixed;
  top: 0;
  left: 0;
}

/* Ensure content starts below header */
.page-content {
  margin-top: 80px;  /* height of header */
  margin-left: 260px; /* width of sidebar */
  padding: 20px;
}

      center {
    /* Style for the container centered by the HTML <center> tag */
    width: 100%;
    max-width: 500px; /* Limit the form's width for better readability */
    padding: 30px;
    background-color: #ffffff; /* White background for the form area */
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15); /* A more pronounced shadow */
    margin: 20px auto; /* Center the block itself and give vertical spacing */
    /* Remove text-align: center that <center> adds for children elements */
    text-align: left; 
}

/* Style the main heading */
h1 {
    color: #333;
    text-align: center;
    margin-bottom: 30px;
    padding-bottom: 10px;
    padding-top: 50px;
    border-bottom: 3px solid #007bff; /* Blue separator */
}

/* Style for each form group */
.addclient {
    margin-bottom: 20px;
   /* Use flexbox for label-input alignment */
    display: flex;
    flex-direction: column;
}

/* Style for labels */
label {
    font-weight: 600; /* Bolder font weight */
    color: #495057;
    margin-bottom: 8px;
    text-align: left;
}

/* Style for all input fields, textareas, and select elements */
input[type="text"],
input[type="email"],
input[type="date"],
select,
textarea {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ced4da; /* Light gray border */
    border-radius: 5px;
    box-sizing: border-box; /* Crucial for proper padding/width calculation */
    transition: border-color 0.3s, box-shadow 0.3s;
    font-size: 16px;
}

/* Focus style for inputs */
input:focus,
select:focus,
textarea:focus {
    border-color: #007bff; /* Primary blue on focus */
    box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
    outline: none;
}

/* Style for textarea height */
textarea {
    resize: vertical; /* Allow vertical resizing, but not horizontal */
    min-height: 80px;
}

/* Remove the <br><br> spacing with CSS */
.addclient br {
    display: none;
}

/* Style for the Save Client button (Primary) */
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

/* Style for the Reset button (Secondary) */
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
    margin-top: 15px; /* Spacing between the two buttons */
    transition: background-color 0.3s;
}

.btn-secondary:hover {
    background-color: #5a6268;
}

/* The <br><br> tags after the buttons should also be hidden for cleaner spacing */
form > br {
    display: none;
} 
  </style>
  </head>
  <body>
   
         
         
        
      <!----  <div class="col-9 grid-margin stretch-card" >
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">CLIENT REGISTRATION</h4>
                     <form class="forms-sample">
                      <div class="form-group">
                          <form action="clientrdb" method="POST">
                    <div class="addclient">
                      <label>Client Name:</label>
                      <input type="text" name="cname" class="form-control" required>
                      <br><br>
                    </div>

                    <div class="addclient">
                      <label>Email:</label>
                      <input type="email" name="email" class="form-control" required>
                      <br><br>
                    </div>

                   <div class="addclient">
                      <label>Phone:</label>
                     <input type="text" placeholder="Enter phone number" name="phono" class="form-control" required>
                      <br><br>
                    </div>

                   <div class="addclient">
                      <label>Status</label>
                      <select name="status" class="form-control">
                        <option value="Student">Student</option>
                        <option value="Employee">Employee</option>
                        <option value="Merchant">Merchant</option>
                      </select>
                      <br><br>
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

                      <br><br>
                    </div>

                    <div class="addclient">
                      <label>Domain:</label>
                      <input type="text" name="domain" class="form-control">
                      <br><br>
                    </div>

                    <div class="addclient">
                      <label>Address:</label>
                      <textarea name="address" class="form-control" rows="3"></textarea>
                      <br><br>
                    </div>

                    <div class="addclient">
                      <label>Delivery Date</label>
                      <input type="date" name="deliverydate" required>
                      <br><br>
                    </div>

                    <div class="addclient">
                      <label>Cost:</label>
                      <select name="cost" class="form-control">
                        <option value="High">100000-200000</option>
                        <option value="Medium">50000-90000</option>
                        <option value="Low">10000-40000</option>
                      </select>
                      <br><br>
                    </div>


                    <div class="addclient">
                      <label>Requirements:</label>
                      <textarea name="note" class="form-control" rows="2"></textarea>
                      <br><br>
                    </div>

                    <button type="submit" class="btn btn-primary">Save Client</button>
                    <br><br>
                    <button type="reset" class="btn btn-secondary">Reset</button>
                  </form>
                      </div>
                      </div>
                      </div>
                      </div>------>
      
      
      
      
      <div class="col-9 grid-margin stretch-card">
  <div class="card">
    <div class="card-body">
      <h4 class="card-title">CLIENT REGISTRATION</h4>

      <form action="clientrdb" method="POST" class="forms-sample">

        <div class="addclient">
          <label>Client Name:</label>
          <input type="text" name="cname" class="form-control" required>
        </div><br>

        <div class="addclient">
          <label>Email:</label>
          <input type="email" name="email" class="form-control" required>
        </div><br>

        <div class="addclient">
          <label>Phone:</label>
          <input type="text" placeholder="Enter phone number" name="phono" class="form-control" required>
        </div><br>

        <div class="addclient">
          <label>Status</label>
          <select name="status" class="form-control">
            <option value="Student">Student</option>
            <option value="Employee">Employee</option>
            <option value="Merchant">Merchant</option>
          </select>
        </div><br>

        <div class="addclient">
          <label>Type</label>
          <select name="type" class="form-control">
            <option value="Corporate">Corporate</option>
            <option value="Startup">Startup</option>
            <option value="Freelancer">Freelancer</option>
            <option value="Government">Government</option>
            <option value="Non-Profit">Non-Profit</option>
          </select>
        </div><br>

        <div class="addclient">
          <label>Domain:</label>
          <input type="text" name="domain" class="form-control">
        </div><br>

        <div class="addclient">
          <label>Address:</label>
          <textarea name="address" class="form-control" rows="3"></textarea>
        </div><br>

        <div class="addclient">
          <label>Delivery Date:</label>
          <input type="date" name="deliverydate" class="form-control" required>
        </div><br>

        <div class="addclient">
          <label>Cost:</label>
          <select name="cost" class="form-control">
            <option value="High">100000-200000</option>
            <option value="Medium">50000-90000</option>
            <option value="Low">10000-40000</option>
          </select>
        </div><br>

        <div class="addclient">
          <label>Requirements:</label>
          <textarea name="note" class="form-control" rows="2"></textarea>
        </div><br>

        <button type="submit" class="btn btn-primary">Save Client</button>
        <button type="reset" class="btn btn-secondary">Reset</button>

      </form>
    </div>
  </div>
</div>


</body>
</html>
<!----String sql = "INSERT INTO clients "
                       + "(name, email, phono, status, type, domain, address, delivery_date, cost, notes) "
                       + "VALUES ('"+cname+"','"+email+"','"+phono+"','"+status+"','"+type+"','"+domain+"','"+address+"','"+deliveryDateStr+"','"+cost+"','"+notes+"')";
----->
   
<body>
   <center>
        <h1>Add Clients</h1>
        <form action="assigndb" method="GET">
    <div class="addclient">
    <label>Project Name:</label>
    <input type="text" name="pname" class="form-control" required>
    <br><br>
  </div>
            
    <div class="addclient">
    <label>Client Name:</label>
    <input type="text" name="cname" class="form-control" required>
    <br><br>
  </div>
         
     <div class="addclient">
    <label>Phone:</label>
   <input type="text" placeholder="Enter phone number" name="phono" required>
    <br><br>
  </div>
            
  <div class="addclient">
    <label>Description:</label>
    <input type="text" name="description" class="form-control" required>
    <br><br>
  </div>
            
    <div class="addclient">
    <label>Start Date</label>
    <input type="date" name="startdate" required>
    <br><br>
  </div>
            
  <div class="addclient">
    <label>End Date</label>
    <input type="date" name="enddate" required>
    <br><br>
  </div>
      
    <div class="addclient">
    <label>Manager:</label>
    <input type="text" name="manager" class="form-control" required>
    <br><br>
  </div>
            
            
     <div class="addclient">
    <label>Budget</label>
    <select name="budget" class="form-control">
      <option value="Low">10000-50000</option>
      <option value="Medium">50000-100000</option>
      <option value="High">100000-200000</option>
    </select>
    <br><br>
  </div>



  <div class="addclient">
    <label>Technology:</label>
    <select name="technology" class="form-control">
      <option value="One">App Development</option>
      <option value="Two">Web Development</option>
      <option value="Three">Game Development</option>
      <option value="Three">Mobile Applications</option>
      <option value="Three"> Desktop Applications</option>
    </select>
    <br><br>
  </div>



  <button type="submit" class="btn btn-primary">Add Project</button>
  <br><br>
  <button type="reset" class="btn btn-secondary">Reset</button>
</form>
    </center>
    </body>