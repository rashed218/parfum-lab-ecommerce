package com.ecommerce.servlet;

import com.ecommerce.dao.AdminDAO;
import com.ecommerce.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("../login");
            return;
        }

        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("../home");
            return;
        }

        request.setAttribute("productCount", adminDAO.getProductCount());
        request.setAttribute("categoryCount", adminDAO.getCategoryCount());
        request.setAttribute("userCount", adminDAO.getUserCount());
        request.setAttribute("orderCount", adminDAO.getOrderCount());
        request.setAttribute("pendingOrderCount", adminDAO.getPendingOrderCount());

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}