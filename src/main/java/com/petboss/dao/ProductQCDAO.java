package com.petboss.dao;

import com.petboss.util.DBConnection;
import java.sql.*;
import java.util.*;

public class ProductQCDAO {

    /* ===============================
       GET PENDING QC
       =============================== */
    public List<Map<String,String>> getPendingQC() {

        List<Map<String,String>> list = new ArrayList<>();

        String sql = """
            SELECT
                r.batch_number,
                p.name AS product_name,
                o.order_id,
                s.supplier_name,
                r.quantity_received,
                TO_CHAR(r.arrival_date,'YYYY-MM-DD') AS arrival_date
            FROM receive r
            JOIN orderdetail od ON r.orderdetail_id = od.orderdetail_id
            JOIN orders o ON od.order_id = o.order_id
            JOIN supplier s ON o.supplier_id = s.supplier_id
            JOIN product p ON od.product_id = p.product_id
            LEFT JOIN qualitycheck qc
                ON qc.batch_number = r.batch_number
            WHERE qc.qc_id IS NULL
            ORDER BY r.arrival_date DESC
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String,String> row = new HashMap<>();
                row.put("batch", rs.getString("batch_number"));
                row.put("product", rs.getString("product_name"));
                row.put("order", rs.getString("order_id"));
                row.put("supplier", rs.getString("supplier_name"));
                row.put("qty", rs.getString("quantity_received"));
                row.put("date", rs.getString("arrival_date"));
                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /* ===============================
       GET COMPLETED QC
       =============================== */
    public List<Map<String,String>> getCompletedQC() {

        List<Map<String,String>> list = new ArrayList<>();

        String sql = """
            SELECT
                qc.qc_id,
                qc.batch_number,
                p.name AS product_name,
                o.order_id,
                s.supplier_name,
                r.quantity_received,
                TO_CHAR(qc.qc_date,'YYYY-MM-DD') AS qc_date,
                qc.qc_condition,
                qc.quantity_return
            FROM qualitycheck qc
            JOIN receive r ON qc.batch_number = r.batch_number
            JOIN orderdetail od ON r.orderdetail_id = od.orderdetail_id
            JOIN orders o ON od.order_id = o.order_id
            JOIN supplier s ON o.supplier_id = s.supplier_id
            JOIN product p ON od.product_id = p.product_id
            WHERE qc.qc_status = 'COMPLETED'
            ORDER BY qc.qc_date DESC
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String,String> row = new HashMap<>();
                row.put("qcId", rs.getString("qc_id"));
                row.put("batch", rs.getString("batch_number"));
                row.put("product", rs.getString("product_name"));
                row.put("order", rs.getString("order_id"));
                row.put("supplier", rs.getString("supplier_name"));
                row.put("qty", rs.getString("quantity_received"));
                row.put("date", rs.getString("qc_date"));
                row.put("condition", rs.getString("qc_condition"));
                row.put("returnQty", rs.getString("quantity_return"));
                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /* ===============================
       SAVE QC (POSTGRES SAFE)
       =============================== */
    public void saveQC(
        String batchNumber,
        String condition,
        int qtyDamaged,
        int qtyReturn,
        String remarks,
        String staffId
    ) throws Exception {

        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            String qcId = "QC" + System.currentTimeMillis();

            String insertQC = """
                INSERT INTO qualitycheck
                (qc_id, batch_number, qc_condition,
                 quantity_damaged, quantity_return,
                 qc_status, remarks, staff_id)
                VALUES (?,?,?,?,?,'COMPLETED',?,?)
            """;

            try (PreparedStatement ps = con.prepareStatement(insertQC)) {
                ps.setString(1, qcId);
                ps.setString(2, batchNumber);
                ps.setString(3, condition);
                ps.setInt(4, qtyDamaged);
                ps.setInt(5, qtyReturn);
                ps.setString(6, remarks);
                ps.setString(7, staffId);
                ps.executeUpdate();
            }

            int receivedQty;
            String productId;

            String fetch = """
                SELECT r.quantity_received, od.product_id
                FROM receive r
                JOIN orderdetail od ON r.orderdetail_id = od.orderdetail_id
                WHERE r.batch_number = ?
            """;

            try (PreparedStatement ps = con.prepareStatement(fetch)) {
                ps.setString(1, batchNumber);
                ResultSet rs = ps.executeQuery();

                if (!rs.next()) {
                    throw new Exception("Receive record not found for batch " + batchNumber);
                }

                receivedQty = rs.getInt("quantity_received");
                productId   = rs.getString("product_id");
            }

            int goodQty =
                "GOOD".equalsIgnoreCase(condition)
                    ? receivedQty
                    : Math.max(0, receivedQty - qtyDamaged);

            if (goodQty > 0) {
                try (PreparedStatement ps = con.prepareStatement(
                    "UPDATE product SET quantity = quantity + ? WHERE product_id = ?"
                )) {
                    ps.setInt(1, goodQty);
                    ps.setString(2, productId);
                    ps.executeUpdate();
                }
            }

            con.commit();

        } catch (Exception e) {
            if (con != null) con.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            if (con != null) con.close();
        }
    }
}
