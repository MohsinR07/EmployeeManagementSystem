<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>
<%
    Connection conn = DBConnect.getConnection();
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM users");
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Employees</title>
</head>
<body>
    <h2>All Employees</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Salary</th>
            <th>Actions</th>
        </tr>
        <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("role") %></td>
            <td><%= rs.getDouble("salary") %></td>
            <td>
                <a href="edit_employee.jsp?id=<%= rs.getInt("id") %>">Edit</a> |
                <a href="delete_employee.jsp?id=<%= rs.getInt("id") %>">Delete</a>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
