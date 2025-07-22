<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Leave Requests</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Pending Leave Requests</h2>

        <%-- ✅ Error Message (If Any) --%>
        <% String errorMessage = (String) request.getAttribute("error"); %>
        <% if (errorMessage != null) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
        <% } %>

        <table class="table table-bordered">
            <tr>
                <th>Employee Name</th>
                <th>Leave Type</th>
                <th>Start Date</th>  <%-- ✅ Updated Column --%>
                <th>End Date</th>    <%-- ✅ Updated Column --%>
                <th>Reason</th>
                <th>Action</th>
            </tr>
            <% 
                try {
                    Connection conn = DBConnect.getConnection();
                    if (conn == null) {
                        throw new Exception("Database Connection Failed!");
                    }

                    // ✅ Updated Query to match table columns
                    String query = "SELECT l.id, u.name, l.leave_type, l.start_date, l.end_date, l.reason " +
                                   "FROM leaves l JOIN users u ON l.emp_id = u.id " +
                                   "WHERE l.status = 'Pending'";

                    PreparedStatement stmt = conn.prepareStatement(query);
                    ResultSet rs = stmt.executeQuery();

                    boolean hasData = false; // Flag to check if any record is found

                    while (rs.next()) { 
                        hasData = true; // At least one record found
            %>
                        <tr>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("leave_type") %></td>
                            <td><%= rs.getDate("start_date") %></td> <%-- ✅ Updated Column --%>
                            <td><%= rs.getDate("end_date") %></td> <%-- ✅ Updated Column --%>
                            <td><%= rs.getString("reason") %></td>
                            <td>
                                <form method="post" action="update_leave_status.jsp" class="d-inline">
                                    <input type="hidden" name="leave_id" value="<%= rs.getInt("id") %>">
                                    <button type="submit" name="action" value="Approved" class="btn btn-success btn-sm">Approve</button>
                                    <button type="submit" name="action" value="Rejected" class="btn btn-danger btn-sm">Reject</button>
                                </form>
                            </td>
                        </tr>
            <% 
                    }
                    if (!hasData) { // No records found case
            %>
                        <tr><td colspan="6" class="text-center">No pending leave requests found.</td></tr>
            <% 
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) { 
                    e.printStackTrace();
            %>
                <tr><td colspan="6" class="text-danger">Error fetching leave requests: <%= e.getMessage() %></td></tr>
            <% 
                } 
            %>
        </table>
    </div>
</body>
</html>
