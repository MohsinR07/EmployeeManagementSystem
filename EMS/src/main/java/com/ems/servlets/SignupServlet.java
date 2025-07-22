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

import com.ems.utils.DBConnect;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // ✅ Role bhi fetch karein

        try {
            Connection conn = DBConnect.getConnection();

            // ✅ Step 1: Check if email already exists
            String checkEmailSQL = "SELECT email FROM users WHERE email = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkEmailSQL);
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                response.sendRedirect("signup.jsp?error=Email already exists!"); // ✅ Duplicate Email Error
                return;
            }

            // ✅ Step 2: Insert new user with role
            String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role); // ✅ Role Store Karna

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("login.jsp"); // ✅ Redirect to Login Page
            } else {
                response.sendRedirect("signup.jsp?error=Signup Failed!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("signup.jsp?error=Database Error!");
        }
    }
}
