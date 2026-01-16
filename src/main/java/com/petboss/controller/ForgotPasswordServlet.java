package com.petboss.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.petboss.dao.StaffDAO;
import com.petboss.model.Staff;

/**
 * Servlet implementation class ForgotPasswordServlet
 */
@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private StaffDAO staffDAO;

    @Override
    public void init() {
        staffDAO = new StaffDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String staffId = req.getParameter("staffId");

        // 1️⃣ Validation: empty
        if (staffId == null || staffId.trim().isEmpty()) {
            req.setAttribute("error", "invalid");
            forwardToForgot(req, resp);
            return;
        }

        staffId = staffId.trim().toUpperCase();

        try {
            Staff staff = staffDAO.getStaffById(staffId);

            // 2️⃣ Not found
            if (staff == null) {
                req.setAttribute("error", "notfound");
                req.setAttribute("staffId", staffId);
                forwardToForgot(req, resp);
                return;
            }

            // 3️⃣ Inactive
            if (!"ACTIVE".equalsIgnoreCase(staff.getStatus())) {
                req.setAttribute("error", "inactive");
                req.setAttribute("staffId", staffId);
                forwardToForgot(req, resp);
                return;
            }

            // 4️⃣ SUCCESS → generate OTP
            String otp = String.valueOf(
                    (int)(Math.random() * 900000) + 100000
            );

            HttpSession session = req.getSession(true);
            session.setAttribute("otp", otp);
            session.setAttribute("otpStaffId", staffId);
            session.setAttribute("otpTime", System.currentTimeMillis());

            // SUCCESS should redirect (new page)
            resp.sendRedirect(req.getContextPath() + "/verifyOtp.jsp");

        } catch (Exception e) {
            req.setAttribute("error", "invalid");
            forwardToForgot(req, resp);
        }
    }

    private void forwardToForgot(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        try {
            req.getRequestDispatcher("/forgotPassword.jsp")
               .forward(req, resp);
        } catch (Exception ex) {
            throw new IOException(ex);
        }
    }
}

