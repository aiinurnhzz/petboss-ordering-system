package com.petboss.controller;

import com.petboss.util.DBConnection;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/api/products")
public class ProductApiServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        PrintWriter out = resp.getWriter();
        out.print("[");

        String sql = """
            SELECT product_id, name, selling_price
            FROM product
            WHERE quantity > 0
            ORDER BY name
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            boolean first = true;

            while (rs.next()) {

                if (!first) out.print(",");
                first = false;

                String id = rs.getString("product_id");
                String name = rs.getString("name").replace("\"", "\\\"");
                double price = rs.getDouble("selling_price");

                out.print("{");
                out.print("\"id\":\"" + id + "\",");
                out.print("\"name\":\"" + name + "\",");
                out.print("\"price\":" + price);
                out.print("}");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        out.print("]");
        out.flush();
    }
}
