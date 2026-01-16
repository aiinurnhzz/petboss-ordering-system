package com.petboss.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    // PostgreSQL JDBC URL
    private static final String URL =
        "jdbc:postgresql://c57oa7dm3pc281.cluster-czrs8kj4isg7.us-east-1.rds.amazonaws.com:5432/d65lkge5dn68s5";

    private static final String USER = "uagq2giboatcre";
    private static final String PASSWORD = "p8f5f8d0602136920101e05112ccf505fa31cc29001fc024402d278eef5ed04f7";

    private DBConnection() {}

    public static Connection getConnection() {

        Connection con = null;

        try {
            // PostgreSQL driver
            Class.forName("org.postgresql.Driver");

            con = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("DEBUG: Connected to PostgreSQL database");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}
