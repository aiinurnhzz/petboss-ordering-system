package com.petboss.dao;

import com.petboss.model.Activity;
import com.petboss.model.Product;
import com.petboss.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DashboardDAO {

	public int getLowStockCount() throws Exception {
	    String sql =
	        "SELECT COUNT(*) FROM product " +
	        "WHERE quantity < min_quantity";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {

	        return rs.next() ? rs.getInt(1) : 0;
	    }
	}

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


    public List<Activity> getRecentActivities(String period) {

    List<Activity> list = new ArrayList<>();

    String dateCondition;

    switch (period) {
        case "week":
            dateCondition = "created_at >= CURRENT_DATE - INTERVAL '7 days'";
            break;

        case "month":
            dateCondition = "created_at >= CURRENT_DATE - INTERVAL '1 month'";
            break;

        case "today":
        default:
            dateCondition = "created_at::date = CURRENT_DATE";
            break;
    }

    String sql = """
        SELECT activity, created_at
        FROM activity_log
        WHERE %s
        ORDER BY created_at DESC
        LIMIT 10
    """.formatted(dateCondition);

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Activity a = new Activity();
            a.setActivity(rs.getString("activity"));
            a.setCreatedAt(rs.getTimestamp("created_at"));
            list.add(a);
        }

    } catch (SQLException e) {
        throw new RuntimeException("Error fetching recent activities", e);
    }

    return list;
}

}

