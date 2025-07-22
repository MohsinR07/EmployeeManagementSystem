<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>

<%
    String projectId = request.getParameter("project_id");
    String name = request.getParameter("name");
    String description = request.getParameter("description");
    String startDate = request.getParameter("start_date");
    String endDate = request.getParameter("end_date");

    if (projectId != null && name != null && description != null && startDate != null && endDate != null) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnect.getConnection();
            String sql = "UPDATE projects SET name=?, description=?, start_date=?, end_date=? WHERE id=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setString(3, startDate);
            stmt.setString(4, endDate);
            stmt.setInt(5, Integer.parseInt(projectId));

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("project_management.jsp?msg=Project Updated Successfully");
            } else {
                response.sendRedirect("project_management.jsp?error=Update Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("project_management.jsp?error=Database Error");
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    } else {
        response.sendRedirect("project_management.jsp?error=Invalid Request");
    }
%>
