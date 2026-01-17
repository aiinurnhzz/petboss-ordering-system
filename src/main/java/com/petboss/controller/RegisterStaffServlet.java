package com.petboss.controller;

import com.petboss.dao.StaffDAO;
import com.petboss.model.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/registerStaff")
public class RegisterStaffServlet extends HttpServlet {

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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/admin/registerStaff.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String role = req.getParameter("role");
        String pmId = req.getParameter("pmId");

        if (role == null || role.isEmpty()) {
            req.setAttribute("error", "Please select a role");
            req.getRequestDispatcher("/admin/registerStaff.jsp").forward(req, resp);
            return;
        }

     // PM ID required ONLY for STAFF
        if ("Staff".equalsIgnoreCase(role)) {
            if (pmId == null || pmId.trim().isEmpty()) {
                req.setAttribute("error", "PM ID is required for Staff");
                req.getRequestDispatcher("/admin/registerStaff.jsp").forward(req, resp);
                return;
            }
        } else {
            pmId = null; // Admin & Purchasing Manager
        }

        Staff staff = new Staff();
        staff.setFullName(req.getParameter("name"));
        staff.setEmail(req.getParameter("email"));
        staff.setPhone(req.getParameter("phone"));
        staff.setAddress(req.getParameter("address"));
        staff.setRole(role);              // ADMIN / PM / STAFF
        staff.setPmId(pmId);
        staff.setPassword(null);          // FIRST TIME LOGIN
        staff.setStatus("PENDING");       // WAIT ACTIVATE

        try {
            staffDAO.insertStaff(staff);
            resp.sendRedirect(req.getContextPath() + "/staff");

        } catch (Exception e) {
            throw new ServletException("Error registering staff", e);
        }
    }
}


