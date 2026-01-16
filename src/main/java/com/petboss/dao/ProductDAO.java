package com.petboss.dao;

import com.petboss.model.Product;
import com.petboss.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    /* ===============================
       GET ALL PRODUCTS
       =============================== */
    public List<Product> getAllProducts() {

        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM PRODUCT ORDER BY PRODUCT_ID";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product p = new Product();

                p.setProductId(rs.getString("PRODUCT_ID"));
                p.setName(rs.getString("NAME"));
                p.setBrand(rs.getString("BRAND"));
                p.setCategory(rs.getString("CATEGORY"));
                p.setQuantity(rs.getInt("QUANTITY"));
                p.setMinQuantity(rs.getInt("MIN_QUANTITY"));
                p.setPurchasePrice(rs.getDouble("PURCHASE_PRICE"));
                p.setSellingPrice(rs.getDouble("SELLING_PRICE"));
                p.setImage(rs.getString("IMAGE"));

                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /* ===============================
       SEARCH + FILTER PRODUCT
       =============================== */
    public List<Product> searchProduct(String keyword, String category) {

        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM PRODUCT WHERE 1=1";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (LOWER(PRODUCT_ID) LIKE ? " +
                   "OR LOWER(NAME) LIKE ? " +
                   "OR LOWER(BRAND) LIKE ?)";
        }

        if (category != null && !category.trim().isEmpty()) {
            sql += " AND CATEGORY = ?";
        }

        sql += " ORDER BY PRODUCT_ID";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            int index = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                String k = "%" + keyword.trim().toLowerCase() + "%";
                ps.setString(index++, k);
                ps.setString(index++, k);
                ps.setString(index++, k);
            }

            if (category != null && !category.trim().isEmpty()) {
                ps.setString(index++, category);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();

                p.setProductId(rs.getString("PRODUCT_ID"));
                p.setName(rs.getString("NAME"));
                p.setBrand(rs.getString("BRAND"));
                p.setCategory(rs.getString("CATEGORY"));
                p.setQuantity(rs.getInt("QUANTITY"));
                p.setPurchasePrice(rs.getDouble("PURCHASE_PRICE"));
                p.setSellingPrice(rs.getDouble("SELLING_PRICE"));
                p.setImage(rs.getString("IMAGE"));

                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /* ===============================
       ADD PRODUCT (SUPERCLASS ONLY)
       =============================== */
    public void addProduct(Product p) {

        String sql = """
            INSERT INTO PRODUCT
            (PRODUCT_ID, NAME, BRAND, CATEGORY,
             QUANTITY, MIN_QUANTITY,
             PURCHASE_PRICE, SELLING_PRICE, IMAGE)
            VALUES (?,?,?,?,?,?,?,?,?)
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getProductId());
            ps.setString(2, p.getName());
            ps.setString(3, p.getBrand());
            ps.setString(4, p.getCategory());
            ps.setInt(5, p.getQuantity());
            ps.setInt(6, p.getMinQuantity());
            ps.setDouble(7, p.getPurchasePrice());
            ps.setDouble(8, p.getSellingPrice());
            ps.setString(9, p.getImage());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /* ===============================
       AUTO GENERATE PRODUCT ID
       =============================== */
    public String generateProductId(String category) {

        String prefix;

        switch (category) {
            case "PET_FOOD": prefix = "PF"; break;
            case "PET_MEDICINE": prefix = "PM"; break;
            case "PET_CARE": prefix = "PC"; break;
            case "PET_ACCESSORY": prefix = "PA"; break;
            default: prefix = "P";
        }

        String sql = """
            SELECT MAX(PRODUCT_ID)
            FROM PRODUCT
            WHERE PRODUCT_ID LIKE ?
        """;

        int nextNumber = 1;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, prefix + "%");
            ResultSet rs = ps.executeQuery();

            if (rs.next() && rs.getString(1) != null) {
                String lastId = rs.getString(1);
                int number = Integer.parseInt(lastId.substring(2));
                nextNumber = number + 1;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return prefix + String.format("%03d", nextNumber);
    }

    /* ===============================
       GET PRODUCT BY ID
       =============================== */
    public Product getProductById(String productId) {

        Product p = null;
        String sql = "SELECT * FROM PRODUCT WHERE PRODUCT_ID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                p = new Product();

                p.setProductId(rs.getString("PRODUCT_ID"));
                p.setName(rs.getString("NAME"));
                p.setBrand(rs.getString("BRAND"));
                p.setCategory(rs.getString("CATEGORY"));
                p.setQuantity(rs.getInt("QUANTITY"));
                p.setMinQuantity(rs.getInt("MIN_QUANTITY"));
                p.setPurchasePrice(rs.getDouble("PURCHASE_PRICE"));
                p.setSellingPrice(rs.getDouble("SELLING_PRICE"));
                p.setImage(rs.getString("IMAGE"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return p;
    }

    /* ===============================
       UPDATE PRODUCT (NO CATEGORY DATA)
       =============================== */
    public void updateProduct(Product p) {

    	String sql = """
    		    UPDATE PRODUCT SET
    		        NAME = ?,
    		        BRAND = ?,
    		        CATEGORY = ?,
    		        QUANTITY = ?,
    		        MIN_QUANTITY = ?,
    		        PURCHASE_PRICE = ?,
    		        SELLING_PRICE = ?,
    		        IMAGE = ?
    		    WHERE PRODUCT_ID = ?
    		""";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

        	ps.setString(1, p.getName());
        	ps.setString(2, p.getBrand());
        	ps.setString(3, p.getCategory());
        	ps.setInt(4, p.getQuantity());
        	ps.setInt(5, p.getMinQuantity());
        	ps.setDouble(6, p.getPurchasePrice());
        	ps.setDouble(7, p.getSellingPrice());
        	ps.setString(8, p.getImage());
        	ps.setString(9, p.getProductId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public String getProductsAsJson() {

        StringBuilder json = new StringBuilder("[");
        String sql = "SELECT PRODUCT_ID, NAME, SELLING_PRICE FROM PRODUCT";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                json.append("{")
                    .append("\"id\":\"").append(rs.getString("PRODUCT_ID")).append("\",")
                    .append("\"name\":\"").append(rs.getString("NAME")).append("\",")
                    .append("\"price\":").append(rs.getDouble("SELLING_PRICE"))
                    .append("},");
            }

            if (json.charAt(json.length() - 1) == ',') {
                json.deleteCharAt(json.length() - 1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return json.append("]").toString();
    }

    public int getTotalProducts() throws Exception {
        String sql = "SELECT COUNT(*) FROM product";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
}