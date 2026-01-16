package com.petboss.dao;

import com.petboss.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class ActivityLogDAO {

    public static void log(String staffName, String action) {
        String sql =
            "INSERT INTO activity_log (staff_name, description) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, staffName);
            ps.setString(2, action);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
