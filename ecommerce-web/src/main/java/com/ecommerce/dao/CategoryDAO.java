package com.ecommerce.dao;

import com.ecommerce.model.Category;
import com.ecommerce.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public List<Category> getAllActiveCategories() {
        List<Category> categories = new ArrayList<>();

        String sql = "SELECT * FROM categories WHERE is_active = true";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Category category = new Category();

                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                category.setActive(rs.getBoolean("is_active"));

                categories.add(category);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return categories;
    }


    public List<Category> getAllCategoriesForAdmin() {
        List<Category> categories = new ArrayList<>();

        String sql = "SELECT * FROM categories ORDER BY id ASC";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Category category = new Category();

                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                category.setActive(rs.getBoolean("is_active"));

                categories.add(category);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return categories;
    }


    public boolean updateCategoryActiveStatus(int categoryId, boolean active) {
        boolean success = false;

        String sql = "UPDATE categories SET is_active = ? WHERE id = ?";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setBoolean(1, active);
            ps.setInt(2, categoryId);

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


    public boolean addCategory(String name, String description) {
        boolean success = false;

        String sql = "INSERT INTO categories (name, description, is_active) VALUES (?, ?, true)";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, description);

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