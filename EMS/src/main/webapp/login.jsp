<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Employee Management System</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        /* Full-screen background */
        body {
            background: url('https://images.pexels.com/photos/7233099/pexels-photo-7233099.jpeg') no-repeat center center/cover;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Glassmorphism effect */
        .login-box {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
            width: 350px;
            text-align: center;
        }

        .login-box h2 {
            color: white;
            margin-bottom: 20px;
        }

        .form-control {
            background: transparent;
            border: 1px solid white;
            color: white;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .btn-custom {
            background-color: #007bff;
            color: white;
            width: 100%;
        }

        .btn-custom:hover {
            background-color: #0056b3;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .login-box {
                width: 90%;
            }
        }
    </style>
</head>
<body>

    <div class="login-box">
        <h2>Login</h2>
        <form action="LoginServlet" method="post">
            <div class="mb-3">
                <input type="text" class="form-control" name="email" placeholder="Enter Email" required>
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" name="password" placeholder="Enter Password" required>
            </div>
            <button type="submit" class="btn btn-custom">Login</button>
        </form>
    </div>

</body>
</html>
