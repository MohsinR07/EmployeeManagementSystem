<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>
<%
    String name = request.getParameter("name");
    String description = request.getParameter("description");
    String start_date = request.getParameter("start_date");
    String end_date = request.getParameter("end_date");
    
    try {
        Connection conn = DBConnect.getConnection();
        String query = "INSERT INTO projects (name, description, start_date, end_date) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, name);
        stmt.setString(2, description);
        stmt.setString(3, start_date);
        stmt.setString(4, end_date);
        stmt.executeUpdate();
        stmt.close();
        conn.close();
        response.sendRedirect("project_management.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>