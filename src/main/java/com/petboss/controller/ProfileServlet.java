package com.petboss.controller;

import com.petboss.dao.StaffDAO;
import com.petboss.model.Staff;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet({"/profile"})
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // 🔐 Session check
        if (session == null || session.getAttribute("staffId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String staffId = (String) session.getAttribute("staffId");
        String role = String.valueOf(session.getAttribute("role"));

        try {
            StaffDAO dao = new StaffDAO();
            Staff staff = dao.getStaffById(staffId);

            if (staff == null) {
                resp.sendRedirect(req.getContextPath() + "/login.jsp");
                return;
            }

            // 📦 Send staff data to JSP
            req.setAttribute("staff", staff);

            // =========================
            // ADMIN PROFILE
            // =========================
            if ("ADMIN".equalsIgnoreCase(role)) {
                req.getRequestDispatcher("/admin/profile.jsp")
                   .forward(req, resp);
                return;
            }

            // =========================
            // PURCHASING MANAGER PROFILE
            // =========================
            if ("Purchasing Manager".equalsIgnoreCase(role)) {
                req.getRequestDispatcher("/pm/profile.jsp")
                   .forward(req, resp);
                return;
            }

            // =========================
            // OTHER ROLES
            // =========================
            resp.sendRedirect(req.getContextPath() + "/unauthorized.jsp");

        } catch (Exception e) {
            throw new ServletException("Error loading profile", e);
        }
    }
}
