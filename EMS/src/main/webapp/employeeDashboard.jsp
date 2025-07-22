<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: url('https://images.pexels.com/photos/845451/pexels-photo-845451.jpeg') no-repeat center center/cover;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
    </style>
</head>
<body>
    <% 
        HttpSession sessionObj = request.getSession(false);
        if (sessionObj == null || sessionObj.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
        }
        String employeeName = (String) sessionObj.getAttribute("user");
    %>
    
    <div class="container mt-5">
        <h2>Welcome, <%= employeeName %>!</h2>
        <div class="row mt-4">
            <div class="col-md-4">
                <a href="employee_profile.jsp" class="btn btn-primary w-100">Profile Management</a>
            </div>
            <div class="col-md-4">
                <a href="employee_attendance.jsp" class="btn btn-success w-100">Attendance</a>
            </div>
            <div class="col-md-4">
                <a href="employee_leave.jsp" class="btn btn-warning w-100">Leave Management</a>
            </div>
        </div>
        <div class="row mt-4">
            <div class="col-md-4">
                <a href="employee_salary.jsp" class="btn btn-info w-100">Salary Details</a>
            </div>
            <div class="col-md-4">
                <a href="employee_assigned_projects.jsp" class="btn btn-dark w-100">Assigned Projects</a>
            </div>
            <div class="col-md-4">
                <a href="logout.jsp" class="btn btn-danger w-100" onclick="return confirmLogout();">Logout</a>

<script>
function confirmLogout() {
    if (confirm('Are you sure you want to logout?')) {
        window.location.href = 'employee_dashboard_logout.jsp';
    }
    return false;
}
</script>
            </div>
        </div>
    </div>
</body>
</html>