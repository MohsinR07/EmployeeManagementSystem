<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <title>Process Salary</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Process Salary</h2>

        <%-- Success Message --%>
        <% String successMessage = (String) session.getAttribute("successMessage");
           if (successMessage != null) { %>
            <div class="alert alert-success"><%= successMessage %></div>
        <% session.removeAttribute("successMessage"); } %>

        <%-- Error Message --%>
        <% String errorMessage = (String) session.getAttribute("errorMessage");
           if (errorMessage != null) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
        <% session.removeAttribute("errorMessage"); } %>

        <form action="ProcessSalaryServlet" method="post">
            <input type="hidden" name="action" value="process">

            <%-- Employee Dropdown --%>
            <div class="mb-3">
                <label class="form-label">Select Employee</label>
                <select name="emp_id" class="form-control" required>
                    <option value="">Select Employee</option>
                    <% 
                        try (Connection conn = DBConnect.getConnection();
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery("SELECT id, name FROM users")) {
                        
                        while (rs.next()) { %>
                            <option value="<%= rs.getInt("id") %>"><%= rs.getString("name") %></option>
                    <% } 
                        } catch (Exception e) { %>
                        <option value="">Error fetching employees</option>
                    <% } %>
                </select>
            </div>

            <%-- Basic Salary Input --%>
            <div class="mb-3">
                <label class="form-label">Basic Salary</label>
                <input type="number" step="0.01" name="basic_salary" class="form-control" min="0" required>
            </div>

            <%-- Allowances Input (Default 0) --%>
            <div class="mb-3">
                <label class="form-label">Allowances</label>
                <input type="number" step="0.01" name="allowances" class="form-control" min="0" value="0.00">
            </div>

            <%-- Deductions Input (Default 0) --%>
            <div class="mb-3">
                <label class="form-label">Deductions</label>
                <input type="number" step="0.01" name="deductions" class="form-control" min="0" value="0.00">
            </div>

            <%-- Submit Button --%>
            <button type="submit" class="btn btn-primary">Process Salary</button>
        </form>
    </div>
</body>
</html>