<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mark Attendance</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Mark Attendance</h2>

        <% 
            String message = "";
            if (request.getParameter("submit") != null) {
                try {
                    int empId = Integer.parseInt(request.getParameter("emp_id"));
                    String date = request.getParameter("date");
                    String status = request.getParameter("status");

                    Connection conn = DBConnect.getConnection();
                    PreparedStatement stmt = conn.prepareStatement("INSERT INTO attendance (emp_id, date, status) VALUES (?, ?, ?)");
                    stmt.setInt(1, empId);
                    stmt.setString(2, date);
                    stmt.setString(3, status);

                    int rows = stmt.executeUpdate();
                    if (rows > 0) {
                        message = "<p class='text-success'>Attendance marked successfully.</p>";
                    } else {
                        message = "<p class='text-danger'>Failed to mark attendance.</p>";
                    }
                    conn.close();
                } catch (Exception e) {
                    message = "<p class='text-danger'>Error: " + e.getMessage() + "</p>";
                }
            }
        %>

        <form method="post">
            <label>Select Employee:</label>
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

            <label class="mt-2">Date:</label>
            <input type="date" name="date" class="form-control" required>

            <label class="mt-2">Status:</label>
            <select name="status" class="form-control">
                <option value="Present">Present</option>
                <option value="Absent">Absent</option>
                <option value="Leave">Leave</option>
            </select>

            <button type="submit" name="submit" class="btn btn-success mt-3">Submit</button>
        </form>

        <!-- Show Success or Error Message -->
        <%= message %>
    </div>
</body>
</html>
