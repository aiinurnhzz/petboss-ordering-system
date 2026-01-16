package com.petboss.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        // 🔒 Invalidate session if exists
        if (session != null) {
            session.invalidate();
        }

        // 🔁 Redirect back to login page
        response.sendRedirect(
            request.getContextPath() + "/login.jsp?logout=success"
        );
    }
}
