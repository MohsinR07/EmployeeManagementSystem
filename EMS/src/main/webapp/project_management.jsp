<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <title>Project Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Project List</h2>

        <%-- ✅ Success & Error Messages --%>
        <% String message = request.getParameter("msg"); %>
        <% String error = request.getParameter("error"); %>
        <% if (message != null) { %>
            <div class="alert alert-success"><%= message %></div>
        <% } %>
        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <a href="add_project.jsp" class="btn btn-primary mb-3">Assign New Project</a>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <% 
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                try {
                    conn = DBConnect.getConnection();
                    String query = "SELECT * FROM projects";
                    stmt = conn.prepareStatement(query);
                    rs = stmt.executeQuery();
                    
                    boolean hasData = false;
                    while (rs.next()) { 
                        hasData = true;
            %>
                <tr>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("description") %></td>
                    <td><%= rs.getDate("start_date") %></td>
                    <td><%= rs.getDate("end_date") %></td>
                    
                    <%-- ✅ Status Dropdown --%>
                    <td>
                        <form method="post" action="update_project.jsp">
                            <input type="hidden" name="project_id" value="<%= rs.getInt("id") %>">
                            <select name="status" class="form-select">
                                <option value="Pending" <%= rs.getString("status").equals("Pending") ? "selected" : "" %>>Pending</option>
                                <option value="In Progress" <%= rs.getString("status").equals("In Progress") ? "selected" : "" %>>In Progress</option>
                                <option value="Completed" <%= rs.getString("status").equals("Completed") ? "selected" : "" %>>Completed</option>
                            </select>
                            <button type="submit" class="btn btn-primary btn-sm mt-1">Update</button>
                        </form>
                    </td>
                    <td>
                        <a href="edit_project.jsp?id=<%= rs.getInt("id") %>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="assign_employee.jsp?id=<%= rs.getInt("id") %>" class="btn btn-info btn-sm mt-1">Assign Employee</a>
                        <a href="view_assigned_employees.jsp?id=<%= rs.getInt("id") %>" class="btn btn-success btn-sm mt-1">View</a>
                    </td>
                </tr>
            <% 
                    }
                    if (!hasData) { 
            %>
                <tr><td colspan="6" class="text-center">No projects found.</td></tr>
            <% 
                    }
                } catch (Exception e) { 
                    e.printStackTrace();
            %>
                <tr><td colspan="6" class="text-danger">Error fetching projects: <%= e.getMessage() %></td></tr>
            <% 
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } 
            %>
            </tbody>
        </table>
    </div>
</body>
</html>
