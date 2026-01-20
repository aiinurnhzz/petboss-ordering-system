package com.petboss.controller;

import com.petboss.dao.SupplierDAO;
import com.petboss.dao.OrderDAO;
import com.petboss.dao.OrderDetailDAO;
import com.petboss.dao.ActivityLogDAO;
import com.petboss.model.Supplier;
import com.petboss.model.Order;
import com.petboss.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/pm/createOrder")
public class CreateOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // =========================
    // LOAD CREATE ORDER PAGE
    // =========================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("staffId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        SupplierDAO supplierDAO = new SupplierDAO();
        List<Supplier> supplierList = supplierDAO.getAllSuppliers();

        request.setAttribute("supplierList", supplierList);
        request.getRequestDispatcher("/pm/createOrder.jsp")
               .forward(request, response);
    }

    // =========================
    // SUBMIT ORDER
    // =========================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("staffId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // =========================
        // GET DATA
        // =========================
        String supplierId = request.getParameter("supplierId");
        String orderDate  = request.getParameter("orderDate");

        // IMPORTANT: staffId dari SESSION
        String staffId = (String) session.getAttribute("staffId");
        String staffName = (String) session.getAttribute("staffName");

        String p = request.getParameter("productId[]");
        String q = request.getParameter("quantity[]");
        String u = request.getParameter("unitPrice[]");
        String t = request.getParameter("total[]");

        if (p == null || p.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pm/createOrder");
            return;
        }

        String[] productIds  = p.split(",");
        String[] quantities  = q.split(",");
        String[] unitPrices  = u.split(",");
        String[] totals      = t.split(",");

        // =========================
        // BASIC VALIDATION
        // =========================
        if (productIds.length != quantities.length ||
            productIds.length != unitPrices.length ||
            productIds.length != totals.length) {

            throw new ServletException("Order item data mismatch");
        }

        OrderDAO orderDAO = new OrderDAO();
        OrderDetailDAO detailDAO = new OrderDetailDAO();

        String orderId = orderDAO.generateOrderId();

        double grandTotal = 0;
        for (String x : totals) {
            grandTotal += Double.parseDouble(x);
        }

        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // =========================
            // INSERT ORDER
            // =========================
            String orderDateStr = request.getParameter("orderDate");

            // convert String → java.sql.Date
            java.sql.Date orderDate1 =
                    java.sql.Date.valueOf(orderDateStr);
            Order order = new Order();
            order.setOrderId(orderId);
            order.setSupplierId(supplierId);
            order.setStaffId(staffId);
            order.setOrderDate(orderDate1);
            order.setTotal(grandTotal);

            orderDAO.insertOrder(con, order);

            // =========================
            // INSERT ORDER DETAILS
            // =========================
            for (int i = 0; i < productIds.length; i++) {

                detailDAO.insertOrderDetail(
                        con,
                        orderId,
                        productIds[i].trim(),
                        Integer.parseInt(quantities[i]),
                        Double.parseDouble(unitPrices[i]),
                        Double.parseDouble(totals[i])
                );
            }

            // =========================
            // ACTIVITY LOG
            // =========================
            ActivityLogDAO.log(
                    con,
                    staffName,
                    "added new order"
            );

            con.commit();
            response.sendRedirect(request.getContextPath() + "/order");

        } catch (Exception e) {

            if (con != null) {
                try { con.rollback(); } catch (Exception ignored) {}
            }
            throw new ServletException(e);

        } finally {

            if (con != null) {
                try { con.close(); } catch (Exception ignored) {}
            }
        }
    }
}
