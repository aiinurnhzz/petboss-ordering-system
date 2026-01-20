package com.petboss.controller;

import com.petboss.dao.StaffDAO;
import com.petboss.model.Staff;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/updateStaff")
public class UpdateStaffServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private StaffDAO staffDAO;

    @Override
    public void init() {
        staffDAO = new StaffDAO();
    }

    // ===============================
    // LOAD UPDATE PAGE
    // ===============================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (session == null || role == null || !"ADMIN".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String staffId = request.getParameter("staffId");

        if (staffId == null || staffId.trim().isEmpty()) {
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
            request.getRequestDispatcher("/admin/updateStaff.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error loading staff", e);
        }
    }

    // ===============================
    // UPDATE STAFF
    // ===============================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        String roleSession = (session != null) ? (String) session.getAttribute("role") : null;

        if (session == null || roleSession == null || !"ADMIN".equalsIgnoreCase(roleSession)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Staff staff = new Staff();
        staff.setStaffId(request.getParameter("staffId"));
        staff.setFullName(request.getParameter("name"));
        staff.setEmail(request.getParameter("email"));
        staff.setPhone(request.getParameter("phone"));
        staff.setAddress(request.getParameter("address"));
        staff.setRole(request.getParameter("role"));

        // Normalize status
        String status = request.getParameter("status");
        staff.setStatus(
            "Resign".equalsIgnoreCase(status) ? "Inactive" : status
        );

        // PM ID logic
        String pmId = request.getParameter("pmId");
        if (!"Staff".equalsIgnoreCase(staff.getRole())) {
            pmId = null;
        }
        staff.setPmId(pmId);

        try {
            // Update STAFF table ONLY
            staffDAO.updateStaff(staff);

            response.sendRedirect(
                request.getContextPath() + "/staff?staffId=" + staff.getStaffId());

        } catch (Exception e) {
            throw new ServletException("Error updating staff", e);
        }
    }
}


