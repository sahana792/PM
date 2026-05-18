<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Project Management - Admin Login</title>

  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #001233, #003d5c, #00b3a4);
      background-size: cover;
      height: 100vh;
      margin: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      color: #e0f7f4;
    }

    .login-card {
      background: rgba(255, 255, 255, 0.12);
      border: 1px solid rgba(255, 255, 255, 0.15);
      backdrop-filter: blur(10px);
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
      padding: 40px 50px;
      width: 380px;
      color: #f0f0f0;
      transition: box-shadow 0.3s ease;
    }

    .login-card:hover {
      box-shadow: 0 6px 25px rgba(0, 255, 204, 0.2);
    }

    h4 {
      text-align: center;
      color: #ffffff;
      font-size: 24px;
      margin-bottom: 30px;
      font-weight: 600;
    }

    .form-group {
      margin-bottom: 18px;
    }

    label {
      display: block;
      font-size: 14px;
      color: #b8e5de;
      margin-bottom: 5px;
    }

    input.form-control {
      width: 100%;
      padding: 10px 12px;
      border: 1px solid rgba(0, 255, 204, 0.3);
      border-radius: 8px;
      background: rgba(255, 255, 255, 0.08);
      color: #ffffff;
      outline: none;
      font-size: 14px;
      transition: border-color 0.3s, background-color 0.3s;
    }

    input.form-control:focus {
      border-color: #00ffcc;
      background-color: rgba(255, 255, 255, 0.15);
    }

    .btn {
      width: 48%;
      padding: 10px 0;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-size: 15px;
      font-weight: 500;
      transition: background 0.3s ease, box-shadow 0.3s ease;
    }

    .btn-primary {
      background: #007a74;
      color: #ffffff;
    }

    .btn-primary:hover {
      background: #00a795;
    }

    .btn-secondary {
      background: #6c757d;
      color: white;
    }

    .btn-secondary:hover {
      background: #5a6268;
    }

    .button-group {
      display: flex;
      justify-content: space-between;
      margin-top: 25px;
    }

  </style>
</head>
<body>

  <div class="login-card">
    <h4>ADMIN LOGIN</h4>
    <form action="admindb" method="POST" class="forms-sample">

      <div class="form-group">
        <label for="username">Username</label>
        <input type="text" name="name" class="form-control" id="username" required>
      </div>
        
    
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" name="pass" class="form-control" id="password" required>
      </div>

      

      <div class="button-group">
        <button type="submit" class="btn btn-primary">Login</button>
        <button type="reset" class="btn btn-secondary">Reset</button>
      </div>
    </form>
  </div>

</body>
</html>
