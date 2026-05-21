package com.ecommerce.dao;

import com.ecommerce.model.Product;
import com.ecommerce.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<Product> getAllActiveProducts() {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "INNER JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.is_active = true";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();

                product.setId(rs.getInt("id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setCategoryName(rs.getString("category_name"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setImageUrl(rs.getString("image_url"));
                product.setActive(rs.getBoolean("is_active"));

                products.add(product);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "INNER JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.is_active = true AND p.category_id = ?";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, categoryId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();

                product.setId(rs.getInt("id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setCategoryName(rs.getString("category_name"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setImageUrl(rs.getString("image_url"));
                product.setActive(rs.getBoolean("is_active"));

                products.add(product);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    public Product getProductById(int id) {
        Product product = null;

        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "INNER JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.id = ? AND p.is_active = true";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                product = new Product();

                product.setId(rs.getInt("id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setCategoryName(rs.getString("category_name"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setImageUrl(rs.getString("image_url"));
                product.setActive(rs.getBoolean("is_active"));
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return product;
    }


    public List<Product> getAllProductsForAdmin() {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "INNER JOIN categories c ON p.category_id = c.id " +
                     "ORDER BY p.id ASC";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();

                product.setId(rs.getInt("id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setCategoryName(rs.getString("category_name"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setImageUrl(rs.getString("image_url"));
                product.setActive(rs.getBoolean("is_active"));

                products.add(product);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    public boolean updateProductActiveStatus(int productId, boolean active) {
        boolean success = false;

        String sql = "UPDATE products SET is_active = ? WHERE id = ?";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setBoolean(1, active);
            ps.setInt(2, productId);

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                success = true;
            }

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }


    public boolean addProduct(Product product) {
        boolean success = false;

        String sql = "INSERT INTO products (category_id, name, description, price, stock, image_url, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, true)";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, product.getCategoryId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getStock());
            ps.setString(6, product.getImageUrl());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                success = true;
            }

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }
    public boolean updateProductStock(int productId, int stock) {
    boolean success = false;

    String sql = "UPDATE products SET stock = ? WHERE id = ?";

    try {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, stock);
        ps.setInt(2, productId);

        int affectedRows = ps.executeUpdate();

        if (affectedRows > 0) {
            success = true;
        }

        ps.close();
        conn.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

    return success;
}
}