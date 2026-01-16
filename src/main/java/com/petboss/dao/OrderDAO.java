package com.petboss.dao;
import com.petboss.model.Order;
import com.petboss.model.OrderItem;
import com.petboss.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    /* ===============================
       GENERATE ORDER ID
       =============================== */
    public String generateOrderId() {

        String sql = "SELECT MAX(order_id) FROM orders";
        int next = 1;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next() && rs.getString(1) != null) {
                next = Integer.parseInt(rs.getString(1).substring(4)) + 1;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "ORD-" + String.format("%04d", next);
    }

    /* ===============================
       INSERT ORDER
       =============================== */
    public void insertOrder(Connection con, Order order) throws SQLException {

        String sql = """
            INSERT INTO orders
            (order_id, supplier_id, staff_id, order_date, total_amount)
            VALUES (?, ?, ?, ?, ?)
        """;

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, order.getOrderId());
            ps.setString(2, order.getSupplierId());
            ps.setString(3, order.getStaffId());
            ps.setDate(4, new java.sql.Date(order.getOrderDate().getTime()));

            ps.setDouble(5, order.getTotal());

            ps.executeUpdate();
        }
    }

    /* ===============================
       GET ALL ORDERS (LIST PAGE)
       =============================== */
    public List<Order> getAllOrdersWithNames() {

        List<Order> list = new ArrayList<>();

        String sql = """
            SELECT
                o.order_id,
                o.order_date,
                o.total_amount,
                s.supplier_name,
                st.full_name
            FROM orders o
            JOIN supplier s ON o.supplier_id = s.supplier_id
            JOIN staff st ON o.staff_id = st.staff_id
            ORDER BY o.order_date DESC
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getString("order_id"));
                o.setOrderDate(rs.getDate("order_date"));
                o.setTotal(rs.getDouble("total_amount"));
                o.setSupplierName(rs.getString("supplier_name"));
                o.setStaffName(rs.getString("full_name"));
                list.add(o);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /* ===============================
       GET SINGLE ORDER (VIEW PAGE)
       =============================== */
    public Order getOrderWithNames(String orderId) {

        Order o = null;

        String sql = """
            SELECT
                o.order_id,
                o.order_date,
                o.total_amount,
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
                o.setTotal(rs.getDouble("total_amount"));
                o.setSupplierName(rs.getString("supplier_name"));
                o.setStaffName(rs.getString("full_name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return o;
    }

    /* ===============================
       SEARCH ORDERS (AJAX)
       =============================== */
    public List<Order> searchOrders(String keyword, String year) {

        List<Order> list = new ArrayList<>();

        String sql = """
            SELECT
                o.order_id,
                o.order_date,
                o.total_amount,
                s.supplier_name,
                st.full_name
            FROM orders o
            JOIN supplier s ON o.supplier_id = s.supplier_id
            JOIN staff st ON o.staff_id = st.staff_id
            WHERE (
                LOWER(o.order_id) LIKE ?
                OR LOWER(s.supplier_name) LIKE ?
                OR LOWER(st.full_name) LIKE ?
            )
        """;

        // 🔹 Add year filter ONLY if selected
        if (year != null && !year.isEmpty()) {
            sql += " AND EXTRACT(YEAR FROM o.order_date) = ? ";
        }

        sql += " ORDER BY o.order_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String kw = "%" + keyword.toLowerCase() + "%";

            // 🔹 Keyword params
            ps.setString(1, kw);
            ps.setString(2, kw);
            ps.setString(3, kw);

            // 🔹 Year param (only if exists)
            if (year != null && !year.isEmpty()) {
                ps.setInt(4, Integer.parseInt(year));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getString("order_id"));
                o.setOrderDate(rs.getDate("order_date"));
                o.setTotal(rs.getDouble("total_amount"));
                o.setSupplierName(rs.getString("supplier_name"));
                o.setStaffName(rs.getString("full_name"));
                list.add(o);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /* ===============================
       GET ORDER ITEMS
       =============================== */
    public List<OrderItem> getOrderItems(String orderId) {

        List<OrderItem> list = new ArrayList<>();

        String sql = """
            SELECT
                d.product_id,
                p.name AS product_name,
                d.quantity_ordered,
                d.unit_price,
                d.total_price
            FROM orderdetail d
            JOIN product p ON d.product_id = p.product_id
            WHERE d.order_id = ?
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem i = new OrderItem();
                i.setProductId(rs.getString("product_id"));
                i.setProductName(rs.getString("product_name"));
                i.setQuantity(rs.getInt("quantity_ordered"));
                i.setUnitPrice(rs.getDouble("unit_price"));
                i.setTotal(rs.getDouble("total_price"));
                list.add(i);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
