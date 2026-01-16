package com.petboss.dao;

import com.petboss.model.OrderItem;
import com.petboss.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReceiveDAO {

    // ===============================
    // GET ORDER ITEMS + RECEIVED QTY
    // ===============================
    public List<OrderItem> getOrderItems(String orderId) {

        List<OrderItem> list = new ArrayList<>();

        String sql = """
            SELECT
                od.orderdetail_id,
                od.product_id,
                p.name AS product_name,
                od.quantity_ordered,
                NVL(SUM(r.quantity_received),0) AS received_qty
            FROM orderdetail od
            JOIN product p ON od.product_id = p.product_id
            LEFT JOIN receive r ON od.orderdetail_id = r.orderdetail_id
            WHERE od.order_id = ?
            GROUP BY
                od.orderdetail_id,
                od.product_id,
                p.name,
                od.quantity_ordered
            ORDER BY od.product_id
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem i = new OrderItem();
                i.setOrderDetailId(rs.getInt("orderdetail_id"));
                i.setProductId(rs.getString("product_id"));
                i.setProductName(rs.getString("product_name"));
                i.setQuantity(rs.getInt("quantity_ordered"));
                i.setReceived(rs.getInt("received_qty"));
                list.add(i);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    
    private int getNextBatchSequence(String productId) {

        int nextSeq = 1;

        String sql = """
            SELECT COUNT(*) + 1 AS next_seq
            FROM receive r
            JOIN orderdetail od
                ON r.orderdetail_id = od.orderdetail_id
            WHERE od.product_id = ?
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                nextSeq = rs.getInt("next_seq");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return nextSeq;
    }

    
    private java.time.LocalDate getOrderDate(String orderId) throws Exception {

        String sql = "SELECT order_date FROM orders WHERE order_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDate("order_date").toLocalDate();
            }
        }

        throw new Exception("Order date not found.");
    }

    
    // ===============================
    // RECEIVE PRODUCT (INSERT)
    // ===============================
    public void receiveProduct(
    	    int orderDetailId,
    	    String productId,
    	    int quantity,
    	    String orderId,
    	    String arrivalDate,
    	    String invoiceNo
    	) throws Exception
    	{
    	// ===============================
    	// VALIDATE ARRIVAL DATE
    	// ===============================
    	java.time.LocalDate arrival =
    	    java.time.LocalDate.parse(arrivalDate);

    	java.time.LocalDate today =
    	    java.time.LocalDate.now();

    	if (arrival.isAfter(today)) {
    	    throw new Exception("Arrival date cannot be in the future.");
    	}

    	// ===== VALIDATE AGAINST ORDER DATE =====
    	java.time.LocalDate orderDate = getOrderDate(orderId);

    	if (arrival.isBefore(orderDate)) {
    	    throw new Exception(
    	        "Arrival date cannot be earlier than order date (" + orderDate + ")."
    	    );
    	}
    	
    	String sql = """
    	        INSERT INTO receive
    	        (batch_number, orderdetail_id, invoice_no, quantity_received, arrival_date)
    	        VALUES (?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'))
    	    """;

    	    try (Connection con = DBConnection.getConnection();
    	         PreparedStatement ps = con.prepareStatement(sql)) {

    	        String datePart =
    	            new java.text.SimpleDateFormat("yyyyMMdd")
    	                .format(new java.util.Date());

    	        int seq = getNextBatchSequence(productId);
    	        String batchNo =
    	            productId + "-" + datePart + "-" + String.format("%03d", seq);

    	        ps.setString(1, batchNo);
    	        ps.setInt(2, orderDetailId);

    	        if (invoiceNo == null || invoiceNo.isBlank()) {
    	            ps.setNull(3, java.sql.Types.VARCHAR);
    	        } else {
    	            ps.setString(3, invoiceNo);
    	        }

    	        ps.setInt(4, quantity);
    	        ps.setString(5, arrivalDate);

    	        ps.executeUpdate();

    			    new ReceiveOrderDAO().updateOrderStatus(orderId);
    			}
    			catch (Exception e) {
    			    throw e; // ✅ penting
    			}    
    		}		
    // ===============================
    // RECEIVE HISTORY
    // ===============================
    public List<String[]> getReceiveHistory(String orderId) {

        List<String[]> list = new ArrayList<>();

        String sql = """
            SELECT
                p.product_id,
                r.batch_number,
                r.quantity_received,
                TO_CHAR(r.arrival_date,'YYYY-MM-DD') AS arrival_date
            FROM receive r
            JOIN orderdetail od
                ON r.orderdetail_id = od.orderdetail_id
            JOIN product p
                ON od.product_id = p.product_id
            WHERE od.order_id = ?
            ORDER BY r.arrival_date DESC
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new String[]{
                    rs.getString("product_id"),
                    rs.getString("batch_number"),
                    rs.getString("quantity_received"),
                    rs.getString("arrival_date")
                });
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}
