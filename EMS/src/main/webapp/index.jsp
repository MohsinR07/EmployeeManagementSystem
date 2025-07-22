<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.ems.utils.DBConnect" %>
<%
    HttpSession userSession = request.getSession(false);
    String userName = (userSession != null) ? (String) userSession.getAttribute("user") : null;
    String userRole = (userSession != null) ? (String) userSession.getAttribute("role") : null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management System</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        body {
            background: url('https://images.pexels.com/photos/927022/pexels-photo-927022.jpeg') no-repeat center center/cover;
            height: 100vh;
            margin: 0;
            padding: 0;
            color: white;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .navbar {
            width: 100%;
            background: rgba(0, 0, 0, 0.7);
            padding: 15px;
            position: absolute;
            top: 0;
            left: 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .nav-links {
            list-style: none;
            display: flex;
            margin: 0;
            padding: 0;
        }
        .nav-links li {
            margin: 0 15px;
        }
        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 18px;
        }
        .nav-links a:hover {
            text-decoration: underline;
        }
        .welcome-box {
            background: rgba(0, 0, 0, 0.5);
            padding: 20px;
            border-radius: 10px;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <h2>Employee Management System</h2>
        <ul class="nav-links">
            <li><a href="index.jsp">Home</a></li>
            
            <% if (userName == null) { %>
                <li><a href="login.jsp">Login</a></li>
                <li><a href="signup.jsp">Signup</a></li>
            <% } else { %>
                <% if ("admin".equals(userRole)) { %>
                    <li><a href="admin.jsp">Admin Panel</a></li>
                <% } else { %>
                    <li><a href="dashboard.jsp">Dashboard</a></li>
                <% } %>
                <li><a href="LogoutServlet">Logout</a></li>
            <% } %>
        </ul>
    </div>
    
    <div class="welcome-box">
        <h1>Welcome to Employee Management System</h1>
        <% if (userName != null) { %>
            <p>Hello, <%= userName %>!</p>
        <% } else { %>
            <p>Manage your employees efficiently with our system.</p>
        <% } %>
    </div>

</body>
</html>
