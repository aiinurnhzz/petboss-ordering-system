package com.petboss.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet implementation class VerifyOtpServlet
 */
@WebServlet("/verify-otp")
public class VerifyOtpServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String enteredOtp = req.getParameter("enteredOtp");
        String actualOtp = (String) session.getAttribute("otp");
        Long otpTime = (Long) session.getAttribute("otpTime");

        // ⏳ OTP expiry: 5 minutes
        if (otpTime != null &&
            System.currentTimeMillis() - otpTime > 5 * 60 * 1000) {

            session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=expired");
            return;
        }

        if (enteredOtp != null && enteredOtp.equals(actualOtp)) {

            session.removeAttribute("otp");
            session.removeAttribute("otpTime");

            session.setAttribute(
                "resetStaffId",
                session.getAttribute("otpStaffId")
            );

            session.removeAttribute("otpStaffId");

            resp.sendRedirect(req.getContextPath() + "/resetPassword.jsp");

        } else {
            resp.sendRedirect(
                req.getContextPath() + "/verifyOtp.jsp?error=invalid");
        }
    }
}

