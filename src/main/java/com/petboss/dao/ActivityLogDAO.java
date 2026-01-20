package com.petboss.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ActivityLogDAO {

    /**
     * Insert a new activity log record.
     * Transaction is controlled by the servlet.
     */
    public static void log(Connection con, String staffName, String description)
            throws Exception {

        String sql = """
            INSERT INTO activity_log
            (activity_id, staff_name, description)
            VALUES (nextval('activity_log_seq'), ?, ?)
        """;

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, staffName);
            ps.setString(2, description);
            ps.executeUpdate();
        }
    }
}
