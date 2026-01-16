package com.petboss.controller;

import com.petboss.dao.OrderDAO;
import com.petboss.dao.SupplierDAO;
import com.petboss.model.Order;
import com.petboss.model.OrderItem;
import com.petboss.model.Supplier;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // =========================
        // AUTH CHECK
        // =========================
        if (session == null || session.getAttribute("staffId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String ajax   = request.getParameter("ajax");

        OrderDAO orderDAO = new OrderDAO();

        // =========================
        // CREATE ORDER PAGE
        // =========================
        if ("create".equals(action)) {

            SupplierDAO supplierDAO = new SupplierDAO();
            List<Supplier> supplierList = supplierDAO.getAllSuppliers();

            request.setAttribute("supplierList", supplierList);

            request.getRequestDispatcher("/pm/createOrder.jsp")
                   .forward(request, response);
            return;
        }

        // =========================
        // VIEW ORDER DETAILS
        // =========================
        if ("view".equals(action)) {

            String orderId = request.getParameter("id");

            Order order = orderDAO.getOrderWithNames(orderId);
            List<OrderItem> orderItems = orderDAO.getOrderItems(orderId);

            double subtotal = 0;
            for (OrderItem item : orderItems) {
                subtotal += item.getTotal();
            }

            double tax = subtotal * 0.06;
            double grandTotal = subtotal + tax;

            request.setAttribute("order", order);
            request.setAttribute("orderItems", orderItems);
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("tax", tax);
            request.setAttribute("grandTotal", grandTotal);

            request.getRequestDispatcher("/pm/viewOrder.jsp")
                   .forward(request, response);
            return;
        }

        // =========================
        // AJAX LIVE SEARCH
        // =========================
        if ("true".equalsIgnoreCase(request.getParameter("ajax"))) {

            String keyword = request.getParameter("keyword");
            String year    = request.getParameter("year");

            if (keyword == null) keyword = "";
            if (year != null && year.isBlank()) year = null;

            List<Order> list = orderDAO.searchOrders(keyword.trim(), year);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            PrintWriter out = response.getWriter();
            out.print("[");

            for (int i = 0; i < list.size(); i++) {
                Order o = list.get(i);

                out.print("{");
                out.print("\"orderId\":\"" + o.getOrderId() + "\",");
                out.print("\"supplierName\":\"" + o.getSupplierName() + "\",");
                out.print("\"staffName\":\"" + o.getStaffName() + "\",");
                out.print("\"orderDate\":\"" + o.getOrderDate() + "\",");
                out.print("\"total\":" + o.getTotal());
                out.print("}");

                if (i < list.size() - 1) out.print(",");
            }

            out.print("]");
            out.flush();
            return;
        }


        // =========================
        // ORDER LIST PAGE (DEFAULT)
        // =========================
        List<Order> orderList = orderDAO.getAllOrdersWithNames();
        request.setAttribute("orderList", orderList);

        request.getRequestDispatcher("/pm/order.jsp")
               .forward(request, response);
    }
}
