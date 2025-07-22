<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<div class="container">
    <h2 class="mt-4">Employee Payment Management</h2>

    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>Employee</th>
                <th>Basic Salary</th>
                <th>Allowances</th>
                <th>Deductions</th>
                <th>Net Salary</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                try (Connection conn = DBConnect.getConnection();
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery(
                         "SELECT u.id, u.name, " +
                         "COALESCE(s.basic_salary, 0) AS basic_salary, " +
                         "COALESCE(s.allowances, 0) AS allowances, " +
                         "COALESCE(s.deductions, 0) AS deductions, " +
                         "COALESCE(s.net_salary, u.salary) AS net_salary, " +
                         "COALESCE(s.payment_status, 'Pending') AS payment_status " +
                         "FROM users u " +
                         "LEFT JOIN salary s ON u.id = s.emp_id"
                     )) {
                     
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("name") %></td>
                <td>₹<%= rs.getDouble("basic_salary") %></td>
                <td>₹<%= rs.getDouble("allowances") %></td>
                <td>₹<%= rs.getDouble("deductions") %></td>
                <td>₹<%= rs.getDouble("net_salary") %></td>
                <td>
                    <% if ("Paid".equals(rs.getString("payment_status"))) { %>
                        <span class="badge bg-success">Paid</span>
                    <% } else { %>
                        <span class="badge bg-warning">Pending</span>
                    <% } %>
                </td>
                <td>
                    <a href="process_salary.jsp?emp_id=<%= rs.getInt("id") %>" class="btn btn-warning btn-sm">Process</a>
                    <a href="salary_slip.jsp?emp_id=<%= rs.getInt("id") %>" class="btn btn-primary btn-sm">Salary Slip</a>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>
</div>

</body>
</html>