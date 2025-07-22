package com.ems.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.ems.utils.DBConnect;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            response.getWriter().println("Error: Email or Password cannot be empty!");
            return;
        }

        Connection conn = DBConnect.getConnection();
        try {
            // ✅ Query to fetch user details including ID
            String sql = "SELECT id, name, role FROM users WHERE email=? AND password=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, email);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // ✅ Creating Session
                HttpSession session = request.getSession();
                session.setAttribute("id", rs.getInt("id")); // Store ID in session
                session.setAttribute("user", rs.getString("name"));
                session.setAttribute("role", rs.getString("role")); // Store role in session

                // ✅ Redirecting Based on Role
                String role = rs.getString("role");
                if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect("adminDashboard.jsp"); // Redirect Admin
                } else {
                    response.sendRedirect("employeeDashboard.jsp"); // Redirect Employee
                }
            } else {
                response.getWriter().println("Invalid Email or Password!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
