<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>
<%
    String projectId = request.getParameter("id");
    String name = "", description = "", startDate = "", endDate = "";

    if (projectId != null) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnect.getConnection();
            String query = "SELECT * FROM projects WHERE id=?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(projectId));
            rs = stmt.executeQuery();

            if (rs.next()) {
                name = rs.getString("name");
                description = rs.getString("description");
                startDate = rs.getString("start_date");
                endDate = rs.getString("end_date");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Project</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Edit Project</h2>
        <form action="update_project_details.jsp" method="post">
            <input type="hidden" name="project_id" value="<%= projectId %>">
            <div class="mb-3">
                <label class="form-label">Project Name:</label>
                <input type="text" class="form-control" name="name" value="<%= name %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Description:</label>
                <textarea class="form-control" name="description" required><%= description %></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">Start Date:</label>
                <input type="date" class="form-control" name="start_date" value="<%= startDate %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">End Date:</label>
                <input type="date" class="form-control" name="end_date" value="<%= endDate %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Update Project</button>
        </form>
    </div>
</body>
</html>
