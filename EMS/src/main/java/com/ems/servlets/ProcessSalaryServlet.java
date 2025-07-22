package com.ems.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.ems.utils.DBConnect;

@WebServlet("/ProcessSalaryServlet")
public class ProcessSalaryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int empId = Integer.parseInt(request.getParameter("emp_id"));
            double basicSalary = Double.parseDouble(request.getParameter("basic_salary"));
            
            // Allowances & Deductions ko safely parse karein
            double allowances = request.getParameter("allowances") != null && !request.getParameter("allowances").isEmpty()
                                ? Double.parseDouble(request.getParameter("allowances"))
                                : 0.0;
            double deductions = request.getParameter("deductions") != null && !request.getParameter("deductions").isEmpty()
                                ? Double.parseDouble(request.getParameter("deductions"))
                                : 0.0;
                                
            double netSalary = basicSalary + allowances - deductions;
            Date paymentDate = new Date(System.currentTimeMillis());
            String paymentStatus = "Paid";

            // Database Connection
            try (Connection conn = DBConnect.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(
                     "INSERT INTO salary (emp_id, basic_salary, allowances, deductions, net_salary, payment_status, payment_date) VALUES (?, ?, ?, ?, ?, ?, ?)"
                 )) {

                pstmt.setInt(1, empId);
                pstmt.setDouble(2, basicSalary);
                pstmt.setDouble(3, allowances);
                pstmt.setDouble(4, deductions);
                pstmt.setDouble(5, netSalary);
                pstmt.setString(6, paymentStatus);
                pstmt.setDate(7, paymentDate);
                
                int rowsInserted = pstmt.executeUpdate();
                if (rowsInserted > 0) {
                    System.out.println("Salary Processed Successfully for Emp ID: " + empId);
                    request.getSession().setAttribute("successMessage", "Salary processed successfully!");
                } else {
                    System.out.println("Salary Processing Failed for Emp ID: " + empId);
                    request.getSession().setAttribute("errorMessage", "Failed to process salary!");
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Invalid input! Please enter valid numbers.");
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Database error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Something went wrong!");
        }

        response.sendRedirect("payment_management.jsp");
    }
}
