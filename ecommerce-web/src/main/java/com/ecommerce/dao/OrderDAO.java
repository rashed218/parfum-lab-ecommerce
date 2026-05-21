package com.ecommerce.dao;

import com.ecommerce.model.CartItem;
import com.ecommerce.model.Order;
import com.ecommerce.model.User;
import com.ecommerce.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public boolean createOrder(User user, List<CartItem> cart) {
        boolean success = false;

        if (user == null || cart == null || cart.isEmpty()) {
            return false;
        }

        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            double totalAmount = 0;

            for (CartItem item : cart) {
                totalAmount += item.getSubtotal();
            }

            String orderSql = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, 'Pending')";

            PreparedStatement orderPs = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            orderPs.setInt(1, user.getId());
            orderPs.setDouble(2, totalAmount);

            orderPs.executeUpdate();

            ResultSet generatedKeys = orderPs.getGeneratedKeys();

            int orderId = 0;

            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            }

            generatedKeys.close();
            orderPs.close();

            if (orderId == 0) {
                conn.rollback();
                return false;
            }

            String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal) VALUES (?, ?, ?, ?, ?)";

            String stockSql = "UPDATE products SET stock = stock - ? WHERE id = ? AND stock >= ?";

            for (CartItem item : cart) {
                PreparedStatement itemPs = conn.prepareStatement(itemSql);

                itemPs.setInt(1, orderId);
                itemPs.setInt(2, item.getProduct().getId());
                itemPs.setInt(3, item.getQuantity());
                itemPs.setDouble(4, item.getProduct().getPrice());
                itemPs.setDouble(5, item.getSubtotal());

                itemPs.executeUpdate();
                itemPs.close();

                PreparedStatement stockPs = conn.prepareStatement(stockSql);

                stockPs.setInt(1, item.getQuantity());
                stockPs.setInt(2, item.getProduct().getId());
                stockPs.setInt(3, item.getQuantity());

                int updatedRows = stockPs.executeUpdate();
                stockPs.close();

                if (updatedRows == 0) {
                    conn.rollback();
                    return false;
                }
            }

            conn.commit();
            success = true;

        } catch (Exception e) {
            e.printStackTrace();

            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }

        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return success;
    }


    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();

        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();

                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));

                orders.add(order);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
    
}