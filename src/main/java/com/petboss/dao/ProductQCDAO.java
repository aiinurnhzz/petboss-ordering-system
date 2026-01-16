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
                TO_CHAR(r.arrival_date,'YYYY-MM-DD') arrival_date
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
                TO_CHAR(qc.qc_date,'YYYY-MM-DD') qc_date,
                qc.condition,
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
                row.put("condition", rs.getString("condition"));
                row.put("returnQty", rs.getString("quantity_return"));
                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Map<String,String> getQCById(String qcId) {

        Map<String,String> qc = new HashMap<>();

        String sql = """
            SELECT
                qc.qc_id,
                qc.batch_number,
                p.name AS product_name,
                o.order_id,
                s.supplier_name,
                r.quantity_received,
                qc.quantity_damaged,
                qc.quantity_return,
                qc.condition,
                qc.remarks,
                TO_CHAR(qc.qc_date,'YYYY-MM-DD') qc_date,
                st.full_name AS staff_name
            FROM qualitycheck qc
            JOIN receive r ON qc.batch_number = r.batch_number
            JOIN orderdetail od ON r.orderdetail_id = od.orderdetail_id
            JOIN orders o ON od.order_id = o.order_id
            JOIN supplier s ON o.supplier_id = s.supplier_id
            JOIN product p ON od.product_id = p.product_id
            JOIN staff st ON qc.staff_id = st.staff_id
            WHERE qc.qc_id = ?
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, qcId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                qc.put("qcId", rs.getString("qc_id"));
                qc.put("batch", rs.getString("batch_number"));
                qc.put("product", rs.getString("product_name"));
                qc.put("order", rs.getString("order_id"));
                qc.put("supplier", rs.getString("supplier_name"));
                qc.put("receivedQty", rs.getString("quantity_received"));
                qc.put("damaged", rs.getString("quantity_damaged"));
                qc.put("returned", rs.getString("quantity_return"));
                qc.put("condition", rs.getString("condition"));
                qc.put("remarks", rs.getString("remarks"));
                qc.put("date", rs.getString("qc_date"));
                qc.put("staff", rs.getString("staff_name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return qc;
    }

    /* ===============================
       SAVE QC (FINAL & SAFE)
       =============================== */
    public void saveQC(
        String batchNumber,
        String condition,
        int qtyDamaged,
        int qtyReturn,
        String remarks,
        String staffId
    ) throws Exception {

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            // ===============================
            // 1️⃣ Generate QC ID
            // ===============================
            String qcId;
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT 'QC' || LPAD(QC_SEQ.NEXTVAL,3,'0') FROM dual"
            );
                 ResultSet rs = ps.executeQuery()) {

                if (!rs.next()) {
                    throw new Exception("Failed to generate QC ID");
                }
                qcId = rs.getString(1);
            }

            // ===============================
            // 2️⃣ Insert QC record
            // ===============================
            String insertQC = """
                INSERT INTO qualitycheck
                (qc_id, batch_number, condition,
                 quantity_damaged, quantity_return,
                 qc_status, qc_date, remarks, staff_id)
                VALUES (?,?,?,?,?,'COMPLETED',SYSDATE,?,?)
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

            // ===============================
            // 3️⃣ Fetch received qty + product
            // ===============================
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

                receivedQty = rs.getInt(1);
                productId = rs.getString(2);
            }

            // ===============================
            // 4️⃣ Calculate GOOD qty
            // ===============================
            int goodQty =
                    "GOOD".equalsIgnoreCase(condition)
                            ? receivedQty
                            : Math.max(0, receivedQty - qtyDamaged);

         // ===============================
         // 5️⃣ Update stock (FIXED)
         // ===============================
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
        }
    }
}
