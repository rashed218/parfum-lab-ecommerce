package com.ecommerce.servlet;

import com.ecommerce.dao.CategoryDAO;
import com.ecommerce.model.Category;
import com.ecommerce.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class AdminCategoryServlet extends HttpServlet {

    private CategoryDAO categoryDAO = new CategoryDAO();

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

        String action = request.getParameter("action");

        if ("status".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean active = Boolean.parseBoolean(request.getParameter("active"));

            categoryDAO.updateCategoryActiveStatus(id, active);

            response.sendRedirect("categories");
            return;
        }

        List<Category> categories = categoryDAO.getAllCategoriesForAdmin();

        request.setAttribute("categories", categories);

        request.getRequestDispatcher("/admin/categories.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("../login");
            return;
        }

        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (name != null && !name.trim().isEmpty()) {
            categoryDAO.addCategory(name, description);
        }

        response.sendRedirect("categories");
    }
}