package com.petboss.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL =
        "jdbc:oracle:thin:@localhost:1521/FREEPDB1";

    private static final String USER = "PETBOSS";
    private static final String PASSWORD = "PetBoss";

    private DBConnection() {}

    public static Connection getConnection() {

        Connection con = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection(URL, USER, PASSWORD);

            System.out.println("DEBUG: Connected to FREEPDB1 as PETBOSS");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}
