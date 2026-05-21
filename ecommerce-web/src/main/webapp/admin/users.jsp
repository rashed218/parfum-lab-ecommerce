<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="en_US"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Users - Parfum Lab</title>

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
            width: 95%;
            margin: 30px auto;
            background: white;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border-bottom: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        .btn {
            display: inline-block;
            padding: 7px 10px;
            background-color: #222;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin: 3px;
        }
    </style>
</head>
<body>

<header>
    <h1>Parfum Lab</h1>
    <p>User Management</p>
</header>

<div class="container">

    <a class="btn" href="dashboard">Dashboard</a>
    <a class="btn" href="../home">Home</a>

    <h2>User List</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Full name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Role</th>
            <th>Registration Date</th>
        </tr>

        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.id}</td>
                <td><c:out value="${user.fullName}"/></td>
                <td><c:out value="${user.email}"/></td>
                <td><c:out value="${user.phone}"/></td>
                <td><c:out value="${user.role}"/></td>
                <td>
                    <fmt:formatDate value="${user.createdAt}" pattern="dd.MM.yyyy HH:mm"/>
                </td>
            </tr>
        </c:forEach>
    </table>

</div>

</body>
</html>