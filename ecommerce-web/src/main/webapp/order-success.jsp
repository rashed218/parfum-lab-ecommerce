<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Successful - Parfum Lab</title>

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
            width: 60%;
            margin: 40px auto;
            background: white;
            padding: 25px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        .btn {
            display: inline-block;
            padding: 8px 12px;
            background-color: #222;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 8px;
        }

        .success {
            color: green;
            font-weight: bold;
        }
    </style>
</head>
<body>

<header>
    <h1>Parfum Lab</h1>
    <p>Order Confirmation</p>
</header>

<div class="container">
    <h2 class="success"><c:out value="${message}"/></h2>

    <p>Thank you for shopping with us.</p>

    <a class="btn" href="home">Home</a>
    <a class="btn" href="cart">My Cart</a>
</div>

</body>
</html>