package com.petboss.controller;

import com.petboss.dao.SupplierDAO;
import com.petboss.model.Supplier;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/supplier")
public class SupplierServlet extends HttpServlet {

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

        String role = String.valueOf(session.getAttribute("role"));

        // 🔐 Role validation
        boolean isAdmin = "Admin".equalsIgnoreCase(role);
        boolean isPM = "Purchasing Manager".equalsIgnoreCase(role)
                     || "PURCHASING_MANAGER".equalsIgnoreCase(role);
        boolean isStaff = "Staff".equalsIgnoreCase(role);

        if (!isAdmin && !isPM && !isStaff) {
            resp.sendRedirect(req.getContextPath() + "/unauthorized.jsp");
            return;
        }

        // 🔍 Search + AJAX flag
        String keyword = req.getParameter("keyword");
        String ajax = req.getParameter("ajax");

        SupplierDAO dao = new SupplierDAO();

        try {
            List<Supplier> suppliers;

            if (keyword == null || keyword.isBlank()) {
                suppliers = dao.getAllSuppliers();
            } else {
                suppliers = dao.searchSupplier(keyword);
            }

            // ✅ AJAX REQUEST → RETURN JSON (ALL ROLES VIEW)
            if ("true".equals(ajax)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");

                StringBuilder json = new StringBuilder("[");
                for (int i = 0; i < suppliers.size(); i++) {
                    Supplier s = suppliers.get(i);

                    json.append("{")
                        .append("\"id\":\"").append(s.getSupplierId()).append("\",")
                        .append("\"name\":\"").append(s.getName()).append("\",")
                        .append("\"email\":\"").append(s.getEmail()).append("\",")
                        .append("\"phone\":\"").append(s.getPhone()).append("\",")
                        .append("\"address\":\"").append(s.getAddress()).append("\"")
                        .append("}");

                    if (i < suppliers.size() - 1) json.append(",");
                }
                json.append("]");

                resp.getWriter().write(json.toString());
                return;
            }

            // 🖥 NORMAL PAGE LOAD
            req.setAttribute("suppliers", suppliers);
            req.setAttribute("activeMenu", "supplier");

            if (isAdmin) {
                req.getRequestDispatcher("/admin/supplier.jsp").forward(req, resp);
            } else if (isPM) {
                req.getRequestDispatcher("/pm/supplier.jsp").forward(req, resp);
            } else {
                // 👇 STAFF VIEW ONLY
                req.getRequestDispatcher("/staff/supplier.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            throw new ServletException("Error loading supplier list", e);
        }
    }
}

