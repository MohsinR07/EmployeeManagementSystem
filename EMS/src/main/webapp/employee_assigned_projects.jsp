<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assigned Projects</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <% 
        // ✅ Session Handling
        HttpSession sessionObj = request.getSession(false);
        if (sessionObj == null || sessionObj.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // ✅ Employee ID Fetch from Session
        int empId = (int) sessionObj.getAttribute("id");
    %>

    <div class="container mt-5">
        <h2>Assigned Projects</h2>

        <%-- ✅ Success/Error Message Section --%>
        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
        %>
            <div class="alert alert-info text-center"><%= message %></div>
        <% } %>
        
        <table class="table table-bordered mt-3">
            <thead>
                <tr>
                    <th>Project Name</th>
                    <th>Description</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Status</th>
                    <th>Update Status</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    try {
                        Connection con = DBConnect.getConnection();
                        if (con == null) {
                            out.println("<tr><td colspan='6' class='text-center text-danger'>Database connection failed!</td></tr>");
                            return;
                        }
                        
                        // ✅ Fetch Assigned Projects for the Employee
                        PreparedStatement ps = con.prepareStatement(
                            "SELECT p.id, p.name, p.description, p.start_date, p.end_date, p.status " +
                            "FROM projects p " +
                            "JOIN project_employees pe ON p.id = pe.project_id " +
                            "WHERE pe.emp_id = ?"
                        );
                        ps.setInt(1, empId);
                        ResultSet rs = ps.executeQuery();

                        boolean hasData = false;
                        while (rs.next()) {
                            hasData = true;
                %>
                <tr>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("description") %></td>
                    <td><%= rs.getDate("start_date") %></td>
                    <td><%= rs.getDate("end_date") %></td>
                    <td><%= rs.getString("status") %></td>
                    <td>
                        <form action="employee_update_project_status.jsp" method="post">
                            <input type="hidden" name="project_id" value="<%= rs.getInt("id") %>">
                            <select name="status" class="form-select">
                                <option value="Pending" <%= rs.getString("status").equals("Pending") ? "selected" : "" %>>Pending</option>
                                <option value="In Progress" <%= rs.getString("status").equals("In Progress") ? "selected" : "" %>>In Progress</option>
                                <option value="Completed" <%= rs.getString("status").equals("Completed") ? "selected" : "" %>>Completed</option>
                            </select>
                            <button type="submit" class="btn btn-primary mt-1">Update</button>
                        </form>
                    </td>
                </tr>
                <% 
                        }
                        if (!hasData) {
                            out.println("<tr><td colspan='6' class='text-center text-danger'>No projects assigned yet.</td></tr>");
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
