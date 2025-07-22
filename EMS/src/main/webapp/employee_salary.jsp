<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Salary Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { width: 70%; margin: auto; padding: 20px; border: 1px solid black; }
        .title { text-align: center; font-size: 24px; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid black; padding: 10px; text-align: left; }
        .btn-print { margin-top: 20px; display: flex; justify-content: center; }
    </style>
    
    <script>
        function printSalarySlip() {
            var printContent = document.getElementById("salarySlip").innerHTML;
            var originalContent = document.body.innerHTML;
            document.body.innerHTML = printContent;
            window.print();
            document.body.innerHTML = originalContent;
        }
    </script>
</head>
<body>
    <% 
        HttpSession sessionObj = request.getSession(false);
        if (sessionObj == null || sessionObj.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Session se Employee ID fetch karna
        int empId = (int) sessionObj.getAttribute("id");
        String empName = "Not Found"; // Default value agar naam na mile

        // Debugging: Employee ID print karna
        System.out.println("DEBUG: Employee ID from session = " + empId);

        try {
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT name FROM users WHERE id = ?");
            ps.setInt(1, empId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                empName = rs.getString("name"); // Name fetch karna
            } else {
                System.out.println("DEBUG: No Employee Found for ID = " + empId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    
    <div class="container mt-5">
        <h2>Salary Details</h2>

        <div id="salarySlip">
            <h3 class="mt-4 text-center">Salary Slip</h3>
            <h4 class="text-center">Employee Name: <%= empName %></h4>

            <table class="table table-bordered mt-3">
                <thead>
                    <tr>
                        <th>Basic Salary</th>
                        <th>Allowances</th>
                        <th>Deductions</th>
                        <th>Net Salary</th>
                        <th>Payment Status</th>
                        <th>Payment Date</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        try {
                            Connection con = DBConnect.getConnection();
                            PreparedStatement ps = con.prepareStatement("SELECT basic_salary, allowances, deductions, net_salary, payment_status, payment_date FROM salary WHERE emp_id = ?");
                            ps.setInt(1, empId);
                            ResultSet rs = ps.executeQuery();
                            if (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getDouble("basic_salary") %></td>
                        <td><%= rs.getDouble("allowances") %></td>
                        <td><%= rs.getDouble("deductions") %></td>
                        <td><%= rs.getDouble("net_salary") %></td>
                        <td><%= rs.getString("payment_status") %></td>
                        <td><%= rs.getDate("payment_date") %></td>
                    </tr>
                    <% 
                            } else {
                    %>
                    <tr>
                        <td colspan="6" class="text-center">No Salary Data Available</td>
                    </tr>
                    <% 
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
        </div>

        <!-- Print Button -->
        <div class="btn-print">
            <button onclick="printSalarySlip()" class="btn btn-success">Print Salary Slip</button>
        </div>
    </div>
</body>
</html>
