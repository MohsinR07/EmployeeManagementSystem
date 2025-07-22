<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("user") == null) {
        response.sendRedirect("index.jsp"); // Redirect to home page if not logged in
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background: url('https://images.pexels.com/photos/8297068/pexels-photo-8297068.jpeg') no-repeat center center fixed;
            background-size: cover;
        }
        .sidebar {
            height: 100vh;
            background-color: rgba(52, 58, 64, 0.9);
            padding-top: 20px;
            position: fixed;
            width: 250px;
        }
        .sidebar a {
            color: white;
            padding: 10px;
            display: block;
            text-decoration: none;
        }
        .sidebar a:hover {
            background-color: #495057;
        }
        .content {
            margin-left: 260px;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
        }
        iframe {
            width: 100%;
            height: 80vh;
            border: none;
            background-color: white;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block sidebar">
                <h4 class="text-center text-white">Admin Panel</h4>
                <a href="dashboard.jsp" target="mainFrame">Dashboard</a>
                <a href="employee_management.jsp" target="mainFrame">Employee Management</a>
                <a href="payment_management.jsp" target="mainFrame">Payment Management</a>
                <a href="attendance_management.jsp" target="mainFrame">Attendance Management</a>
                <a href="leave_management.jsp" target="mainFrame">Leave Management</a>
                <a href="project_management.jsp" target="mainFrame">Project Management</a>
                <a href="LogoutServlet">Logout</a>
            </nav>

            <!-- Main Content (Iframe for Loading Pages) -->
            <main class="col-md-9 col-lg-10 content">
                <h2>Admin Dashboard</h2>
                <iframe name="mainFrame" src="dashboard.jsp"></iframe>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>