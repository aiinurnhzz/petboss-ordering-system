package com.petboss.controller;

import com.petboss.dao.ReceiveDAO;
import com.petboss.dao.ReceiveOrderDAO;
import com.petboss.dao.ActivityLogDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/receive-product")
public class ReceiveProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // ===============================
    // BLOCK GET (SAFETY)
    // ===============================
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        response.sendRedirect(
            request.getContextPath() + "/receive-order"
        );
    }

    // ===============================
    // HANDLE RECEIVE PRODUCT
    // ===============================
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

        try {
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

            ReceiveDAO dao = new ReceiveDAO();
            dao.receiveProduct(
                odId, productId, qty, orderId, arrivalDate, invoiceNo
            );

            // ===============================
            // ACTIVITY LOG (AFTER SUCCESS)
            // ===============================
            ActivityLogDAO.log(
                staffName,
                "received product " + productName + " for order " + orderId + "."
            );

            response.sendRedirect(
                request.getContextPath()
                + "/receive-order?orderId=" + orderId
            );
            return;

        } catch (Exception e) {

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
        }
    }
}
