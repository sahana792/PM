<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Project Management - Client Login</title>

  <style>
    /* Base styling */
    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #001233, #005b5f, #00d4b4);
      background-size: cover;
      height: 100vh;
      margin: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      color: #e0f7f4;
    }

    /* Login card */
    .login-card {
      background: rgba(255, 255, 255, 0.12);
      border: 1px solid rgba(255, 255, 255, 0.15);
      backdrop-filter: blur(10px);
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.25);
      padding: 40px 45px;
      width: 400px;
      color: #f0f0f0;
      transition: box-shadow 0.3s ease;
    }

    .login-card:hover {
      box-shadow: 0 6px 25px rgba(0, 255, 204, 0.15);
    }

    h4 {
      text-align: center;
      color: #ffffff;
      font-size: 24px;
      margin-bottom: 30px;
      font-weight: 600;
      text-shadow: 0 0 8px rgba(0, 255, 204, 0.3);
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
      display: inline-block;
      width: 100%;
      padding: 10px 0;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-size: 15px;
      font-weight: 500;
      transition: background 0.3s ease, box-shadow 0.3s ease;
    }

    .btn-primary {
      background: #008f8c;
      color: #ffffff;
      box-shadow: 0 3px 10px rgba(0, 255, 204, 0.25);
    }

    .btn-primary:hover {
      background: #00b8a3;
      box-shadow: 0 0 12px rgba(0, 255, 204, 0.4);
    }

    .btn-dark {
      background: #0f172a;
      color: #ffffff;
      border: 1px solid rgba(255, 255, 255, 0.15);
      width: 60%;
      display: block;
      margin: 20px auto 0 auto;
    }

    .btn-dark:hover {
      background: #1e293b;
      box-shadow: 0 0 10px rgba(0, 255, 204, 0.25);
    }

    .register-section {
      text-align: center;
      margin-top: 15px;
    }
  </style>
</head>

<body>

  <div class="login-card">
    <h4>CLIENT EXISTING LOGIN</h4>

    <form action="elogindb" method="POST" class="forms-sample">

      <div class="form-group">
        <label for="phono">Enter Phone</label>
        <input type="text" name="phono" id="phono" class="form-control" required>
      </div>

      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" name="pass" id="password" class="form-control" required>
      </div>

      <button type="submit" class="btn btn-primary">Login</button>
    </form>

    <div class="register-section">
      <form action="cregister.jsp" method="get">
        <button class="btn btn-dark" type="submit">Register</button>
      </form>
    </div>
  </div>

</body>
</html>
