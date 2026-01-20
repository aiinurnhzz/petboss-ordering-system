package com.petboss.controller;

import com.petboss.dao.SupplierDAO;
import com.petboss.dao.ActivityLogDAO;
import com.petboss.model.Supplier;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/pm/addSupplier")
public class AddSupplierServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // ✅ SHOW ADD SUPPLIER PAGE
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // 🔐 Session check
        if (session == null || session.getAttribute("staffId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // 🔐 Role check
        String role = String.valueOf(session.getAttribute("role"));
        if (!"PURCHASING_MANAGER".equalsIgnoreCase(role)
                && !"Purchasing Manager".equalsIgnoreCase(role)) {
            resp.sendRedirect(req.getContextPath() + "/unauthorized.jsp");
            return;
        }

        // 👉 SHOW JSP
        req.getRequestDispatcher("/pm/addSupplier.jsp")
           .forward(req, resp);
    }

    // ✅ HANDLE FORM SUBMIT
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("staffId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String staffName = (String) session.getAttribute("staffName");

        try {
            req.setCharacterEncoding("UTF-8");

            SupplierDAO dao = new SupplierDAO();
            String newSupplierId = dao.generateSupplierId();

            Supplier s = new Supplier();
            s.setSupplierId(newSupplierId);
            s.setName(req.getParameter("supplierName"));
            s.setEmail(req.getParameter("email"));
            s.setPhone(req.getParameter("phone"));
            s.setAddress(req.getParameter("address"));

            // ✅ INSERT SUPPLIER
            boolean success = dao.addSupplier(s);

            if (success) {
                // ✅ ACTIVITY LOG
                ActivityLogDAO.log(
                    con,
                    staffName,
                    "added new supplier"
                );

                con.commit(); // ✅ COMMIT
                session.setAttribute("toastSuccess", "Supplier added successfully");
            } else {
                con.rollback();
                session.setAttribute("toastError", "Failed to add supplier");
            }

            resp.sendRedirect(req.getContextPath() + "/supplier");

        } catch (Exception e) {
            if (con != null) {
                try { con.rollback(); } catch (Exception ignored) {}
            }
            throw new ServletException("Error adding supplier", e);

        } finally {
            if (con != null) {
                try { con.close(); } catch (Exception ignored) {}
            }
        }
    }
}

