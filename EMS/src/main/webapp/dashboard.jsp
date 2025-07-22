<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <style>
        body {
            background: url('https://images.pexels.com/photos/9572504/pexels-photo-9572504.jpeg') no-repeat center center fixed;
            background-size: cover;
        }
    </style>
</head>
<body>
    <h2 style="color: white; background-color: blue; padding: 10px; display: inline-block;">Welcome To EMS Admin Panel</h2>
    <!-- ❌ Welcome User aur Logout link remove kar diya -->
</body>
</html>
