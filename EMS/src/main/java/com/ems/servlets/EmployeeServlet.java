package com.ems.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.ems.utils.DBConnect;

@WebServlet("/EmployeeServlet")
public class EmployeeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) { 
            int id = Integer.parseInt(request.getParameter("id"));
            deleteEmployee(id);
            request.getSession().setAttribute("successMessage", "Employee Deleted Successfully!");
            response.sendRedirect("employee_management.jsp"); 
            return;
        }

        if ("update".equals(action)) { 
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String role = request.getParameter("role");
            double salary = Double.parseDouble(request.getParameter("salary"));

            updateEmployee(id, name, email, role, salary);
            request.getSession().setAttribute("successMessage", "Employee Updated Successfully!");
            response.sendRedirect("employee_management.jsp");
            return;
        }

        try {
            Connection conn = DBConnect.getConnection();
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password"); 
            String role = request.getParameter("role");
            double salary = Double.parseDouble(request.getParameter("salary"));

            String sql = "INSERT INTO users (name, email, password, role, salary) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, password);
            pstmt.setString(4, role);
            pstmt.setDouble(5, salary);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                request.getSession().setAttribute("successMessage", "Employee Added Successfully!");
                response.sendRedirect("employee_management.jsp");
            } else {
                response.getWriter().println("Employee Insertion Failed!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    private void deleteEmployee(int id) {
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM users WHERE id = ?")) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void updateEmployee(int id, String name, String email, String role, double salary) {
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE users SET name=?, email=?, role=?, salary=? WHERE id=?")) {
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, role);
            stmt.setDouble(4, salary);
            stmt.setInt(5, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
