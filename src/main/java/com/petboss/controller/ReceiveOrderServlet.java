package com.petboss.controller;

import com.petboss.dao.ReceiveOrderDAO;
import com.petboss.dao.ReceiveDAO;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;

@WebServlet("/receive-order")
public class ReceiveOrderServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderId = request.getParameter("orderId");
        String tab = request.getParameter("tab");
        if (tab == null) tab = "pending";

        ReceiveOrderDAO orderDao = new ReceiveOrderDAO();
        ReceiveDAO receiveDao = new ReceiveDAO();

        if (orderId == null) {
            // ===== LIST PAGE =====
            if ("completed".equals(tab)) {
                request.setAttribute(
                    "orderList",
                    orderDao.getCompletedReceiveOrders()
                );
            } else {
                request.setAttribute(
                    "orderList",
                    orderDao.getPendingReceiveOrders()
                );
            }

            request.setAttribute("tab", tab);

            request.getRequestDispatcher("/pm/receiveOrder.jsp")
                   .forward(request, response);

        } else {
            // ===== DETAIL PAGE =====
            request.setAttribute(
                "order",
                orderDao.getOrderById(orderId)
            );

            request.setAttribute(
                "itemList",
                receiveDao.getOrderItems(orderId)
            );

            request.setAttribute(
                "receiveHistory",
                receiveDao.getReceiveHistory(orderId)
            );

            request.getRequestDispatcher("/pm/receiveProductDetail.jsp")
                   .forward(request, response);
        }
    }
}
