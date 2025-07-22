<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    String name = "", email = "", role = "";
    double salary = 0.0;

    try (Connection conn = DBConnect.getConnection();
         PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?")) {
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            role = rs.getString("role");
            salary = rs.getDouble("salary");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Employee</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Edit Employee</h2>
        <form action="EmployeeServlet" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= id %>">

            <div class="mb-3">
                <label>Name:</label>
                <input type="text" name="name" class="form-control" value="<%= name %>" required>
            </div>
            <div class="mb-3">
                <label>Email:</label>
                <input type="email" name="email" class="form-control" value="<%= email %>" required>
            </div>
            <div class="mb-3">
                <label>Role:</label>
                <input type="text" name="role" class="form-control" value="<%= role %>" required>
            </div>
            <div class="mb-3">
                <label>Salary:</label>
                <input type="number" step="0.01" name="salary" class="form-control" value="<%= salary %>" required>
            </div>
            <button type="submit" class="btn btn-success">Update Employee</button>
            <a href="employee_management.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</body>
</html>
