<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .btn-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 80vh;
        }
        .btn-container a {
            width: 250px;
            margin: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center mt-4">Attendance Management</h2>

        <div class="btn-container">
            <a href="mark_attendance.jsp" class="btn btn-success btn-lg">Mark Attendance</a>
            <a href="update_attendance.jsp" class="btn btn-warning btn-lg">Update Attendance</a>
            <a href="monthly_report.jsp" class="btn btn-primary btn-lg">Monthly Report</a>
            <a href="view_employees_today_att.jsp" class="btn btn-info btn-lg">View Today's Attendance</a>
        </div>
    </div>
</body>
</html>
