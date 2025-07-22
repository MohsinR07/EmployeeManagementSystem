package com.ems.servlets;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AttendanceServlet")
public class AttendanceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems", "root", "password")) {
            if ("mark".equals(action)) {
                int empId = Integer.parseInt(request.getParameter("emp_id"));
                String status = request.getParameter("status");
                PreparedStatement ps = conn.prepareStatement("INSERT INTO attendance (emp_id, date, status) VALUES (?, CURDATE(), ?)");
                ps.setInt(1, empId);
                ps.setString(2, status);
                ps.executeUpdate();
                response.sendRedirect("attendance.jsp?success=Attendance Marked");
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String status = request.getParameter("status");
                PreparedStatement ps = conn.prepareStatement("UPDATE attendance SET status=? WHERE id=?");
                ps.setString(1, status);
                ps.setInt(2, id);
                ps.executeUpdate();
                response.sendRedirect("attendance.jsp?success=Attendance Updated");
            }
        } catch (Exception e) {
            response.sendRedirect("attendance.jsp?error=" + e.getMessage());
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems", "root", "password")) {
            if ("view_today".equals(action)) {
                request.setAttribute("query", "SELECT u.name, a.status FROM attendance a JOIN users u ON a.emp_id = u.id WHERE a.date = CURDATE()");
                request.getRequestDispatcher("attendance_view.jsp").forward(request, response);
            } else if ("monthly_report".equals(action)) {
                int empId = Integer.parseInt(request.getParameter("emp_id"));
                request.setAttribute("query", "SELECT date, status FROM attendance WHERE emp_id = " + empId + " AND MONTH(date) = MONTH(CURDATE())");
                request.getRequestDispatcher("attendance_monthly.jsp").forward(request, response);
            }
        } catch (Exception e) {
            response.sendRedirect("attendance.jsp?error=" + e.getMessage());
        }
    }
}
