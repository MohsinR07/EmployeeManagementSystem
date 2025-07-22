<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.ems.utils.DBConnect" %>

<%
    // ✅ Session Handling
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ✅ Employee ID Fetch
    int empId = (int) sessionObj.getAttribute("id");

    // ✅ Form Data Fetch
    String projectIdStr = request.getParameter("project_id");
    String newStatus = request.getParameter("status");

    // ✅ Data Validation
    if (projectIdStr == null || newStatus == null || projectIdStr.isEmpty() || newStatus.isEmpty()) {
        request.setAttribute("message", "❌ Invalid data. Please try again.");
        request.getRequestDispatcher("employee_assigned_projects.jsp").forward(request, response);
        return;
    }

    int projectId = Integer.parseInt(projectIdStr);

    try {
        Connection con = DBConnect.getConnection();
        if (con == null) {
            request.setAttribute("message", "❌ Database connection failed!");
            request.getRequestDispatcher("employee_assigned_projects.jsp").forward(request, response);
            return;
        }

        // ✅ Employee can only update their assigned projects
        PreparedStatement checkPs = con.prepareStatement(
            "SELECT * FROM project_employees WHERE emp_id = ? AND project_id = ?"
        );
        checkPs.setInt(1, empId);
        checkPs.setInt(2, projectId);
        ResultSet checkRs = checkPs.executeQuery();

        if (!checkRs.next()) {
            request.setAttribute("message", "❌ Unauthorized project update attempt!");
            request.getRequestDispatcher("employee_assigned_projects.jsp").forward(request, response);
            return;
        }

        // ✅ Status Update Query
        PreparedStatement ps = con.prepareStatement("UPDATE projects SET status = ? WHERE id = ?");
        ps.setString(1, newStatus);
        ps.setInt(2, projectId);
        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            request.setAttribute("message", "✅ Project status updated successfully!");
        } else {
            request.setAttribute("message", "❌ Failed to update status. Try again.");
        }

        // ✅ Redirect back with message
        request.getRequestDispatcher("employee_assigned_projects.jsp").forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
