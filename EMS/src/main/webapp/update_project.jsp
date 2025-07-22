<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>

<%
    String status = request.getParameter("status");
    String projectId = request.getParameter("project_id");

    if (status != null && projectId != null) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnect.getConnection();
            String sql = "UPDATE projects SET status = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, Integer.parseInt(projectId));
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
