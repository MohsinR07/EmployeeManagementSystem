package com.ems.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.ems.utils.DBConnect;

@WebServlet("/ApplyLeaveServlet")
public class ApplyLeaveServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int empId = Integer.parseInt(request.getParameter("emp_id"));
            String leaveType = request.getParameter("leave_type");
            String startDate = request.getParameter("start_date");
            String endDate = request.getParameter("end_date");
            String reason = request.getParameter("reason");

            if (leaveType == null || startDate == null || endDate == null || reason == null ||
                leaveType.isEmpty() || startDate.isEmpty() || endDate.isEmpty() || reason.isEmpty()) {
                response.sendRedirect("employee_leave.jsp?error=Invalid Input");
                return;
            }

            Connection con = DBConnect.getConnection();
            String query = "INSERT INTO leaves (emp_id, leave_type, start_date, end_date, reason, status) VALUES (?, ?, ?, ?, ?, 'Pending')";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, empId);
            ps.setString(2, leaveType);
            ps.setString(3, startDate);
            ps.setString(4, endDate);
            ps.setString(5, reason);

            int result = ps.executeUpdate();
            if (result > 0) {
                response.sendRedirect("employee_leave.jsp?success=Leave Applied Successfully");
            } else {
                response.sendRedirect("employee_leave.jsp?error=Failed to Apply Leave");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("employee_leave.jsp?error=Something Went Wrong");
        }
    }
}
