package com.petboss.controller;

import com.petboss.dao.StaffDAO;
import com.petboss.model.Staff;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Always go to login page
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String staffId = request.getParameter("staffId");
        String password = request.getParameter("password");

        if (staffId == null || staffId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=invalid");
            return;
        }

        staffId = staffId.trim().toUpperCase();

        try {
            StaffDAO staffDAO = new StaffDAO();
            Staff staff = staffDAO.authenticate(staffId); // ✅ BETUL

            // ❌ Staff not found
            if (staff == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=invalid");
                return;
            }

            // 🔵 FIRST TIME LOGIN
            if (staff.getPassword() == null) {
                HttpSession tempSession = request.getSession(true);
                tempSession.setAttribute("tempStaffId", staff.getStaffId());

                response.sendRedirect(
                    request.getContextPath() + "/createPassword.jsp"
                );
                return;
            }

            // 🔒 STATUS CHECK
            if (!"ACTIVE".equalsIgnoreCase(staff.getStatus())) {
                response.sendRedirect(
                    request.getContextPath() + "/login.jsp?error=inactive");
                return;
            }

            // 🔒 PASSWORD CHECK
            if (password == null || !staff.getPassword().equals(password)) {
                response.sendRedirect(
                    request.getContextPath() + "/login.jsp?error=invalid");
                return;
            }

            // 🍪 REMEMBER ME
            if ("on".equals(request.getParameter("rememberMe"))) {
                Cookie cookie = new Cookie("rememberStaffId", staff.getStaffId());
                cookie.setMaxAge(7 * 24 * 60 * 60);
                cookie.setHttpOnly(true);
                response.addCookie(cookie);
            }

            // ✅ LOGIN SUCCESS
            HttpSession session = request.getSession(true);
            session.setAttribute("staffId", staff.getStaffId());
            session.setAttribute("role", staff.getRole());
            session.setAttribute("status", staff.getStatus());
            session.setAttribute("staffName", staff.getFullName());

            response.sendRedirect(request.getContextPath() + "/dashboard");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(
                request.getContextPath() + "/login.jsp?error=invalid");
        }
    }
}

            

