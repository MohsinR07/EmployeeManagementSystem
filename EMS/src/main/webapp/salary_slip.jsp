<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <title>Salary Slip</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script>
        function printSalarySlip() {
            var printContents = document.getElementById("salarySlip").innerHTML;
            var originalContents = document.body.innerHTML;
            document.body.innerHTML = printContents;
            window.print();
            document.body.innerHTML = originalContents;
        }
    </script>
</head>
<body>
    <div class="container mt-4">
        <h2>Salary Slip</h2>

        <%-- Default First Employee Select Karein --%>
        <% 
            int empId = -1;
            String empName = "Not Selected";
            try (Connection conn = DBConnect.getConnection();
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT id, name FROM users ORDER BY id ASC LIMIT 1")) {
                if (rs.next()) {
                    empId = rs.getInt("id");
                    empName = rs.getString("name");
                }
            } catch (Exception e) {
                empName = "Error fetching employee";
            }

            // Agar User Ne Employee Select Kiya Hai, To Use Update Karein
            if (request.getParameter("emp_id") != null) {
                empId = Integer.parseInt(request.getParameter("emp_id"));
                try (Connection conn = DBConnect.getConnection();
                     PreparedStatement pstmt = conn.prepareStatement("SELECT name FROM users WHERE id = ?")) {
                    pstmt.setInt(1, empId);
                    ResultSet rs = pstmt.executeQuery();
                    if (rs.next()) {
                        empName = rs.getString("name");
                    }
                } catch (Exception e) {
                    empName = "Error fetching employee";
                }
            }
        %>

        <%-- Show Selected Employee Name --%>
        <h4>Employee: <%= empName %></h4>

        <%-- Employee Selection Dropdown --%>
        <form method="get">
            <label class="form-label">Select Employee</label>
            <select name="emp_id" class="form-control" required onchange="this.form.submit()">
                <option value="">Select Employee</option>
                <% 
                    try (Connection conn = DBConnect.getConnection();
                         Statement stmt = conn.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT id, name FROM users")) {
                    while (rs.next()) { %>
                        <option value="<%= rs.getInt("id") %>" 
                            <%= (empId == rs.getInt("id")) ? "selected" : "" %> >
                            <%= rs.getString("name") %>
                        </option>
                <% } 
                    } catch (Exception e) { %>
                    <option value="">Error fetching employees</option>
                <% } %>
            </select>
        </form>

        <% if (empId != -1) { %>
            <% 
                try (Connection conn = DBConnect.getConnection();
                     PreparedStatement pstmt = conn.prepareStatement(
                        "SELECT u.name, s.basic_salary, s.allowances, s.deductions, s.net_salary, s.payment_date " +
                        "FROM salary s JOIN users u ON s.emp_id = u.id WHERE s.emp_id = ?")) {
                    pstmt.setInt(1, empId);
                    ResultSet rs = pstmt.executeQuery();
                    if (rs.next()) { 
            %>

        <div id="salarySlip">
            <table class="table table-bordered mt-3">
                <tr><th colspan="2" class="text-center">Salary Slip</th></tr>
                <tr><td>Employee Name</td><td><%= rs.getString("name") %></td></tr>
                <tr><td>Basic Salary</td><td>₹<%= rs.getDouble("basic_salary") %></td></tr>
                <tr><td>Allowances</td><td>₹<%= rs.getDouble("allowances") %></td></tr>
                <tr><td>Deductions</td><td>₹<%= rs.getDouble("deductions") %></td></tr>
                <tr><td>Net Salary</td><td>₹<%= rs.getDouble("net_salary") %></td></tr>
                <tr><td>Payment Date</td><td><%= rs.getDate("payment_date") %></td></tr>
            </table>
        </div>

        <button class="btn btn-primary mt-3" onclick="printSalarySlip()">Print Salary Slip</button>

        <% } else { %>
            <p>No salary details found for selected employee.</p>
        <% } 
            } catch (Exception e) { %>
            <p>Error fetching salary slip: <%= e.getMessage() %></p>
        <% } 
        } %>
    </div>
</body>
</html>
