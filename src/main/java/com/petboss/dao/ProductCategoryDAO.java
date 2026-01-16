package com.petboss.dao;

import com.petboss.util.DBConnection;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class ProductCategoryDAO {

    public Map<String, Object> getCategoryDetails(String productId, String category) {

        String sql = null;

        switch (category) {
            case "PET_FOOD":
                sql = "SELECT WEIGHT, EXPIRY_DATE FROM PETFOOD WHERE PRODUCT_ID = ?";
                break;

            case "PET_MEDICINE":
                sql = "SELECT DOSAGE, PRESCRIPTION, EXPIRY_DATE FROM PETMEDICINE WHERE PRODUCT_ID = ?";
                break;

            case "PET_CARE":
                sql = "SELECT TYPE, EXPIRY_DATE FROM PETCARE WHERE PRODUCT_ID = ?";
                break;

            case "PET_ACCESSORY":
                sql = "SELECT MATERIAL FROM PETACCESSORY WHERE PRODUCT_ID = ?";
                break;

            default:
                return null;
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                ResultSetMetaData meta = rs.getMetaData();

                for (int i = 1; i <= meta.getColumnCount(); i++) {
                    map.put(
                        meta.getColumnLabel(i).toLowerCase(),
                        rs.getObject(i)
                    );
                }

                return map;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    
    public void addPetFood(String productId, String weight, Date expiryDate) {

        String sql = """
            INSERT INTO PETFOOD (PRODUCT_ID, WEIGHT, EXPIRY_DATE)
            VALUES (?, ?, ?)
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, productId);
            ps.setString(2, weight);
            ps.setDate(3, expiryDate);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addPetMedicine(String productId, String dosage,
            String prescription, Date expiryDate) {

		String sql = """
		INSERT INTO PETMEDICINE
		(PRODUCT_ID, DOSAGE, PRESCRIPTION, EXPIRY_DATE)
		VALUES (?, ?, ?, ?)
		""";
		
		try (Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(sql)) {
		
		ps.setString(1, productId);
		ps.setString(2, dosage);
		ps.setString(3, prescription);
		ps.setDate(4, expiryDate);
		ps.executeUpdate();
		
		} catch (Exception e) {
		e.printStackTrace();
		}
    }
    
    public void addPetCare(String productId, String type, Date expiryDate) {

        String sql = """
            INSERT INTO PETCARE (PRODUCT_ID, TYPE, EXPIRY_DATE)
            VALUES (?, ?, ?)
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, productId);
            ps.setString(2, type);
            ps.setDate(3, expiryDate);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addPetAccessory(String productId, String type, String material) {

        String sql = """
            INSERT INTO PETACCESSORY (PRODUCT_ID, TYPE, MATERIAL)
            VALUES (?, ?, ?)
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, productId);
            ps.setString(2, type);
            ps.setString(3, material);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


 // ================= PET MEDICINE =================
    public void updatePetMedicine(String productId, String dosage,
                                  String prescription, Date expiryDate) {

        String sql = """
            UPDATE PETMEDICINE
            SET DOSAGE = ?, PRESCRIPTION = ?, EXPIRY_DATE = ?
            WHERE PRODUCT_ID = ?
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, dosage);
            ps.setString(2, prescription);
            ps.setDate(3, expiryDate);
            ps.setString(4, productId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    // ================= PET FOOD =================
    public void updatePetFood(String productId, String weight, Date expiryDate) {

        String sql = """
            UPDATE PETFOOD
            SET WEIGHT = ?, EXPIRY_DATE = ?
            WHERE PRODUCT_ID = ?
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, weight);
            ps.setDate(2, expiryDate);
            ps.setString(3, productId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    // ================= PET CARE =================
    public void updatePetCare(String productId, String type, Date expiryDate) {

        String sql = """
            UPDATE PETCARE
            SET TYPE = ?, EXPIRY_DATE = ?
            WHERE PRODUCT_ID = ?
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, type);
            ps.setDate(2, expiryDate);
            ps.setString(3, productId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    // ================= PET ACCESSORY =================
    public void updatePetAccessory(String productId, String material) {

        String sql = """
            UPDATE PETACCESSORY
            SET MATERIAL = ?
            WHERE PRODUCT_ID = ?
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, material);
            ps.setString(2, productId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
