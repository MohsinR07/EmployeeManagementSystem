<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>

<!DOCTYPE html>
<html>
<head>
    <title>Employee Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script>
        function confirmDelete(id) {
            if (confirm("Are you sure you want to delete this employee?")) {
                window.location.href = "EmployeeServlet?action=delete&id=" + id;
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Employee Management</h2>
        <a href="add_employee.jsp" class="btn btn-primary mb-3">Add Employee</a>

        <!-- ✅ Success Message Show Karne Ka Code -->
        <% 
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null) { 
        %>
            <div class="alert alert-success"><%= successMessage %></div>
        <% 
                session.removeAttribute("successMessage"); // Message remove taki refresh ke baad na aaye
            } 
        %>

        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Salary</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try (Connection conn = DBConnect.getConnection();
                         Statement stmt = conn.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT * FROM users")) {

                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("role") %></td>
                    <td><%= rs.getDouble("salary") %></td>
                    <td>
                        <a href="edit_employee.jsp?id=<%= rs.getInt("id") %>" class="btn btn-warning btn-sm">Edit</a>
                        <form action="EmployeeServlet" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this employee?')">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
