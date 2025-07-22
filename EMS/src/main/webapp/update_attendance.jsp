<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Attendance</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Update Attendance</h2>
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

            <label class="mt-2">Select Date:</label>
            <input type="date" name="date" class="form-control" required>

            <label class="mt-2">Update Status:</label>
            <select name="status" class="form-control" required>
                <option value="Present">Present</option>
                <option value="Absent">Absent</option>
                <option value="Leave">Leave</option>
            </select>

            <button type="submit" name="update_attendance" class="btn btn-primary mt-3">Update Attendance</button>
        </form>

        <% 
            if (request.getParameter("update_attendance") != null) {
                int empId = Integer.parseInt(request.getParameter("emp_id"));
                String date = request.getParameter("date");
                String status = request.getParameter("status");

                try (Connection conn = DBConnect.getConnection();
                     PreparedStatement stmt = conn.prepareStatement("UPDATE attendance SET status=? WHERE emp_id=? AND date=?")) {

                    stmt.setString(1, status);
                    stmt.setInt(2, empId);
                    stmt.setString(3, date);
                    int rows = stmt.executeUpdate();

                    if (rows > 0) {
                        out.println("<p class='text-success'>Attendance updated successfully.</p>");
                    } else {
                        out.println("<p class='text-warning'>No record found for selected date.</p>");
                    }
                } catch (Exception e) {
                    out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</body>
</html>
