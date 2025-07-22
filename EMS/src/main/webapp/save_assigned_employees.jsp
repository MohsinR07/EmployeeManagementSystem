<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>

<%
    String projectId = request.getParameter("project_id");
    String[] employeeIds = request.getParameterValues("employees[]");

    if (projectId != null && employeeIds != null) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnect.getConnection();
            String sql = "INSERT INTO project_employees (project_id, emp_id) VALUES (?, ?)";

            stmt = conn.prepareStatement(sql);
            for (String empId : employeeIds) {
                stmt.setInt(1, Integer.parseInt(projectId));
                stmt.setInt(2, Integer.parseInt(empId));
                stmt.addBatch();
            }
            stmt.executeBatch();

            response.sendRedirect("project_management.jsp?msg=Employees Assigned Successfully");
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
