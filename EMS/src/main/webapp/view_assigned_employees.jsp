<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <title>Assigned Employees</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Assigned Employees</h2>

        <a href="project_management.jsp" class="btn btn-secondary mb-3">Back to Projects</a>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Employee Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Assigned Date</th>
                </tr>
            </thead>
            <tbody>
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    // Get project ID from request
                    String projectIdParam = request.getParameter("id");
                    int projectId = 0;
                    if (projectIdParam != null && !projectIdParam.isEmpty()) {
                        projectId = Integer.parseInt(projectIdParam);
                    }

                    conn = DBConnect.getConnection();
                    String query = "SELECT u.name, u.email, u.role, pe.assigned_date " +
                                   "FROM project_employees pe " +
                                   "JOIN users u ON pe.emp_id = u.id " +
                                   "WHERE pe.project_id = ?";
                    
                    stmt = conn.prepareStatement(query);
                    stmt.setInt(1, projectId);
                    rs = stmt.executeQuery();

                    boolean hasData = false;
                    while (rs.next()) {
                        hasData = true;
            %>
                <tr>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("role") %></td>
                    <td><%= rs.getTimestamp("assigned_date") %></td>
                </tr>
            <% 
                    }
                    if (!hasData) {
            %>
                <tr><td colspan="4" class="text-center">No employees assigned to this project.</td></tr>
            <% 
                    }
                } catch (Exception e) { 
            %>
                <tr><td colspan="4" class="text-danger">Error fetching assigned employees: <%= e.getMessage() %></td></tr>
            <% 
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                }
            %>
            </tbody>
        </table>
    </div>
</body>
</html>
