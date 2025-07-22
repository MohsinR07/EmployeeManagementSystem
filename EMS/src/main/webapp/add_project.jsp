<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Project</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Add New Project</h2>
        <form action="save_project.jsp" method="post">
            <label>Project Name:</label>
            <input type="text" name="name" class="form-control" required>
            
            <label>Description:</label>
            <textarea name="description" class="form-control"></textarea>
            
            <label>Start Date:</label>
            <input type="date" name="start_date" class="form-control" required>
            
            <label>End Date:</label>
            <input type="date" name="end_date" class="form-control" required>
            
            <button type="submit" class="btn btn-success mt-3">Save Project</button>
        </form>
    </div>
</body>
</html>