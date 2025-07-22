package com.ems.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SalarySlipServlet")
public class SalarySlipServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String empId = request.getParameter("emp_id");
        response.sendRedirect("salary_slip.jsp?emp_id=" + empId);
    }
}
