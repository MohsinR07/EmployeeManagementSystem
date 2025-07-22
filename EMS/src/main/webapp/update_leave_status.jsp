<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>

<%
    String leaveId = request.getParameter("leave_id");
    String action = request.getParameter("action");

    // ✅ Debugging ke liye print karo
    out.println("Leave ID: " + leaveId);
    out.println("Action: " + action);

    if (leaveId != null && action != null) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnect.getConnection();
            if (conn == null) {
                throw new Exception("Database Connection Failed!");
            }

            // ✅ Debug: Query print karne ke liye
            out.println("Executing SQL: UPDATE leaves SET status = '" + action + "' WHERE id = " + leaveId);

            // ✅ Query execution
            String query = "UPDATE leaves SET status = ? WHERE id = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, action); // Action = 'Approved' ya 'Rejected'
            stmt.setInt(2, Integer.parseInt(leaveId));

            int updated = stmt.executeUpdate();

            out.println("Rows Updated: " + updated);

            stmt.close();
            conn.close();

            if (updated > 0) {
                response.sendRedirect("view_leaves.jsp?success=Leave status updated");
            } else {
                response.sendRedirect("view_leaves.jsp?error=No record updated");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    } else {
        out.println("Error: Invalid Request - Leave ID or Action is missing.");
    }
%>
