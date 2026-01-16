package com.petboss.controller;

import com.petboss.dao.*;
import com.petboss.model.Staff;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // ===== SESSION CHECK =====
        if (session == null || session.getAttribute("staffId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String role    = String.valueOf(session.getAttribute("role"));
        String staffId = (String) session.getAttribute("staffId");

        // ===== PERIOD FILTER (today | week | month) =====
        String period = req.getParameter("period");
        if (period == null || period.isBlank()) {
            period = "today";
        }

        StaffDAO staffDAO         = new StaffDAO();
        ProductDAO productDAO     = new ProductDAO();
        SupplierDAO supplierDAO   = new SupplierDAO();
        DashboardDAO dashboardDAO = new DashboardDAO();

        try {

            // =========================
            // ADMIN DASHBOARD
            // =========================
            if ("ADMIN".equalsIgnoreCase(role)) {

                req.setAttribute("totalStaff", staffDAO.getTotalStaff());
                req.setAttribute("activeMenu", "dashboard");

                req.getRequestDispatcher("/admin/dashboard.jsp")
                   .forward(req, resp);
                return;
            }

            // =========================
            // PURCHASING MANAGER DASHBOARD
            // =========================
            if ("Purchasing Manager".equalsIgnoreCase(role)
             || "PURCHASING_MANAGER".equalsIgnoreCase(role)) {

                Staff staff = staffDAO.getStaffById(staffId);

                req.setAttribute(
                    "staffName",
                    staff != null ? staff.getFullName() : "User"
                );

                // ===== SUMMARY CARDS =====
                req.setAttribute("totalStaff", staffDAO.getTotalStaff());
                req.setAttribute("totalProducts", productDAO.getTotalProducts());
                req.setAttribute("totalSuppliers", supplierDAO.getTotalSuppliers());
                req.setAttribute("lowStockCount", dashboardDAO.getLowStockCount());

                // ===== ALERTS =====
                req.setAttribute(
                    "lowStockList",
                    dashboardDAO.getLowStockProducts()
                );

                // ===== RECENT ACTIVITY (FILTERED) =====
                req.setAttribute(
                    "recentActivities",
                    dashboardDAO.getRecentActivities(period)
                );

                // pass selected period back to JSP
                req.setAttribute("period", period);

                req.getRequestDispatcher("/pm/dashboard.jsp")
                   .forward(req, resp);
                return;
            }

            // =========================
            // OTHER ROLES
            // =========================
            resp.sendRedirect(req.getContextPath() + "/unauthorized.jsp");

        } catch (Exception e) {
            throw new ServletException("Dashboard error", e);
        }
    }
}
