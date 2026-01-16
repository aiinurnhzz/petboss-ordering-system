package com.petboss.controller;

import com.petboss.dao.ProductCategoryDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Map;

@WebServlet("/product-category")
public class ProductCategoryServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String productId = req.getParameter("productId");
        String category = req.getParameter("category");

        if (productId == null || category == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        ProductCategoryDAO dao = new ProductCategoryDAO();
        Map<String, Object> data = dao.getCategoryDetails(productId, category);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (data == null) {
            resp.getWriter().write("{}");
            return;
        }

        StringBuilder json = new StringBuilder("{");
        for (Map.Entry<String, Object> entry : data.entrySet()) {
            json.append("\"")
                .append(entry.getKey())
                .append("\":\"")
                .append(entry.getValue())
                .append("\",");
        }

        if (json.charAt(json.length() - 1) == ',') {
            json.deleteCharAt(json.length() - 1);
        }

        json.append("}");

        resp.getWriter().write(json.toString());
    }
}
