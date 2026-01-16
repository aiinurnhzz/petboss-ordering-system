package com.petboss.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class OrderDetailDAO {

    /* =========================================
       INSERT ORDER DETAIL
       (Used with transaction from OrderServlet)
       ========================================= */
    public void insertOrderDetail(
            Connection con,
            String orderId,
            String productId,
            int quantity,
            double unitPrice,
            double totalPrice
    ) throws SQLException {

        String sql = """
            INSERT INTO orderdetail
            (order_id, product_id, quantity_ordered, unit_price, total_price)
            VALUES (?, ?, ?, ?, ?)
        """;

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, orderId);
            ps.setString(2, productId);
            ps.setInt(3, quantity);        // quantity_ordered
            ps.setDouble(4, unitPrice);
            ps.setDouble(5, totalPrice);   // total_price

            ps.executeUpdate();
        }
    }

    /* =========================================
       DELETE ALL ORDER DETAILS BY ORDER ID
       (For rollback / delete order)
       ========================================= */
    public void deleteByOrderId(Connection con, String orderId)
            throws SQLException {

        String sql = "DELETE FROM order_detail WHERE order_id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, orderId);
            ps.executeUpdate();
        }
    }
}
