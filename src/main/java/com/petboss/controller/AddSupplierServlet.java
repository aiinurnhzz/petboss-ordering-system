package com.petboss.controller;

import com.petboss.dao.SupplierDAO;
import com.petboss.dao.ActivityLogDAO;
import com.petboss.model.Supplier;
import com.petboss.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/pm/addSupplier")
public class AddSupplierServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // =========================
    // SHOW ADD SUPPLIER PAGE
    // =========================
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("staffId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String role = String.valueOf(session.getAttribute("role"));
        if (!"PURCHASING_MANAGER".equalsIgnoreCase(role)
                && !"Purchasing Manager".equalsIgnoreCase(role)) {
            resp.sendRedirect(req.getContextPath() + "/unauthorized.jsp");
            return;
        }

        req.getRequestDispatcher("/pm/addSupplier.jsp")
           .forward(req, resp);
    }

    // =========================
    // HANDLE FORM SUBMIT
    // =========================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("staffId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String staffName = (String) session.getAttribute("staffName");
        Connection con = null;

        try {
            req.setCharacterEncoding("UTF-8");

            // 🔥 START TRANSACTION
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            SupplierDAO dao = new SupplierDAO();
            String newSupplierId = dao.generateSupplierId();

            Supplier s = new Supplier();
            s.setSupplierId(newSupplierId);
            s.setName(req.getParameter("supplierName"));
            s.setEmail(req.getParameter("email"));
            s.setPhone(req.getParameter("phone"));
            s.setAddress(req.getParameter("address"));

            // =========================
            // INSERT SUPPLIER
            // =========================
            boolean success = dao.addSupplier(s);

            if (!success) {
                throw new Exception("Failed to add supplier");
            }

            // =========================
            // ACTIVITY LOG
            // =========================
            ActivityLogDAO.log(
                con,
                staffName,
                "added new supplier"
            );

            // ✅ COMMIT SEMUA
            con.commit();

            session.setAttribute(
                "toastSuccess",
                "Supplier added successfully"
            );

            resp.sendRedirect(req.getContextPath() + "/supplier");

        } catch (Exception e) {

            // 🔥 ROLLBACK JIKA APA-APA FAIL
            try {
                if (con != null) con.rollback();
            } catch (Exception ignored) {}

            e.printStackTrace();
            throw new ServletException("Error adding supplier", e);

        } finally {

            try {
                if (con != null) con.close();
            } catch (Exception ignored) {}
        }
    }
}
