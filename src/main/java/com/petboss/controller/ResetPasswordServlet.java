package com.petboss.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.petboss.dao.StaffDAO;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private StaffDAO staffDAO;

    @Override
    public void init() {
        staffDAO = new StaffDAO();
    }

    // 🔐 Password strength validation
    private boolean isStrongPassword(String password) {
        return password != null && password.matches(
            "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{8,}$"
        );
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession(false);

        // 🛑 No reset session → block access
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String staffId = (String) session.getAttribute("resetStaffId");
        if (staffId == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String password = req.getParameter("password");
        String confirm = req.getParameter("confirmPassword");

        // ❌ Password not match
        if (password == null || confirm == null || !password.equals(confirm)) {
            forwardWithError(req, resp, "nomatch");
            return;
        }

        // ❌ Weak password
        if (!isStrongPassword(password)) {
            forwardWithError(req, resp, "weak");
            return;
        }

        try {
            // ✅ Update password
            staffDAO.updatePassword(staffId, password);

            // 🛡️ SECURITY: invalidate entire session
            session.invalidate();

            // ✅ Success → show success page + auto redirect
            resp.sendRedirect(
                req.getContextPath() + "/resetPassword.jsp?success=true"
            );

        } catch (Exception e) {
            forwardWithError(req, resp, "invalid");
        }
    }

    // 🔁 Helper method for forward
    private void forwardWithError(HttpServletRequest req,
                                  HttpServletResponse resp,
                                  String error)
            throws IOException {
        try {
            req.setAttribute("error", error);
            req.getRequestDispatcher("/resetPassword.jsp")
               .forward(req, resp);
        } catch (ServletException e) {
            throw new IOException(e);
        }
    }
}
