<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Attendance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <% 
        HttpSession sessionObj = request.getSession(false);
        if (sessionObj == null || sessionObj.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
        }
        String empName = "";
        int empId = (int) sessionObj.getAttribute("id");
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
        <h2>Employee Attendance</h2>
        <h4>Employee: <%= empName %></h4>
        
        <!-- Attendance Marking Form -->
        <form action="mark_employee_attendance.jsp" method="post" class="mt-3">
            <input type="hidden" name="emp_id" value="<%= empId %>">
            <label>Status:</label>
            <select name="status" class="form-select">
                <option value="Present">Present</option>
                <option value="Absent">Absent</option>
                <option value="Leave">Leave</option>
            </select>
            <button type="submit" class="btn btn-success mt-2">Mark Attendance</button>
        </form>
        
        <!-- Filter Attendance -->
        <form action="employee_attendance.jsp" method="get" class="mt-4">
            <label>Select Month:</label>
            <input type="month" name="month" class="form-control" required>
            <button type="submit" class="btn btn-primary mt-2">Filter</button>
        </form>
        
        <!-- Display Attendance Table -->
        <table class="table table-bordered mt-4">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    String monthFilter = request.getParameter("month");
                    try {
                        Connection con = DBConnect.getConnection();
                        String query = "SELECT date, status FROM attendance WHERE emp_id = ?";
                        if (monthFilter != null && !monthFilter.isEmpty()) {
                            query += " AND DATE_FORMAT(date, '%Y-%m') = ?";
                        }
                        PreparedStatement ps = con.prepareStatement(query);
                        ps.setInt(1, empId);
                        if (monthFilter != null && !monthFilter.isEmpty()) {
                            ps.setString(2, monthFilter);
                        }
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getDate("date") %></td>
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
        
        <!-- Print Button -->
        <button onclick="window.print()" class="btn btn-secondary">Print Attendance</button>
    </div>
</body>
</html>