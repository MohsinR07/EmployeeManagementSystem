<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <title>Leave Report</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Leave Report</h2>
        
        <table class="table table-bordered">
            <tr>
                <th>Employee Name</th>
                <th>Leave Type</th>
                <th>Start Date</th>  <%-- ✅ Updated Column --%>
                <th>End Date</th>    <%-- ✅ Updated Column --%>
                <th>Status</th>
                <th>Reason</th>
            </tr>
            <% 
                try {
                    Connection conn = DBConnect.getConnection();
                    if (conn == null) {
                        throw new Exception("Database Connection Failed!");
                    }

                    // ✅ Updated Query to match table columns
                    String query = "SELECT l.id, u.name, l.leave_type, l.start_date, l.end_date, l.status, l.reason " +
                                   "FROM leaves l JOIN users u ON l.emp_id = u.id";

                    PreparedStatement stmt = conn.prepareStatement(query);
                    ResultSet rs = stmt.executeQuery();

                    boolean hasData = false;

                    while (rs.next()) { 
                        hasData = true;
            %>
                        <tr>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("leave_type") %></td>
                            <td><%= rs.getDate("start_date") %></td> <%-- ✅ Updated Column --%>
                            <td><%= rs.getDate("end_date") %></td> <%-- ✅ Updated Column --%>
                            <td><%= rs.getString("status") %></td>
                            <td><%= rs.getString("reason") %></td>
                        </tr>
            <% 
                    }
                    if (!hasData) {
            %>
                        <tr><td colspan="6" class="text-center">No leave records found.</td></tr>
            <% 
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) { 
                    e.printStackTrace();
            %>
                <tr><td colspan="6" class="text-danger">Error fetching leave report: <%= e.getMessage() %></td></tr>
            <% 
                } 
            %>
        </table>
    </div>
</body>
</html>
