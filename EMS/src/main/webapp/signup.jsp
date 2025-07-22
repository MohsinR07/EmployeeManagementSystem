<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Signup</title>
    <!-- ✅ Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background: url('https://images.pexels.com/photos/7233099/pexels-photo-7233099.jpeg') no-repeat center center fixed;
            background-size: cover;
            font-family: Arial, sans-serif;
        }
        .signup-container {
            width: 400px;
            margin: 100px auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .form-control {
            margin-bottom: 10px;
        }
        .btn-primary {
            width: 100%;
        }
    </style>
</head>
<body>

    <div class="signup-container">
        <h2 class="text-center">Signup</h2>

        <% 
            String error = request.getParameter("error");
            if (error != null) { 
        %>
            <p class="text-danger text-center"><%= error %></p>
        <% } %>

        <form action="SignupServlet" method="POST">
            <input type="text" name="name" class="form-control" placeholder="Full Name" required>
            <input type="email" name="email" class="form-control" placeholder="Email" required>
            <input type="password" name="password" class="form-control" placeholder="Password" required>

            <!-- ✅ Role Selection Dropdown -->
            <select name="role" class="form-control" required>
                <option value="employee">Employee</option>
                <option value="admin">Admin</option>
            </select>

            <button type="submit" class="btn btn-primary mt-3">Signup</button>
        </form>
    </div>

    <!-- ✅ Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
