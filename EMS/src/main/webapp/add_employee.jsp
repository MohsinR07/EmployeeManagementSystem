<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Employee</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
    <h2 class="mb-4">Add Employee</h2>
       <form action="/EMS/EmployeeServlet" method="post">
<div class="mb-3">
        <label class="form-label">Full Name:</label>
        <input type="text" name="name" class="form-control" placeholder="Enter full name" required>
    </div>
    <div class="mb-3">
        <label class="form-label">Email:</label>
        <input type="email" name="email" class="form-control" placeholder="Enter email" required>
    </div>
    <div class="mb-3">
        <label class="form-label">Password:</label>
        <input type="password" name="password" class="form-control" placeholder="Enter password" required>
    </div>
    <div class="mb-3">
        <label class="form-label">Role:</label>
        <input type="text" name="role" class="form-control" placeholder="Admin/Employee" required>
    </div>
    <div class="mb-3">
        <label class="form-label">Salary:</label>
        <input type="number" name="salary" class="form-control" placeholder="Enter salary" required>
    </div>
    <button type="submit" class="btn btn-primary">Add Employee</button>
</form>