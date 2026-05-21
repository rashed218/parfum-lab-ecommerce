<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign In - Parfum Lab</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
        }

        header {
            background-color: #222;
            color: white;
            padding: 15px 30px;
        }

        .container {
            width: 400px;
            margin: 40px auto;
            background: white;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        input {
            width: 100%;
            padding: 9px;
            margin: 8px 0;
            box-sizing: border-box;
        }

        .btn {
            display: inline-block;
            padding: 8px 12px;
            background-color: #222;
            color: white;
            border: none;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .error {
            color: red;
        }
    </style>
</head>
<body>

<header>
    <h1>Parfum Lab</h1>
    <p>Customer Sign In</p>
</header>

<div class="container">

    <h2>Sign In</h2>

    <c:if test="${not empty error}">
        <p class="error"><c:out value="${error}"/></p>
    </c:if>

    <form action="login" method="post">
        <label>Email</label>
        <input type="email" name="email" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <button class="btn" type="submit">Sign In</button>
        <a class="btn" href="register">Register</a>
        <a class="btn" href="home">Home</a>
    </form>

</div>

</body>
</html>