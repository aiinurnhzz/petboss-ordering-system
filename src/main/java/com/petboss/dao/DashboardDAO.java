package com.petboss.dao;

import com.petboss.model.Activity;
import com.petboss.model.Product;
import com.petboss.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DashboardDAO {

    // =================================================
    // LOW STOCK COUNT
    // =================================================
    public int getLowStockCount() throws Exception {

        String sql =
            "SELECT COUNT(*) " +
            "FROM product " +
            "WHERE quantity < min_quantity";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // =================================================
    // LOW STOCK PRODUCTS
    // =================================================
    public List<Product> getLowStockProducts() throws Exception {

        List<Product> list = new ArrayList<>();

        String sql =
            "SELECT name, quantity, min_quantity " +
            "FROM product " +
            "WHERE quantity < min_quantity";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product p = new Product();
                p.setName(rs.getString("name"));
                p.setQuantity(rs.getInt("quantity"));
                p.setMinQuantity(rs.getInt("min_quantity"));
                list.add(p);
            }
        }
        return list;
    }

    // =================================================
    // RECENT ACTIVITIES (POSTGRESQL VERSION)
    // =================================================
    public List<Activity> getRecentActivities(String period) throws Exception {

        List<Activity> list = new ArrayList<>();
        String condition;

        switch (period) {

            case "week":
                condition = "created_at >= CURRENT_DATE - INTERVAL '7 days'";
                break;

            case "month":
                condition = "created_at >= CURRENT_DATE - INTERVAL '1 month'";
                break;

            default: // today
                condition = "created_at::date = CURRENT_DATE";
                break;
        }

        String sql =
            "SELECT staff_name, " +
            "       description, " +
            "       TO_CHAR(created_at, 'DD Mon YYYY HH12:MI AM') AS time " +
            "FROM activity_log " +
            "WHERE " + condition + " " +
            "ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Activity a = new Activity();
                a.setStaffName(rs.getString("staff_name"));
                a.setDescription(rs.getString("description"));
                a.setTime(rs.getString("time"));
                list.add(a);
            }
        }

        return list;
    }
}
