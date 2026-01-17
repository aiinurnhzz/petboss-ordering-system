package com.petboss.dao;

import com.petboss.model.Activity;
import com.petboss.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DashboardDAO {

    public List<Activity> getRecentActivities(String period) {

        List<Activity> list = new ArrayList<>();
        String condition;

        switch (period) {
            case "week":
                condition = "created_at >= CURRENT_DATE - INTERVAL '7 days'";
                break;
            case "month":
                condition = "created_at >= CURRENT_DATE - INTERVAL '1 month'";
                break;
            default:
                condition = "created_at::date = CURRENT_DATE";
        }

        String sql = """
            SELECT activity, created_at
            FROM activity_log
            WHERE %s
            ORDER BY created_at DESC
            LIMIT 10
        """.formatted(condition);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Activity a = new Activity();
                a.setDescription(rs.getString("activity"));
                a.setActivityDate(rs.getTimestamp("created_at"));
                list.add(a);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error loading activities", e);
        }

        return list;
    }
}
