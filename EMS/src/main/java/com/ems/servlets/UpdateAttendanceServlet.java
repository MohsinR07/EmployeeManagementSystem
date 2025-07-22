package com.ems.servlets;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.ems.utils.DBConnect;

@WebServlet("/UpdateAttendanceServlet")
public class UpdateAttendanceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("UPDATE attendance SET status = ? WHERE id = ?")) {
            pstmt.setString(1, status);
            pstmt.setInt(2, id);
            pstmt.executeUpdate();
            response.sendRedirect("attendance_management.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
