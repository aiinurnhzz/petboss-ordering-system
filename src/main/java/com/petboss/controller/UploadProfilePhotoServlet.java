package com.petboss.controller;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.petboss.dao.StaffDAO;

@WebServlet({"/uploadProfilePhoto"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 1024 * 1024 * 5,    // 5MB
    maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class UploadProfilePhotoServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 🔐 Session check
        if (session == null || session.getAttribute("staffId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String staffId = (String) session.getAttribute("staffId");
        String role = String.valueOf(session.getAttribute("role"));

        // 📸 Get uploaded file
        Part photoPart = request.getPart("photo");

        String redirectProfile = getProfileRedirect(role, request);

        if (photoPart == null || photoPart.getSize() == 0) {
            session.setAttribute("successMsg", "No file selected");
            response.sendRedirect(redirectProfile);
            return;
        }

        // ✅ Validate file type
        String contentType = photoPart.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            session.setAttribute("successMsg", "Only image files are allowed");
            response.sendRedirect(redirectProfile);
            return;
        }

        // 📁 Upload path
        String uploadPath = getServletContext().getRealPath("/")
                + "uploads" + File.separator + "staff";

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // 🖼️ Force filename
        String fileName = staffId + ".jpg";
        File file = new File(uploadDir, fileName);

        // 💾 Save file
        photoPart.write(file.getAbsolutePath());

        try {
            StaffDAO staffDAO = new StaffDAO();
            staffDAO.updatePhoto(staffId, fileName);

            session.setAttribute(
                "successMsg", "Profile photo updated successfully");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute(
                "successMsg", "Failed to update profile photo");
        }

        // 🔁 Redirect back to correct profile
        response.sendRedirect(redirectProfile);
    }

    // 🔁 Decide redirect by role
    private String getProfileRedirect(String role, HttpServletRequest request) {

        if ("ADMIN".equalsIgnoreCase(role)) {
            return request.getContextPath() + "/profile";
        }

        if ("Purchasing Manager".equalsIgnoreCase(role)) {
            return request.getContextPath() + "/profile";
        }

        return request.getContextPath() + "/unauthorized.jsp";
    }
}
