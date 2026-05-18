<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="adminheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Employee</title>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f6fa;
            margin: 0;
            padding: 0;
        }

        .page-content {
            margin-top: 20px;
            margin-left: 100px;
            padding: 70px;
            width:1250px;
            height: 700px;
        }

        center {
            width: 100%;
            max-width: none;
            max-height: none;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            margin: 0 auto;
            text-align: left;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 3px solid #007bff;
            padding-bottom: 10px;
            color: black;
        }

        /* GRID FORM */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .addclient {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: 600;
            margin-bottom: 6px;
            color: #495057;
        }

        input, select {
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 15px;
        }

        input:focus, select:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }

        /* FULL WIDTH ROW */
        .full-width {
            grid-column: span 2;
        }

        /* BUTTON ROW */
        .btn-row {
            display: flex;
            gap: 20px;
            margin-top: 30px;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            flex: 1;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            flex: 1;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }
    </style>
</head>

<body>
<div class="page-content">
<center>
    <h1>Add Employee</h1>

    <form action="empadd" method="GET">

        <div class="form-grid">

            <div class="addclient">
                <label>Employee Name</label>
                <input type="text" name="name" required>
            </div>

            <div class="addclient">
                <label>Employee Phone</label>
                <input type="text" name="phono" required>
            </div>

            <div class="addclient">
                <label>Employee Age</label>
                <input type="text" name="age" required>
            </div>

            <div class="addclient">
                <label>Employee Role</label>
                <select name="roles">
                    <option>Software Engineer/Developer</option>
                    <option>Full-Stack Developer</option>
                    <option>Mobile App Developer</option>
                    <option>Frontend Developer</option>
                    <option>Backend Developer</option>
                    <option>UX/UI Developer</option>
                    <option>Project Manager</option>
                    <option>QA Tester/Analyst</option>
                </select>
            </div>

            <div class="addclient">
                <label>Salary</label>
                <input type="text" name="salary" required>
            </div>

            <div class="addclient">
                <label>Employee ID</label>
                <input type="text" name="mid" required>
            </div>

            <div class="addclient full-width">
                <label>Password</label>
                <input type="text" name="pass" required>
            </div>

        </div>

        <div class="btn-row">
            <button type="submit" class="btn-primary">Submit</button>
            <button type="reset" class="btn-secondary">Reset</button>
        </div>

    </form>
</center>
</div>
</body>
</html>
