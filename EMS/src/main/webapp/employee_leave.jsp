<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Leave Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <% 
        HttpSession sessionObj = request.getSession(false);
        if (sessionObj == null || sessionObj.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String empName = "";
        int empId = (int) sessionObj.getAttribute("id");
        String message = request.getParameter("message");
        try {
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT name FROM users WHERE id = ?");
            ps.setInt(1, empId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                empName = rs.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    
    <div class="container mt-5">
        <h2>Employee Leave Management</h2>
        <h4>Employee: <%= empName %></h4>

        <% if (message != null) { %>
            <div class="alert alert-success" role="alert">
                <%= message %>
            </div>
        <% } %>

        <!-- Apply for Leave Form -->
        <form action="ApplyLeaveServlet" method="post" class="mt-3">
            <input type="hidden" name="emp_id" value="<%= empId %>">
            <label>Leave Type:</label>
            <select name="leave_type" class="form-select">
                <option value="Sick Leave">Sick Leave</option>
                <option value="Casual Leave">Casual Leave</option>
                <option value="Paid Leave">Paid Leave</option>
            </select>
            <label>Start Date:</label>
            <input type="date" name="start_date" class="form-control" required>
            <label>End Date:</label>
            <input type="date" name="end_date" class="form-control" required>
            <label>Reason:</label>
            <textarea name="reason" class="form-control" required></textarea>
            <button type="submit" class="btn btn-success mt-2">Apply Leave</button>
        </form>

        <!-- Leave Status Table -->
        <h3 class="mt-5">Your Leave Requests</h3>
        <table class="table table-bordered mt-3">
            <thead>
                <tr>
                    <th>Leave Type</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Reason</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    try {
                        Connection con = DBConnect.getConnection();
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM leaves WHERE emp_id = ?");
                        ps.setInt(1, empId);
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("leave_type") %></td>
                    <td><%= rs.getDate("start_date") %></td>
                    <td><%= rs.getDate("end_date") %></td>
                    <td><%= rs.getString("reason") %></td>
                    <td><%= rs.getString("status") %></td>
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
