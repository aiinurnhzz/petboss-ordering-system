package com.petboss.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.petboss.dao.SupplierDAO;
import com.petboss.dao.ActivityLogDAO;
import com.petboss.model.Supplier;

@WebServlet("/updateSupplier")
public class UpdateSupplierServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // =========================
        // SESSION CHECK
        // =========================
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("staffId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String staffName = (String) session.getAttribute("staffName");

        try {
            // =========================
            // UPDATE SUPPLIER
            // =========================
            Supplier s = new Supplier();
            s.setSupplierId(req.getParameter("supplierId"));
            s.setName(req.getParameter("supplierName"));
            s.setEmail(req.getParameter("email"));
            s.setPhone(req.getParameter("phone"));
            s.setAddress(req.getParameter("address"));

            new SupplierDAO().updateSupplier(s);

            // =========================
            // ACTIVITY LOG (VERSI LAMA)
            // =========================
            ActivityLogDAO.log(
                staffName,
                "updated supplier details."
            );

            // optional success toast
            session.setAttribute(
                "toastSuccess",
                "Supplier updated successfully"
            );

            resp.sendRedirect(req.getContextPath() + "/supplier");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error updating supplier", e);
        }
    }
}
