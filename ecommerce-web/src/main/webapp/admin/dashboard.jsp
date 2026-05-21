<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Parfum Lab</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f7f7f7;
        }

        header {
            background-color: #222;
            color: white;
            padding: 15px 30px;
        }

        .container {
            width: 85%;
            margin: 30px auto;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .card {
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
        }

        .card h3 {
            margin-top: 0;
        }

        .number {
            font-size: 28px;
            font-weight: bold;
            color: #7a4b20;
        }

        .btn {
            display: inline-block;
            padding: 8px 12px;
            background-color: #222;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<header>
    <h1>Parfum Lab</h1>
    <p>Admin Dashboard</p>
</header>

<div class="container">

    <a class="btn" href="../home">Home</a>
    <a class="btn" href="../logout">Sign Out</a>

    <h2>Admin Dashboard</h2>

    <div class="cards">

        <div class="card">
            <h3>Total Products</h3>
            <p class="number">${productCount}</p>
        </div>

        <div class="card">
            <h3>Total Categories</h3>
            <p class="number">${categoryCount}</p>
        </div>

        <div class="card">
            <h3>Total Users</h3>
            <p class="number">${userCount}</p>
        </div>

        <div class="card">
            <h3>Total Orders</h3>
            <p class="number">${orderCount}</p>
        </div>

        <div class="card">
            <h3>Pending Orders</h3>
            <p class="number">${pendingOrderCount}</p>
        </div>

    </div>

    <br>

    <a class="btn" href="products">Product Management</a>
    <a class="btn" href="categories">Category Management</a>
    <a class="btn" href="orders">Order Management</a>
    <a class="btn" href="users">Users</a>

</div>

</body>
</html>