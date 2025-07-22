<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>

<%
    String projectId = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Assign Employees</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Assign Employees to Project</h2>
        <form action="save_assigned_employees.jsp" method="post">
            <input type="hidden" name="project_id" value="<%= projectId %>">
            
            <div class="mb-3">
                <label>Select Employees:</label><br>
                
                <%
                    Connection conn = DBConnect.getConnection();
                    PreparedStatement stmt = conn.prepareStatement(
                        "SELECT u.id, u.name, " +
                        "EXISTS (SELECT 1 FROM project_employees pe WHERE pe.emp_id = u.id AND pe.project_id = ?) AS assigned " +
                        "FROM users u"
                    );
                    stmt.setInt(1, Integer.parseInt(projectId));
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
                        boolean isAssigned = rs.getBoolean("assigned");
                %>
                        <div class="form-check">
                            <input type="checkbox" name="employees[]" value="<%= rs.getInt("id") %>" 
                                   class="form-check-input" <%= isAssigned ? "disabled" : "" %>>
                            <label class="form-check-label"><%= rs.getString("name") %></label>
                        </div>
                <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                %>
            </div>
            <button type="submit" class="btn btn-primary">Assign Employees</button>
        </form>
    </div>
</body>
</html>
