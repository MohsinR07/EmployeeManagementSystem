<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <title>Today's Attendance Report</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">Today's Employee Attendance</h2>

        <table class="table table-bordered mt-4">
            <thead class="table-dark">
                <tr>
                    <th>Employee Name</th>
                    <th>Today's Status</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    try (Connection conn = DBConnect.getConnection();
                         PreparedStatement stmt = conn.prepareStatement(
                            "SELECT u.name, COALESCE(a.status, 'Not Marked') AS status " +
                            "FROM users u LEFT JOIN attendance a ON u.id = a.emp_id AND a.date = CURDATE()")) {
                        
                        ResultSet rs = stmt.executeQuery();
                        while (rs.next()) { %>
                            <tr>
                                <td><%= rs.getString("name") %></td>
                                <td><%= rs.getString("status") %></td>
                            </tr>
                <% } 
                    } catch (Exception e) { %>
                        <tr><td colspan="2" class="text-center text-danger">Error fetching data: <%= e.getMessage() %></td></tr>
                <% } %>
            </tbody>
        </table>

        <a href="attendance_management.jsp" class="btn btn-primary">Back to Dashboard</a>
    </div>
</body>
</html>
