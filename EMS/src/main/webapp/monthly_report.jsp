<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <title>Monthly Attendance Report</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script>
        function printReport() {
            var printContents = document.getElementById("reportTable").outerHTML;
            var originalContents = document.body.innerHTML;
            document.body.innerHTML = "<html><head><title>Print Report</title></head><body>" + printContents + "</body></html>";
            window.print();
            document.body.innerHTML = originalContents;
            location.reload(); // Reload page after printing
        }
    </script>
</head>
<body>
    <div class="container mt-4">
        <h2>Monthly Attendance Report</h2>
        <form method="post">
            <label>Employee ID:</label>
            <input type="number" name="emp_id" class="form-control" required>

            <label class="mt-2">Select Month:</label>
            <input type="month" name="month" class="form-control" required>

            <button type="submit" name="view_report" class="btn btn-primary mt-3">View Report</button>
        </form>

        <%-- Fetch and Display Monthly Attendance --%>
        <%
            if (request.getParameter("view_report") != null) {
                int empId = Integer.parseInt(request.getParameter("emp_id"));
                String month = request.getParameter("month") + "-01"; // Convert month input to valid date format
                String empName = "Unknown"; // Default value

                try (Connection conn = DBConnect.getConnection()) {
                    // Employee name fetch karne ki query
                    PreparedStatement empStmt = conn.prepareStatement("SELECT name FROM users WHERE id = ?");
                    empStmt.setInt(1, empId);
                    ResultSet empRs = empStmt.executeQuery();
                    if (empRs.next()) {
                        empName = empRs.getString("name");
                    }
                    empRs.close();
                    empStmt.close();

                    // Attendance report fetch karne ki query
                    PreparedStatement stmt = conn.prepareStatement(
                        "SELECT date, status FROM attendance WHERE emp_id = ? " +
                        "AND date >= ? AND date < DATE_ADD(?, INTERVAL 1 MONTH) ORDER BY date ASC");

                    stmt.setInt(1, empId);
                    stmt.setString(2, month);
                    stmt.setString(3, month);
                    ResultSet rs = stmt.executeQuery();
        %>

        <div id="reportTable">
            <h4 class="mt-4">Employee: <%= empName %> (ID: <%= empId %>)</h4>
            <table class="table table-bordered mt-3">
                <tr>
                    <th>Date</th>
                    <th>Status</th>
                </tr>
                <%
                    boolean hasData = false;
                    while (rs.next()) {
                        hasData = true;
                %>
                <tr>
                    <td><%= rs.getDate("date") %></td>
                    <td><%= rs.getString("status") %></td>
                </tr>
                <% } 
                    if (!hasData) { %>
                    <tr><td colspan="2" class="text-center">No attendance records found for this month.</td></tr>
                <% } 
                    rs.close();
                    stmt.close();
                    conn.close();
                    } catch (Exception e) {
                        out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                    }
                }
            %>
            </table>
        </div>

        <%-- Print Button --%>
        <button class="btn btn-secondary mt-3" onclick="printReport()">Print Report</button>

    </div>
</body>
</html>
