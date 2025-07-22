package com.ems.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ems.utils.DBConnect;

@WebServlet("/DownloadSalarySlipServlet")
public class EmployeeSalarySlipServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int empId = Integer.parseInt(request.getParameter("emp_id"));

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "SELECT u.name, s.basic_salary, s.allowances, s.deductions, s.net_salary, s.payment_status, s.payment_date " +
                 "FROM salary s JOIN users u ON s.emp_id = u.id WHERE s.emp_id = ?")) {
            
            ps.setInt(1, empId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                out.println("<html><head><title>Salary Slip</title>");
                out.println("<style>");
                out.println("body { font-family: Arial, sans-serif; margin: 20px; }");
                out.println(".container { width: 60%; margin: auto; padding: 20px; border: 1px solid black; }");
                out.println(".title { text-align: center; font-size: 24px; font-weight: bold; }");
                out.println("table { width: 100%; border-collapse: collapse; margin-top: 10px; }");
                out.println("th, td { border: 1px solid black; padding: 10px; text-align: left; }");
                out.println(".btn-print { margin-top: 20px; display: flex; justify-content: center; }");
                out.println("</style>");
                out.println("</head><body>");

                out.println("<div class='container'>");
                out.println("<div class='title'>Salary Slip</div>");
                out.println("<p><strong>Employee Name:</strong> " + rs.getString("name") + "</p>");
                out.println("<p><strong>Employee ID:</strong> " + empId + "</p>");
                out.println("<p><strong>Payment Date:</strong> " + rs.getDate("payment_date") + "</p>");

                out.println("<table>");
                out.println("<tr><th>Basic Salary</th><td>" + rs.getDouble("basic_salary") + "</td></tr>");
                out.println("<tr><th>Allowances</th><td>" + rs.getDouble("allowances") + "</td></tr>");
                out.println("<tr><th>Deductions</th><td>" + rs.getDouble("deductions") + "</td></tr>");
                out.println("<tr><th>Net Salary</th><td>" + rs.getDouble("net_salary") + "</td></tr>");
                out.println("<tr><th>Payment Status</th><td>" + rs.getString("payment_status") + "</td></tr>");
                out.println("</table>");

                out.println("<div class='btn-print'><button onclick='window.print()'>Print Salary Slip</button></div>");
                out.println("</div>");

                out.println("</body></html>");
            } else {
                out.println("<h3>No salary record found for this employee.</h3>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error fetching salary details!</h3>");
        }
    }
}
