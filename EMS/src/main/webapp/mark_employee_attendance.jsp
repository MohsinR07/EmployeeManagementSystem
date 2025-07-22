<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mark Attendance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <% 
        HttpSession sessionObj = request.getSession(false);
        if (sessionObj == null || sessionObj.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int empId = (int) sessionObj.getAttribute("id");
        String empName = (String) sessionObj.getAttribute("user");
        boolean alreadyMarked = false;
        String message = "";

        try {
            Connection con = DBConnect.getConnection();
            
            // ✅ Check if already marked today
            String checkQuery = "SELECT COUNT(*) FROM attendance WHERE emp_id = ? AND date = CURDATE()";
            PreparedStatement checkPs = con.prepareStatement(checkQuery);
            checkPs.setInt(1, empId);
            ResultSet checkRs = checkPs.executeQuery();
            if (checkRs.next() && checkRs.getInt(1) > 0) {
                alreadyMarked = true;
                message = "You have already marked attendance today.";
            }

            // ✅ If attendance is not marked, insert the new record
            if (!alreadyMarked && request.getMethod().equalsIgnoreCase("POST")) {
                String status = request.getParameter("status");
                String insertQuery = "INSERT INTO attendance (emp_id, date, status) VALUES (?, CURDATE(), ?)";
                PreparedStatement insertPs = con.prepareStatement(insertQuery);
                insertPs.setInt(1, empId);
                insertPs.setString(2, status);
                int rows = insertPs.executeUpdate();
                if (rows > 0) {
                    message = "Attendance marked successfully!";
                    alreadyMarked = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <div class="container mt-5">
        <h2>Mark Attendance</h2>
        <h4>Employee: <%= empName %> (ID: <%= empId %>)</h4>

        <% if (message != "") { %>
            <div class="alert alert-info"><%= message %></div>
        <% } %>

        <% if (!alreadyMarked) { %>
        <form method="post">
            <label>Status:</label>
            <select name="status" class="form-select" required>
                <option value="Present">Present</option>
                <option value="Absent">Absent</option>
                <option value="Leave">Leave</option>
            </select>
            <button type="submit" class="btn btn-success mt-2">Mark Attendance</button>
        </form>
        <% } %>
        
        <a href="employee_attendance.jsp" class="btn btn-primary mt-3">Back to Attendance</a>
    </div>
</body>
</html>
