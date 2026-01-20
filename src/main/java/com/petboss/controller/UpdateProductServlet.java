package com.petboss.controller;

import com.petboss.dao.ProductDAO;
import com.petboss.dao.ProductCategoryDAO;
import com.petboss.dao.ActivityLogDAO;
import com.petboss.model.Product;
import com.petboss.service.CloudinaryService;
import com.petboss.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;

@WebServlet("/editProduct")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 10
)
public class UpdateProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Cloudinary
    private final CloudinaryService cloudinaryService = new CloudinaryService();

    private Date parseDateSafe(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            return null;
        }
        return Date.valueOf(dateStr);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("staffId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String staffName = (String) session.getAttribute("staffName");
        Connection con = null;

        try {
            String productId = req.getParameter("productId");
            String category  = req.getParameter("category");

            if (productId == null || productId.isBlank()) {
                throw new ServletException("Invalid product ID");
            }

            /* ===============================
               START TRANSACTION
               =============================== */
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            ProductDAO productDAO = new ProductDAO();
            ProductCategoryDAO categoryDAO = new ProductCategoryDAO();

            // 🔹 ambil product lama (untuk image & immutable fields)
            Product oldProduct = productDAO.getProductById(productId);
            if (oldProduct == null) {
                throw new ServletException("Product not found: " + productId);
            }

            /* ===============================
               IMAGE (CLOUDINARY)
               =============================== */
            Part imagePart = req.getPart("productImage");

            String imageUrl = oldProduct.getImage(); // default image lama

            if (imagePart != null && imagePart.getSize() > 0) {
                imageUrl =
                    cloudinaryService.uploadProductImage(imagePart, productId);
            }

            /* ===============================
               UPDATE PRODUCT (MAIN TABLE)
               =============================== */
            Product p = new Product();
            p.setProductId(productId);

            // KEKAL
            p.setName(oldProduct.getName());
            p.setBrand(oldProduct.getBrand());
            p.setCategory(oldProduct.getCategory());

            // UPDATE
            p.setQuantity(Integer.parseInt(req.getParameter("quantity")));
            p.setMinQuantity(Integer.parseInt(req.getParameter("minQuantity")));
            p.setPurchasePrice(Double.parseDouble(req.getParameter("purchasePrice")));
            p.setSellingPrice(Double.parseDouble(req.getParameter("sellingPrice")));
            p.setImage(imageUrl);

            productDAO.updateProduct(p);

            /* ===============================
               UPDATE CATEGORY TABLE
               =============================== */
            switch (category) {

                case "PET_MEDICINE":
                    categoryDAO.updatePetMedicine(
                        productId,
                        req.getParameter("dosage"),
                        req.getParameter("prescription"),
                        parseDateSafe(req.getParameter("expiryDate"))
                    );
                    break;

                case "PET_FOOD":
                    categoryDAO.updatePetFood(
                        productId,
                        req.getParameter("weight"),
                        parseDateSafe(req.getParameter("expiryDate"))
                    );
                    break;

                case "PET_CARE":
                    categoryDAO.updatePetCare(
                        productId,
                        req.getParameter("type"),
                        parseDateSafe(req.getParameter("expiryDate"))
                    );
                    break;

                case "PET_ACCESSORY":
                    categoryDAO.updatePetAccessory(
                        productId,
                        req.getParameter("material")
                    );
                    break;
            }

            /* ===============================
               ACTIVITY LOG
               =============================== */
            ActivityLogDAO.log(
                con,
                staffName,
                "updated product details"
            );

            con.commit(); // ✅ COMMIT SEMUA

            resp.sendRedirect(req.getContextPath() + "/product");

        } catch (Exception e) {

            try {
                if (con != null) con.rollback(); // 🔥 ROLLBACK
            } catch (Exception ignored) {}

            e.printStackTrace();
            throw new ServletException("Error updating product", e);

        } finally {

            try {
                if (con != null) con.close();
            } catch (Exception ignored) {}
        }
    }
}
