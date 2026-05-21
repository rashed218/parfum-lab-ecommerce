package com.ecommerce.dao;

import com.ecommerce.model.User;
import com.ecommerce.util.DBConnection;
import com.ecommerce.util.PasswordHasher;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public User login(String email, String password) {
        if (email == null || password == null) return null;
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            User user;
            String stored;
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                stored = rs.getString("password");
                if (PasswordHasher.isHashed(stored)) {
                    if (!PasswordHasher.verify(password, stored)) return null;
                } else if (!password.equals(stored)) {
                    return null;
                }
                user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
            }
            // Upgrade legacy local accounts on successful login.
            if (!PasswordHasher.isHashed(stored)) {
                try (PreparedStatement update = conn.prepareStatement(
                        "UPDATE users SET password = ? WHERE id = ? AND BINARY password = ?")) {
                    update.setString(1, PasswordHasher.hash(password));
                    update.setInt(2, user.getId());
                    update.setString(3, stored);
                    if (update.executeUpdate() != 1) return null;
                }
            }
            return user;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    public boolean emailExists(String email) {
        boolean exists = false;

        String sql = "SELECT id FROM users WHERE email = ?";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                exists = true;
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return exists;
    }


    public boolean register(User user) {
        boolean success = false;

        String sql = "INSERT INTO users (full_name, email, password, phone, address, role) " +
                     "VALUES (?, ?, ?, ?, ?, 'CUSTOMER')";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, PasswordHasher.hash(user.getPassword()));
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());

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