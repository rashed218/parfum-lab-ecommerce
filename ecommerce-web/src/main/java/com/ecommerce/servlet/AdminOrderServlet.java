package com.ecommerce.servlet;

import com.ecommerce.dao.AdminOrderDAO;
import com.ecommerce.model.Order;
import com.ecommerce.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {

    private AdminOrderDAO adminOrderDAO = new AdminOrderDAO();

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        return user != null && "ADMIN".equals(user.getRole());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("../login");
            return;
        }

        List<Order> orders = adminOrderDAO.getAllOrders();

        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("../login");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");

        if (status == null || !java.util.Set.of("Pending", "Processing", "Shipped", "Completed", "Cancelled").contains(status)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        adminOrderDAO.updateOrderStatus(orderId, status);

        response.sendRedirect("orders");
    }
}