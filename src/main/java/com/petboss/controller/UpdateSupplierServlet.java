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

@WebServlet("/updateSupplier")
public class UpdateSupplierServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        /* =========================
           SESSION CHECK
           ========================= */
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("staffId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String staffName = (String) session.getAttribute("staffName");
        Connection con = null;

        try {
            req.setCharacterEncoding("UTF-8");

            /* =========================
               START TRANSACTION
               ========================= */
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            /* =========================
               UPDATE SUPPLIER
               ========================= */
            Supplier s = new Supplier();
            s.setSupplierId(req.getParameter("supplierId"));
            s.setName(req.getParameter("supplierName"));
            s.setEmail(req.getParameter("email"));
            s.setPhone(req.getParameter("phone"));
            s.setAddress(req.getParameter("address"));

            SupplierDAO supplierDAO = new SupplierDAO();
            supplierDAO.updateSupplier(s);

            /* =========================
               ACTIVITY LOG
               ========================= */
            ActivityLogDAO.log(
                con,
                staffName,
                "updated supplier details"
            );

            con.commit(); // ✅ COMMIT SEMUA

            // optional success toast
            session.setAttribute(
                "toastSuccess",
                "Supplier updated successfully"
            );

            resp.sendRedirect(req.getContextPath() + "/supplier");

        } catch (Exception e) {

            try {
                if (con != null) con.rollback(); // 🔥 ROLLBACK
            } catch (Exception ignored) {}

            e.printStackTrace();
            throw new ServletException("Error updating supplier", e);

        } finally {

            try {
                if (con != null) con.close();
            } catch (Exception ignored) {}
        }
    }
}
