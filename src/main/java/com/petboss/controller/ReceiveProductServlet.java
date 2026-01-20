package com.petboss.controller;

import com.petboss.dao.ReceiveDAO;
import com.petboss.dao.ReceiveOrderDAO;
import com.petboss.dao.ActivityLogDAO;
import com.petboss.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/receive-product")
public class ReceiveProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /* ===============================
       BLOCK GET (SAFETY)
       =============================== */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        response.sendRedirect(
            request.getContextPath() + "/receive-order"
        );
    }

    /* ===============================
       HANDLE RECEIVE PRODUCT
       =============================== */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("staffId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String staffName = (String) session.getAttribute("staffName");

        String orderId       = request.getParameter("orderId");
        String orderDetailId = request.getParameter("orderDetailId");
        String productId     = request.getParameter("productId");
        String productName   = request.getParameter("productName");
        String arrivalDate   = request.getParameter("arrivalDate");
        String qtyStr        = request.getParameter("quantityReceived");
        String invoiceNo     = request.getParameter("invoiceNo");

        Connection con = null;

        try {
            /* ===============================
               BASIC VALIDATION
               =============================== */
            if (orderDetailId == null || orderDetailId.isBlank()
             || productId == null     || productId.isBlank()
             || qtyStr == null        || qtyStr.isBlank()
             || arrivalDate == null   || arrivalDate.isBlank()) {

                throw new Exception("Please complete all required fields.");
            }

            int odId = Integer.parseInt(orderDetailId);
            int qty  = Integer.parseInt(qtyStr);

            if (qty <= 0) {
                throw new Exception("Quantity must be greater than 0.");
            }

            /* ===============================
               START TRANSACTION
               =============================== */
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            ReceiveDAO dao = new ReceiveDAO();

            dao.receiveProduct(
                odId,
                productId,
                qty,
                orderId,
                arrivalDate,
                invoiceNo
            );

            /* ===============================
               ACTIVITY LOG
               =============================== */
            ActivityLogDAO.log(
                con,
                staffName,
                "received product " + productName + " for order " + orderId
            );

            con.commit(); // ✅ COMMIT ALL

            response.sendRedirect(
                request.getContextPath()
                + "/receive-order?orderId=" + orderId
            );

        } catch (Exception e) {

            try {
                if (con != null) con.rollback(); // 🔥 ROLLBACK
            } catch (Exception ignored) {}

            request.setAttribute("errorMessage", e.getMessage());

            // 🔑 retain popup values
            request.setAttribute("popupOrderDetailId", orderDetailId);
            request.setAttribute("popupProductId", productId);
            request.setAttribute("popupProductName", productName);
            request.setAttribute("popupQty", qtyStr);
            request.setAttribute("popupArrivalDate", arrivalDate);
            request.setAttribute("popupInvoiceNo", invoiceNo);

            ReceiveOrderDAO orderDao = new ReceiveOrderDAO();
            ReceiveDAO receiveDao   = new ReceiveDAO();

            request.setAttribute("order", orderDao.getOrderById(orderId));
            request.setAttribute("itemList", receiveDao.getOrderItems(orderId));
            request.setAttribute("receiveHistory", receiveDao.getReceiveHistory(orderId));

            request.getRequestDispatcher(
                "/pm/receiveProductDetail.jsp"
            ).forward(request, response);

        } finally {

            try {
                if (con != null) con.close();
            } catch (Exception ignored) {}
        }
    }
}
