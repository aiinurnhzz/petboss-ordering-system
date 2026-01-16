package com.petboss.controller;

import com.petboss.dao.StaffDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private StaffDAO staffDAO = new StaffDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 🔐 Session check
        if (session == null || session.getAttribute("staffId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String staffId = (String) session.getAttribute("staffId");
        String field = request.getParameter("field");
        String newValue = request.getParameter("newValue");

        response.setContentType("application/json");

        if (field == null || newValue == null || newValue.trim().isEmpty()) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Invalid input\"}");
            return;
        }

        try {
            switch (field) {

                case "phone":
                    // 🇲🇾 Malaysian phone validation
                    if (!newValue.matches("^01[0-9]{1}-?[0-9]{7,8}$")) {
                        response.getWriter().write(
                            "{\"status\":\"error\",\"message\":\"Invalid phone format\"}"
                        );
                        return;
                    }
                    staffDAO.updatePhone(staffId, newValue);
                    break;

                case "address":
                    staffDAO.updateAddress(staffId, newValue);
                    break;

                default:
                    response.getWriter().write(
                        "{\"status\":\"error\",\"message\":\"Invalid field\"}"
                    );
                    return;
            }

            // ✅ SUCCESS
            response.getWriter().write(
                "{\"status\":\"success\",\"message\":\"Profile updated successfully\"}"
            );

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write(
                "{\"status\":\"error\",\"message\":\"Update failed\"}"
            );
        }
    }
}
