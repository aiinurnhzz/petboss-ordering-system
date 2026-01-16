package com.petboss.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.petboss.dao.StaffDAO;

@WebServlet("/create-password")
public class CreatePasswordServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private StaffDAO staffDAO;

    @Override
    public void init() {
        staffDAO = new StaffDAO();
    }

    private boolean isStrongPassword(String password) {
        return password != null && password.matches(
            "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{8,}$"
        );
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String staffId = req.getParameter("staffId");
        String password = req.getParameter("password");
        String confirm = req.getParameter("confirmPassword");

        if (staffId == null || staffId.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() +
                "/createPassword.jsp?error=invalidstaff");
            return;
        }

        if (!password.equals(confirm)) {
            resp.sendRedirect(req.getContextPath() +
                "/createPassword.jsp?error=nomatch");
            return;
        }

        if (!isStrongPassword(password)) {
            resp.sendRedirect(req.getContextPath() +
                "/createPassword.jsp?error=weak");
            return;
        }

        try {
            if (!staffDAO.exists(staffId)) {
                resp.sendRedirect(req.getContextPath() +
                    "/createPassword.jsp?error=invalidstaff");
                return;
            }

            if (staffDAO.passwordExists(staffId)) {
                resp.sendRedirect(req.getContextPath() +
                    "/createPassword.jsp?error=alreadyset");
                return;
            }

            staffDAO.updatePassword(staffId, password);

            resp.sendRedirect(req.getContextPath() +
                "/login.jsp?registered=success");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() +
                "/createPassword.jsp?error=system");
        }
    }
}
