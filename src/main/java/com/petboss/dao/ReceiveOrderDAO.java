package com.petboss.dao;

import com.petboss.model.ReceiveOrder;
import com.petboss.model.Order;
import com.petboss.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReceiveOrderDAO {

    // ===============================
    // GET PENDING / PARTIALLY RECEIVED
    // ===============================
    public List<ReceiveOrder> getPendingReceiveOrders() {

        List<ReceiveOrder> list = new ArrayList<>();

        String sql = """
            SELECT
                o.order_id,
                s.supplier_name,
                o.order_date,
                o.order_status,
                COUNT(od.orderdetail_id) AS item_count
            FROM orders o
            JOIN supplier s ON o.supplier_id = s.supplier_id
            LEFT JOIN orderdetail od ON o.order_id = od.order_id
            WHERE o.order_status IN ('SUBMITTED','PARTIALLY_RECEIVED')
            GROUP BY
                o.order_id, s.supplier_name, o.order_date, o.order_status
            ORDER BY o.order_date DESC
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ReceiveOrder r = new ReceiveOrder();
                r.setOrderId(rs.getString("order_id"));
                r.setSupplierName(rs.getString("supplier_name"));
                r.setOrderDate(rs.getDate("order_date"));
                r.setStatus(rs.getString("order_status"));
                r.setItemCount(rs.getInt("item_count"));
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ===============================
    // GET COMPLETED ORDERS
    // ===============================
    public List<ReceiveOrder> getCompletedReceiveOrders() {

        List<ReceiveOrder> list = new ArrayList<>();

        String sql = """
            SELECT
                o.order_id,
                s.supplier_name,
                o.order_date,
                o.order_status,
                COUNT(od.orderdetail_id) AS item_count
            FROM orders o
            JOIN supplier s ON o.supplier_id = s.supplier_id
            LEFT JOIN orderdetail od ON o.order_id = od.order_id
            WHERE o.order_status = 'COMPLETED'
            GROUP BY
                o.order_id, s.supplier_name, o.order_date, o.order_status
            ORDER BY o.order_date DESC
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ReceiveOrder r = new ReceiveOrder();
                r.setOrderId(rs.getString("order_id"));
                r.setSupplierName(rs.getString("supplier_name"));
                r.setOrderDate(rs.getDate("order_date"));
                r.setStatus(rs.getString("order_status"));
                r.setItemCount(rs.getInt("item_count"));
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ===============================
    // GET ORDER HEADER (DETAIL PAGE)
    // ===============================
    public Order getOrderById(String orderId) {

        Order o = null;

        String sql = """
            SELECT
                o.order_id,
                o.order_date,
                o.order_status,
                s.supplier_name,
                st.full_name
            FROM orders o
            JOIN supplier s ON o.supplier_id = s.supplier_id
            JOIN staff st ON o.staff_id = st.staff_id
            WHERE o.order_id = ?
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                o = new Order();
                o.setOrderId(rs.getString("order_id"));
                o.setOrderDate(rs.getDate("order_date"));
                o.setStatus(rs.getString("order_status"));
                o.setSupplierName(rs.getString("supplier_name"));
                o.setStaffName(rs.getString("full_name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return o;
    }

    // ===============================
    // AUTO UPDATE ORDER STATUS
    // ===============================
   public void updateOrderStatus(String orderId) {
        String sql = """
            UPDATE orders o
            SET order_status =
                CASE
                    WHEN NOT EXISTS (
                        SELECT 1
                        FROM orderdetail d
                        LEFT JOIN receive r
                            ON d.orderdetail_id = r.orderdetail_id
                        WHERE d.order_id = o.order_id
                        GROUP BY d.orderdetail_id, d.quantity_ordered
                        HAVING COALESCE(SUM(r.quantity_received), 0) < d.quantity_ordered
                    )
                    THEN 'COMPLETED'
                    ELSE 'PARTIALLY_RECEIVED'
                END
            WHERE o.order_id = ?
        """;
    
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
    
            ps.setString(1, orderId);
            ps.executeUpdate();
    
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

