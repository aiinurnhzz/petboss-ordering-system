package com.petboss.controller;

import com.petboss.dao.ProductQCDAO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/product-qc")
public class ProductQCServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProductQCDAO dao = new ProductQCDAO();

    /* ===============================
       LOAD PAGE
       =============================== */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // 🔐 Session check
        if (session == null || session.getAttribute("staffId") == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String role = String.valueOf(session.getAttribute("role"));

        boolean isPM = "Purchasing Manager".equalsIgnoreCase(role);
        boolean isStaff = "Staff".equalsIgnoreCase(role);

        if (!isPM && !isStaff) {
            res.sendRedirect(req.getContextPath() + "/unauthorized.jsp");
            return;
        }

        String action = req.getParameter("action");

        // ===============================
        // VIEW QC DETAIL
        // ===============================
        if ("view".equals(action)) {
            String qcId = req.getParameter("qcId");

            req.setAttribute("qc", dao.getQCById(qcId));

            if (isPM) {
                req.getRequestDispatcher("/pm/viewQC.jsp")
                   .forward(req, res);
            } else {
                req.getRequestDispatcher("/staff/viewQC.jsp")
                   .forward(req, res);
            }
            return;
        }

        // ===============================
        // LIST QC
        // ===============================
        String tab = req.getParameter("tab");
        if (tab == null) tab = "pending";

        if ("completed".equals(tab)) {
            req.setAttribute("qcList", dao.getCompletedQC());
        } else {
            req.setAttribute("qcList", dao.getPendingQC());
        }

        req.setAttribute("tab", tab);

        if (isPM) {
            req.getRequestDispatcher("/pm/productQC.jsp")
               .forward(req, res);
        } else {
            // 👇 STAFF QC PAGE
            req.getRequestDispatcher("/staff/productQC.jsp")
               .forward(req, res);
        }
    }

    /* ===============================
       SAVE QC (STAFF & PM)
       =============================== */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("staffId") == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String role = String.valueOf(session.getAttribute("role"));

        // 🔐 Only Staff & PM can save QC
        if (!"Staff".equalsIgnoreCase(role)
         && !"Purchasing Manager".equalsIgnoreCase(role)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String batch = req.getParameter("batchNumber");
        String condition = req.getParameter("condition");
        String remarks = req.getParameter("remarks");
        String staffId = (String) session.getAttribute("staffId");

        String damagedStr  = req.getParameter("quantityDamaged");
        String returnedStr = req.getParameter("quantityReturn");

        int damaged = 0;
        int returned = 0;

        if (damagedStr != null && !damagedStr.isBlank()) {
            damaged = Integer.parseInt(damagedStr);
        }

        if (returnedStr != null && !returnedStr.isBlank()) {
            returned = Integer.parseInt(returnedStr);
        }

        if (returned > damaged) {
            throw new ServletException(
                "Quantity to return cannot exceed quantity damaged."
            );
        }

        try {
            dao.saveQC(batch, condition, damaged, returned, remarks, staffId);
            res.sendRedirect(req.getContextPath() + "/product-qc?tab=completed");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            doGet(req, res);
        }
    }
}
