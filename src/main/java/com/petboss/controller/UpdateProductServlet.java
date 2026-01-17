package com.petboss.controller;

import com.petboss.dao.ProductDAO;
import com.petboss.dao.ProductCategoryDAO;
import com.petboss.dao.ActivityLogDAO;
import com.petboss.model.Product;
import com.petboss.service.CloudinaryService;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/editProduct")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 10
)
public class UpdateProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // ✅ Cloudinary (NO CDI)
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

        try {
            String productId = req.getParameter("productId");
            String category  = req.getParameter("category");

            ProductDAO productDAO = new ProductDAO();

            // 🔹 ambil product lama (UNTUK IMAGE)
            Product oldProduct = productDAO.getProductById(productId);
            if (oldProduct == null) {
                throw new ServletException("Product not found for ID: " + productId);
            }

            // =========================
            // IMAGE (CLOUDINARY UPDATE)
            // =========================
            Part imagePart = req.getPart("productImage");

            // default: guna image lama (URL Cloudinary)
            String imageUrl = oldProduct.getImage();

            // kalau user upload gambar baru
            if (imagePart != null && imagePart.getSize() > 0) {
                imageUrl =
                    cloudinaryService.uploadProductImage(imagePart, productId);
            }

            // =========================
            // UPDATE PRODUCT TABLE
            // =========================
            Product p = new Product();
            p.setProductId(productId);

            // 🔥 WAJIB SET (KEKAL SAMA)
            p.setName(oldProduct.getName());
            p.setBrand(oldProduct.getBrand());
            p.setCategory(oldProduct.getCategory());

            // UPDATE FIELD
            p.setQuantity(Integer.parseInt(req.getParameter("quantity")));
            p.setMinQuantity(Integer.parseInt(req.getParameter("minQuantity")));
            p.setPurchasePrice(Double.parseDouble(req.getParameter("purchasePrice")));
            p.setSellingPrice(Double.parseDouble(req.getParameter("sellingPrice")));
            p.setImage(imageUrl);

            productDAO.updateProduct(p);

            // =========================
            // UPDATE CATEGORY TABLE
            // =========================
            ProductCategoryDAO categoryDAO = new ProductCategoryDAO();

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

            // =========================
            // ACTIVITY LOG
            // =========================
            ActivityLogDAO.log(
                staffName,
                "updated product details."
            );

            resp.sendRedirect(req.getContextPath() + "/product");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error updating product", e);
        }
    }
}
