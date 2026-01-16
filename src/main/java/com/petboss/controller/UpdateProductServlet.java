package com.petboss.controller;

import com.petboss.dao.ProductDAO;
import com.petboss.dao.ProductCategoryDAO;
import com.petboss.dao.ActivityLogDAO;
import com.petboss.model.Product;

import jakarta.servlet.annotation.MultipartConfig;
import java.io.File;
import java.nio.file.Paths;

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
    private static final String UPLOAD_DIR = "C:/petboss/uploads/product";
    
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
            // IMAGE (EDIT / REPLACE)
            // =========================
            Part imagePart = req.getPart("productImage");
            String imageFileName = oldProduct.getImage(); // default: kekal lama

            if (imagePart != null && imagePart.getSize() > 0) {

                // ❌ delete image lama
                if (oldProduct.getImage() != null) {
                    File oldFile = new File(UPLOAD_DIR, oldProduct.getImage());
                    if (oldFile.exists()) oldFile.delete();
                }

                // ✔️ rename ikut SKU
                String original = Paths.get(imagePart.getSubmittedFileName())
                                       .getFileName().toString();
                String ext = original.substring(original.lastIndexOf("."));

                imageFileName = productId + ext;

                File dir = new File(UPLOAD_DIR);
                if (!dir.exists()) dir.mkdirs();

                imagePart.write(UPLOAD_DIR + File.separator + imageFileName);
            }

            // =========================
            // UPDATE PRODUCT TABLE
            // =========================
            Product p = new Product();
            p.setProductId(productId);

            // 🔥 WAJIB SET
            p.setName(oldProduct.getName());
            p.setBrand(oldProduct.getBrand());
            p.setCategory(oldProduct.getCategory());

            // UPDATE FIELD
            p.setQuantity(Integer.parseInt(req.getParameter("quantity")));
            p.setMinQuantity(Integer.parseInt(req.getParameter("minQuantity")));
            p.setPurchasePrice(Double.parseDouble(req.getParameter("purchasePrice")));
            p.setSellingPrice(Double.parseDouble(req.getParameter("sellingPrice")));
            p.setImage(imageFileName);

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
