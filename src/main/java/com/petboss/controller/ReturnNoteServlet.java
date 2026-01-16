package com.petboss.controller;

import com.petboss.dao.ReturnNoteDAO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/return-note")
public class ReturnNoteServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final ReturnNoteDAO dao = new ReturnNoteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String qcId = req.getParameter("qcId");

        if (qcId == null) {
            res.sendRedirect(req.getContextPath() + "/product-qc?tab=completed");
            return;
        }

        req.setAttribute("note", dao.getReturnNoteByQC(qcId));
        req.getRequestDispatcher("/pm/returnNote.jsp").forward(req, res);
    }
}