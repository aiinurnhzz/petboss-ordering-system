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

        // ===== PERIOD FILTER =====
        String period = req.getParameter("period");
        if (period == null || period.isBlank()) {
            period = "today";
        }

        StaffDAO staffDAO         = new StaffDAO();
        ProductDAO productDAO     = new ProductDAO();
        SupplierDAO supplierDAO   = new SupplierDAO();
        DashboardDAO dashboardDAO = new DashboardDAO();

        try {
            // =================================================
            // COMMON DATA (SEMUA ROLE – SAMA DATA)
            // =================================================
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

            // ===== RECENT ACTIVITY =====
            req.setAttribute(
                "recentActivities",
                dashboardDAO.getRecentActivities(period)
            );

            req.setAttribute("period", period);
            req.setAttribute("activeMenu", "dashboard");

            // =================================================
            // ROLE-BASED DASHBOARD (DESIGN SAMA, JSP BERBEZA)
            // =================================================

            // ===== ADMIN =====
            if ("ADMIN".equalsIgnoreCase(role)) {
                req.getRequestDispatcher("/admin/dashboard.jsp")
                   .forward(req, resp);
                return;
            }

            // ===== PURCHASING MANAGER (KEKAL) =====
            if ("Purchasing Manager".equalsIgnoreCase(role)
             || "PURCHASING_MANAGER".equalsIgnoreCase(role)) {

                req.getRequestDispatcher("/pm/dashboard.jsp")
                   .forward(req, resp);
                return;
            }

            // ===== STAFF =====
            if ("STAFF".equalsIgnoreCase(role)) {
                req.getRequestDispatcher("/staff/dashboard.jsp")
                   .forward(req, resp);
                return;
            }

            // ===== UNKNOWN ROLE =====
            resp.sendRedirect(req.getContextPath() + "/unauthorized.jsp");

        } catch (Exception e) {
            throw new ServletException("Dashboard error", e);
        }
    }
}
