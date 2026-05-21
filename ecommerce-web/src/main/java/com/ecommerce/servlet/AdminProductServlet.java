package com.ecommerce.servlet;

import com.ecommerce.dao.CategoryDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Category;
import com.ecommerce.model.Product;
import com.ecommerce.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();
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

            productDAO.updateProductActiveStatus(id, active);

            response.sendRedirect("products");
            return;
        }

        List<Product> products = productDAO.getAllProductsForAdmin();
        List<Category> categories = categoryDAO.getAllActiveCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("../login");
            return;
        }

        String action = request.getParameter("action");

        if ("updateStock".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            if (stock >= 0) {
                productDAO.updateProductStock(productId, stock);
            }

            response.sendRedirect("products");
            return;
        }

        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String imageUrl = request.getParameter("imageUrl");

        if (imageUrl == null || imageUrl.trim().isEmpty()) {
            imageUrl = "images/default.jpg";
        }

        Product product = new Product();

        product.setCategoryId(categoryId);
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setStock(stock);
        product.setImageUrl(imageUrl);
        product.setActive(true);

        productDAO.addProduct(product);

        response.sendRedirect("products");
    }
}