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

        String action = req.getParameter("action");

        if ("view".equals(action)) {
            String qcId = req.getParameter("qcId");

            req.setAttribute("qc", dao.getQCById(qcId));
            req.getRequestDispatcher("/pm/viewQC.jsp")
               .forward(req, res);
            return;
        }

        // ===== EXISTING LIST LOGIC =====
        String tab = req.getParameter("tab");
        if (tab == null) tab = "pending";

        if ("completed".equals(tab)) {
            req.setAttribute("qcList", dao.getCompletedQC());
        } else {
            req.setAttribute("qcList", dao.getPendingQC());
        }

        req.setAttribute("tab", tab);
        req.getRequestDispatcher("/pm/productQC.jsp")
           .forward(req, res);
    }

    /* ===============================
       SAVE QC
       =============================== */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String batch = req.getParameter("batchNumber");
        String condition = req.getParameter("condition");
        String remarks = req.getParameter("remarks");
        String staffId = (String) req.getSession().getAttribute("staffId");

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