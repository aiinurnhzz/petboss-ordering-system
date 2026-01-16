package com.petboss.dao;

import com.petboss.util.DBConnection;
import java.sql.*;
import java.util.*;

public class ReturnNoteDAO {

    public Map<String, String> getReturnNoteByQC(String qcId) {

        Map<String, String> r = new HashMap<>();

        String sql = """
            SELECT
                qc.qc_id,
                qc.batch_number,
                p.name AS product_name,
                rcv.quantity_received,
                qc.quantity_return,
                qc.remarks,
                TO_CHAR(qc.qc_date,'DD Mon YYYY') qc_date,
                o.order_id,
                TO_CHAR(o.order_date,'DD Mon YYYY') order_date,
                s.supplier_name,
                s.address AS supplier_address,
                s.phone AS supplier_phone,
                st.full_name
            FROM qualitycheck qc
            JOIN receive rcv ON qc.batch_number = rcv.batch_number
            JOIN orderdetail od ON rcv.orderdetail_id = od.orderdetail_id
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
                r.put("returnId", rs.getString("qc_id"));
                r.put("batch", rs.getString("batch_number"));
                r.put("product", rs.getString("product_name"));
                r.put("received", rs.getString("quantity_received"));
                r.put("returned", rs.getString("quantity_return"));
                r.put("remarks", rs.getString("remarks"));
                r.put("returnDate", rs.getString("qc_date"));
                r.put("orderId", rs.getString("order_id"));
                r.put("orderDate", rs.getString("order_date"));
                r.put("supplier", rs.getString("supplier_name"));
                r.put("supplierAddress", rs.getString("supplier_address"));
                r.put("supplierPhone", rs.getString("supplier_phone"));
                r.put("staff", rs.getString("full_name"));
            }

        } catch (Exception e) {
            e.printStackTrace(); // IMPORTANT for debugging
        }

        return r;
    }
}
