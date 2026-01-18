package com.petboss.dao;

import com.petboss.model.Supplier;
import com.petboss.util.DBConnection;

import java.sql.*;
import java.util.*;

public class SupplierDAO {

    /* ===============================
       GET ALL SUPPLIERS
       =============================== */
    public List<Supplier> getAllSuppliers() {

        List<Supplier> list = new ArrayList<>();
        String sql = "SELECT SUPPLIER_ID, SUPPLIER_NAME, EMAIL, PHONE, ADDRESS " +
                     "FROM SUPPLIER ORDER BY SUPPLIER_ID";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Supplier s = new Supplier();
                s.setSupplierId(rs.getString("SUPPLIER_ID"));
                s.setName(rs.getString("SUPPLIER_NAME"));
                s.setEmail(rs.getString("EMAIL"));
                s.setPhone(rs.getString("PHONE"));
                s.setAddress(rs.getString("ADDRESS"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /* ===============================
       SEARCH SUPPLIER (AJAX)
       =============================== */
    public List<Supplier> searchSupplier(String keyword) {

        List<Supplier> list = new ArrayList<>();
        String sql =
            "SELECT SUPPLIER_ID, SUPPLIER_NAME, EMAIL, PHONE, ADDRESS " +
            "FROM SUPPLIER WHERE " +
            "LOWER(SUPPLIER_ID) LIKE ? OR " +
            "LOWER(SUPPLIER_NAME) LIKE ? OR " +
            "LOWER(EMAIL) LIKE ? OR " +
            "LOWER(PHONE) LIKE ? " +
            "ORDER BY SUPPLIER_ID";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String k = "%" + keyword.toLowerCase() + "%";
            ps.setString(1, k);
            ps.setString(2, k);
            ps.setString(3, k);
            ps.setString(4, k);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Supplier s = new Supplier();
                s.setSupplierId(rs.getString("SUPPLIER_ID"));
                s.setName(rs.getString("SUPPLIER_NAME"));
                s.setEmail(rs.getString("EMAIL"));
                s.setPhone(rs.getString("PHONE"));
                s.setAddress(rs.getString("ADDRESS"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /* ===============================
       INSERT SUPPLIER
       =============================== */
    public boolean addSupplier(Supplier s) throws Exception {

        String sql =
            "INSERT INTO supplier (supplier_id, supplier_name, email, phone, address) " +
            "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, s.getSupplierId());
            ps.setString(2, s.getName());
            ps.setString(3, s.getEmail());
            ps.setString(4, s.getPhone());
            ps.setString(5, s.getAddress());

            return ps.executeUpdate() > 0; // ✅ true = berjaya
        }
    }


    /* ===============================
       UPDATE SUPPLIER
       =============================== */
    public void updateSupplier(Supplier s) {

        String sql =
            "UPDATE SUPPLIER SET " +
            "SUPPLIER_NAME=?, EMAIL=?, PHONE=?, ADDRESS=? " +
            "WHERE SUPPLIER_ID=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getName());
            ps.setString(2, s.getEmail());
            ps.setString(3, s.getPhone());
            ps.setString(4, s.getAddress());
            ps.setString(5, s.getSupplierId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /* ===============================
       AUTO GENERATE SUPPLIER ID (PostgreSQL)
       =============================== */
    public String generateSupplierId() throws Exception {
    
        String sql = """
            SELECT 'SUP' || LPAD(
                (COALESCE(MAX(SUBSTRING(supplier_id, 4)::INTEGER), 0) + 1)::TEXT,
                3,
                '0'
            )
            FROM supplier
        """;
    
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
    
            if (rs.next()) {
                return rs.getString(1);
            }
        }
    
        return "SUP001"; // fallback
    }
 
    public int getTotalSuppliers() throws Exception {
        String sql = "SELECT COUNT(*) FROM supplier";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

}

