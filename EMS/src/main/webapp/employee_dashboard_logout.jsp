<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.IOException" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj != null) {
        sessionObj.invalidate(); // Invalidate session
    }
    response.sendRedirect("login.jsp"); // Redirect to login page
%>
