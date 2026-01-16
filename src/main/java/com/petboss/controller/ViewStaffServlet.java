package com.petboss.controller;

import com.petboss.dao.StaffDAO;
import com.petboss.model.Staff;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/viewStaff")
public class ViewStaffServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private StaffDAO staffDAO;

    @Override
    public void init() {
        staffDAO = new StaffDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 🔐 Session & role check
        if (session == null || session.getAttribute("staffId") == null ||
            !"ADMIN".equalsIgnoreCase((String) session.getAttribute("role"))) {

            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // ✅ Correct parameter name
        String staffId = request.getParameter("staffId");

        if (staffId == null || staffId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/staff");
            return;
        }

        try {
            Staff staff = staffDAO.getStaffById(staffId);

            if (staff == null) {
                response.sendRedirect(request.getContextPath() + "/staff");
                return;
            }

            request.setAttribute("staff", staff);
            request.getRequestDispatcher("/admin/viewStaff.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error loading staff details", e);
        }
    }
}

