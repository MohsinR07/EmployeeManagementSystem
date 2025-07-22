<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.ems.utils.DBConnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Change Password</h2>

        <%  
            HttpSession sessionObj = request.getSession(false);
            if (sessionObj == null || sessionObj.getAttribute("id") == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            int empId = (Integer) sessionObj.getAttribute("id"); 
            String message = "";

            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String oldPass = request.getParameter("old_password");
                String newPass = request.getParameter("new_password");
                String confirmPass = request.getParameter("confirm_password");

                if (newPass.equals(confirmPass)) {
                    try {
                        Connection con = DBConnect.getConnection();
                        
                        // ✅ Check old password
                        PreparedStatement ps = con.prepareStatement("SELECT password FROM users WHERE id=?");
                        ps.setInt(1, empId);
                        ResultSet rs = ps.executeQuery();

                        if (rs.next() && rs.getString("password").equals(oldPass)) {
                            // ✅ Update new password
                            PreparedStatement updatePs = con.prepareStatement("UPDATE users SET password=? WHERE id=?");
                            updatePs.setString(1, newPass);
                            updatePs.setInt(2, empId);
                            int updated = updatePs.executeUpdate();

                            if (updated > 0) {
                                message = "<div class='alert alert-success'>Password changed successfully!</div>";
                            } else {
                                message = "<div class='alert alert-danger'>Failed to update password. Try again!</div>";
                            }
                        } else {
                            message = "<div class='alert alert-danger'>Old password is incorrect!</div>";
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        message = "<div class='alert alert-danger'>Something went wrong!</div>";
                    }
                } else {
                    message = "<div class='alert alert-danger'>New passwords do not match!</div>";
                }
            }
        %>

        <%= message %>

        <form method="post">
            <div class="mb-3">
                <label class="form-label">Old Password</label>
                <input type="password" class="form-control" name="old_password" required>
            </div>
            <div class="mb-3">
                <label class="form-label">New Password</label>
                <input type="password" class="form-control" name="new_password" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Confirm New Password</label>
                <input type="password" class="form-control" name="confirm_password" required>
            </div>
            <button type="submit" class="btn btn-primary">Change Password</button>
            <a href="employee_profile.jsp" class="btn btn-secondary">Back to Profile</a>
        </form>
    </div>
</body>
</html>
