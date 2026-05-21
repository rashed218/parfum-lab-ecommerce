package com.ecommerce.dao;

import com.ecommerce.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDAO {

    private int getCount(String sql) {
        int count = 0;

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getProductCount() {
        return getCount("SELECT COUNT(*) FROM products");
    }

    public int getCategoryCount() {
        return getCount("SELECT COUNT(*) FROM categories");
    }

    public int getUserCount() {
        return getCount("SELECT COUNT(*) FROM users");
    }

    public int getOrderCount() {
        return getCount("SELECT COUNT(*) FROM orders");
    }

    public int getPendingOrderCount() {
        return getCount("SELECT COUNT(*) FROM orders WHERE status = 'Pending'");
    }
}