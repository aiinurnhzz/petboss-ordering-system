package com.petboss.controller;

import com.petboss.dao.StaffDAO;
import com.petboss.model.Staff;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/staff")
public class StaffServlet extends HttpServlet {

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String role = request.getParameter("role");

        List<Staff> staffList = staffDAO.searchStaff(keyword, role);
        request.setAttribute("staffList", staffList);

        request.getRequestDispatcher("/admin/staff.jsp").forward(request, response);
    }
    

}
