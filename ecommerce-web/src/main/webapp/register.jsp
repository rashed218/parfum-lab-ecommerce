<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - Parfum Lab</title>

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
            width: 450px;
            margin: 40px auto;
            background: white;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        input, textarea {
            width: 100%;
            padding: 9px;
            margin: 8px 0;
            box-sizing: border-box;
        }

        textarea {
            height: 80px;
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
    <p>Create an Account</p>
</header>

<div class="container">

    <h2>Register</h2>

    <c:if test="${not empty error}">
        <p class="error"><c:out value="${error}"/></p>
    </c:if>

    <form action="register" method="post">
        <label>Full name</label>
        <input type="text" name="fullName" required>

        <label>Email</label>
        <input type="email" name="email" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <label>Phone</label>
        <input type="text" name="phone">

        <label>Address</label>
        <textarea name="address"></textarea>

        <button class="btn" type="submit">Register</button>
        <a class="btn" href="login">Sign In</a>
        <a class="btn" href="home">Home</a>
    </form>

</div>

</body>
</html>