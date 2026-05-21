package com.ecommerce.servlet;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idText = request.getParameter("id");

        if (idText == null || idText.isEmpty()) {
            response.sendRedirect("home");
            return;
        }

        int id = Integer.parseInt(idText);

        Product product = productDAO.getProductById(id);

        if (product == null) {
            response.sendRedirect("home");
            return;
        }

        request.setAttribute("product", product);

        request.getRequestDispatcher("/product-detail.jsp").forward(request, response);
    }
}