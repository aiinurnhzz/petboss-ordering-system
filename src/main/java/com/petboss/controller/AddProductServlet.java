package com.petboss.controller;

import com.petboss.dao.ProductDAO;
import com.petboss.dao.ActivityLogDAO;
import com.petboss.dao.ProductCategoryDAO;
import com.petboss.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.petboss.service.CloudinaryService;
import java.io.IOException;

@WebServlet("/pm/addProduct")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,   // 1MB
    maxFileSize = 1024 * 1024 * 5,     // 5MB
    maxRequestSize = 1024 * 1024 * 10  // 10MB
)
public class AddProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final CloudinaryService cloudinaryService = new CloudinaryService();

    /* =========================
       SHOW ADD PRODUCT PAGE
       ========================= */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("staffId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        if (!isPM(String.valueOf(session.getAttribute("role")))) {
            resp.sendRedirect(req.getContextPath() + "/unauthorized.jsp");
            return;
        }

        req.getRequestDispatcher("/pm/addProduct.jsp").forward(req, resp);
    }

    /* =========================
       HANDLE FORM SUBMIT
       ========================= */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("staffId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String staffName = (String) session.getAttribute("staffName");
        String role = (String) session.getAttribute("role");

        if (role == null || !isPM(role)) {
            resp.sendRedirect(req.getContextPath() + "/unauthorized.jsp");
            return;
        }

        try {
            ProductDAO productDAO = new ProductDAO();
            Product p = new Product();

            String category = req.getParameter("category");
            if (category == null || category.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/pm/addProduct?error=category");
                return;
            }

            // 🔥 AUTO-GENERATE PRODUCT ID
            String productId = productDAO.generateProductId(category);
            p.setProductId(productId);

            // ===== BASIC INFO =====
            p.setName(req.getParameter("productName"));
            p.setBrand(req.getParameter("productBrand"));
            p.setCategory(category);

            // ===== STOCK =====
            p.setQuantity(Integer.parseInt(req.getParameter("quantity")));
            p.setMinQuantity(Integer.parseInt(req.getParameter("minQuantity")));

            // ===== PRICING =====
            p.setPurchasePrice(Double.parseDouble(req.getParameter("purchasePrice")));
            p.setSellingPrice(Double.parseDouble(req.getParameter("sellingPrice")));

         // ===== IMAGE UPLOAD =====
            /* Part imagePart = req.getPart("productImage");
            String imageFileName = null;

            if (imagePart != null && imagePart.getSize() > 0) {

                // ambil extension
                String original = Paths.get(imagePart.getSubmittedFileName())
                                       .getFileName().toString();
                String ext = original.substring(original.lastIndexOf("."));

                // rename ikut SKU
                imageFileName = productId + ext;

                File dir = new File(UPLOAD_DIR);
                if (!dir.exists()) dir.mkdirs();

                imagePart.write(UPLOAD_DIR + File.separator + imageFileName);
            }

            p.setImage(imageFileName); */

            // ===== IMAGE UPLOAD (CLOUDINARY) =====
            Part imagePart = req.getPart("productImage");
            
            if (imagePart != null && imagePart.getSize() > 0) {
            
                String imageUrl =
                    cloudinaryService.uploadProductImage(imagePart, productId);
            
                p.setImage(imageUrl);
            }
       
            // ===== SAVE PRODUCT (SUPERCLASS) =====
            productDAO.addProduct(p);

            // ===== SAVE CATEGORY-SPECIFIC (SUBCLASS) =====
            ProductCategoryDAO categoryDAO = new ProductCategoryDAO();

            switch (category) {

                case "PET_FOOD":
                	String foodExpiryStr = req.getParameter("expiryDate_food");
                	java.sql.Date foodExpiry = (foodExpiryStr == null || foodExpiryStr.isEmpty())
                	        ? null
                	        : java.sql.Date.valueOf(foodExpiryStr);

                	categoryDAO.addPetFood(
                	    productId,
                	    req.getParameter("weight"),
                	    foodExpiry
                	);
                    break;

                case "PET_MEDICINE":
                	String medExpiryStr = req.getParameter("expiryDate_medicine");
                	java.sql.Date medExpiry = (medExpiryStr == null || medExpiryStr.isEmpty())
                	        ? null
                	        : java.sql.Date.valueOf(medExpiryStr);

                	categoryDAO.addPetMedicine(
                	    productId,
                	    req.getParameter("dosage"),
                	    req.getParameter("prescription"),
                	    medExpiry
                	);
                    break;

                case "PET_CARE":
                	String careExpiryStr = req.getParameter("expiryDate_care");
                	java.sql.Date careExpiry = (careExpiryStr == null || careExpiryStr.isEmpty())
                	        ? null
                	        : java.sql.Date.valueOf(careExpiryStr);

                	categoryDAO.addPetCare(
                	    productId,
                	    req.getParameter("type_care"),
                	    careExpiry
                	);
                    break;

                case "PET_ACCESSORY":
                    categoryDAO.addPetAccessory(
                        productId,
                        req.getParameter("type_accessory"),
                        req.getParameter("material")
                    );
                    break;
            }
            Connection con = null;
            
            try {
                con = DBConnection.getConnection();
                con.setAutoCommit(false); // 🔥 START TRANSACTION
            
                ProductDAO productDAO = new ProductDAO(con);
                ProductCategoryDAO categoryDAO = new ProductCategoryDAO(con);
            
                // ===== ADD PRODUCT =====
                productDAO.addProduct(p);
            
                // ===== ADD CATEGORY DETAILS =====
                categoryDAO.addPetFood(
                    productId,
                    req.getParameter("weight"),
                    foodExpiry
                );
            
                // ===== ACTIVITY LOG =====
                ActivityLogDAO.log(
                    con,
                    staffName,
                    "added new product"
                );
            
                con.commit(); // ✅ COMMIT ALL
                resp.sendRedirect(req.getContextPath() + "/product");
            
            } catch (Exception e) {
                if (con != null) con.rollback(); // 🔥 ROLLBACK ALL
                throw new ServletException(e);
            
            } finally {
                if (con != null) con.close();
            }

    private boolean isPM(String role) {
        return "PURCHASING_MANAGER".equalsIgnoreCase(role)
            || "Purchasing Manager".equalsIgnoreCase(role);
    }


}





