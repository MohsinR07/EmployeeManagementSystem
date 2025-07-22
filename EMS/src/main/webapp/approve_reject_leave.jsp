<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>

<%
    String leaveId = request.getParameter("leave_id");
    String action = request.getParameter("action");
    String status = "";

    if ("Approved".equals(action)) {
        status = "Approved";
    } else if ("Rejected".equals(action)) {
        status = "Rejected";
    } else {
        response.sendRedirect("view_leaves.jsp?error=Invalid Action");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    
    try {
        conn = DBConnect.getConnection();
        if (conn == null) {
            throw new Exception("Database Connection Failed!");
        }
        
        String query = "UPDATE leaves SET status = ? WHERE id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, status);
        stmt.setInt(2, Integer.parseInt(leaveId));
        
        int rowsUpdated = stmt.executeUpdate();
        if (rowsUpdated > 0) {
            response.sendRedirect("view_leaves.jsp?success=Leave request " + status + " successfully");
        } else {
            response.sendRedirect("view_leaves.jsp?error=Leave request not found");
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("view_leaves.jsp?error=" + e.getMessage());
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
