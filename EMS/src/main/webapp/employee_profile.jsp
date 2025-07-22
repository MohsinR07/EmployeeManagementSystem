<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <% 
        HttpSession sessionObj = request.getSession(false);
        if (sessionObj == null || sessionObj.getAttribute("id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int empId = (Integer) sessionObj.getAttribute("id"); // ✅ Employee ID from session
        String name = "";
        String email = "";
        double salary = 0.0;

        try {
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT name, email, salary FROM users WHERE id = ?");
            ps.setInt(1, empId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");
                email = rs.getString("email");
                salary = rs.getDouble("salary");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    
    <div class="container mt-5">
        <h2>Employee Profile</h2>
        <table class="table table-bordered mt-3">
            <tr>
                <th>Employee ID</th> <!-- ✅ Employee ID Added -->
                <td><%= empId %></td>
            </tr>
            <tr>
                <th>Full Name</th>
                <td><%= name %></td>
            </tr>
            <tr>
                <th>Email ID</th>
                <td><%= email %></td>
            </tr>
            <tr>
                <th>Salary</th>
                <td><%= salary %></td>
            </tr>
        </table>
        <div class="mt-4">
            <a href="employee_change_password.jsp" class="btn btn-warning">Change Password</a>
        </div>
    </div>
</body>
</html>
