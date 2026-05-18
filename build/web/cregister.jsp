<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Project Management - Client Registration</title>

  <style>
    /* Base body styles */
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

    /* Registration card */
    .register-card {
      background: rgba(255, 255, 255, 0.12);
      border: 1px solid rgba(255, 255, 255, 0.15);
      backdrop-filter: blur(10px);
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.25);
      padding: 40px 45px;
      width: 400px;
      max-height: 800px;
      overflow-y: auto;
      color: #f0f0f0;
      transition: box-shadow 0.3s ease;
    }

    .register-card:hover {
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

    /* Buttons */
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
      background: #007a9b;
      color: #ffffff;
    }

    .btn-primary:hover {
      background: #009ebc;
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

  <div class="register-card">
    <h4>CLIENT REGISTRATION</h4>

    <form action="clogindb" method="POST" class="forms-sample" autocomplete="off">
      <div class="form-group">
        <label for="name">Username</label>
        <input type="text" name="name" id="name" class="form-control" required />
      </div>

      <div class="form-group">
        <label for="phono">User Phone</label>
        <input type="text" name="phono" id="phono" class="form-control" required />
      </div>

      <div class="form-group">
        <label for="email">Email address</label>
        <input type="email" name="email" id="email" class="form-control" required />
      </div>

      <div class="form-group">
        <label for="pass">Password</label>
        <input type="password" name="pass" id="pass" class="form-control" required />
      </div>

      <div class="form-group">
        <label for="cpass">Confirm Password</label>
        <input type="password" name="cpass" id="cpass" class="form-control" required />
      </div>

      <button type="submit" class="btn btn-primary">Register</button>
      <button type="reset" class="btn btn-secondary">Reset</button>
    </form>
  </div>

</body>
</html>
