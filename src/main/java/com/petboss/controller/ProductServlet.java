package com.petboss.controller;

import com.petboss.dao.ProductDAO;
import com.petboss.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // 🔐 Session check
        if (session == null || session.getAttribute("staffId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String role = String.valueOf(session.getAttribute("role"));

        // 🔐 Role validation
        boolean isAdmin = "Admin".equalsIgnoreCase(role);
        boolean isPM = "Purchasing Manager".equalsIgnoreCase(role)
                     || "PURCHASING_MANAGER".equalsIgnoreCase(role);

        if (!isAdmin && !isPM) {
            resp.sendRedirect(req.getContextPath() + "/unauthorized.jsp");
            return;
        }

        // 🔍 READ SEARCH + FILTER PARAMETERS
        String keyword = req.getParameter("keyword");
        String category = req.getParameter("category");
        String ajax = req.getParameter("ajax");

        ProductDAO dao = new ProductDAO();

        try {
            List<Product> products;

            if ((keyword == null || keyword.isBlank())
             && (category == null || category.isBlank())) {
                products = dao.getAllProducts();
            } else {
                products = dao.searchProduct(keyword, category);
            }

            // ✅ AJAX REQUEST → RETURN JSON
            if ("true".equals(ajax)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");

                StringBuilder json = new StringBuilder("[");
                for (int i = 0; i < products.size(); i++) {
                    Product p = products.get(i);
                    json.append("{")
                        .append("\"id\":\"").append(p.getProductId()).append("\",")
                        .append("\"name\":\"").append(p.getName()).append("\",")
                        .append("\"category\":\"").append(p.getCategory()).append("\",")
                        .append("\"brand\":\"").append(p.getBrand()).append("\",")
                        .append("\"qty\":").append(p.getQuantity()).append(",")
                        .append("\"buy\":").append(p.getPurchasePrice()).append(",")
                        .append("\"sell\":").append(p.getSellingPrice()).append(",")
                        .append("\"img\":\"").append(p.getImage()).append("\"")
                        .append("}");
                    if (i < products.size() - 1) json.append(",");
                }
                json.append("]");

                resp.getWriter().write(json.toString());
                return;
            }

            // NORMAL PAGE LOAD (FIRST LOAD)
            req.setAttribute("products", products);
            req.setAttribute("activeMenu", "product");

            if (isAdmin) {
                req.getRequestDispatcher("/admin/product.jsp").forward(req, resp);
            } else {
                req.getRequestDispatcher("/pm/product.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}