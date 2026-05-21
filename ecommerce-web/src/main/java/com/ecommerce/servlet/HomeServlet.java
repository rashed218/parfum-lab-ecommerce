package com.ecommerce.servlet;

import com.ecommerce.dao.CategoryDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Category;
import com.ecommerce.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String categoryIdText = request.getParameter("categoryId");

        List<Product> products;

        if (categoryIdText != null && !categoryIdText.isEmpty()) {
            int categoryId = Integer.parseInt(categoryIdText);
            products = productDAO.getProductsByCategory(categoryId);

            request.setAttribute("selectedCategoryId", categoryId);
        } else {
            products = productDAO.getAllActiveProducts();
        }

        List<Category> categories = categoryDAO.getAllActiveCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}