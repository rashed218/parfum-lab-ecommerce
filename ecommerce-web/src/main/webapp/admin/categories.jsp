<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Category Management - Parfum Lab</title>

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
            width: 90%;
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

        .active {
            color: green;
            font-weight: bold;
        }

        .passive {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>

<header>
    <h1>Parfum Lab</h1>
    <p>Category Management</p>
</header>

<div class="container">

    <a class="btn" href="dashboard">Dashboard</a>
    <a class="btn" href="../home">Home</a>

    <h2>Category List</h2>
        <h3>Add New Category</h3>

    <form action="categories" method="post" style="margin-bottom: 20px;">
    <input type="text" name="name" placeholder="Category name" required>
    <input type="text" name="description" placeholder="Description">
    <button class="btn" type="submit">Add Category</button>
</form>
    <table>
        <tr>
            <th>ID</th>
            <th>Category Name</th>
            <th>Description</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

        <c:forEach var="category" items="${categories}">
            <tr>
                <td>${category.id}</td>
                <td><c:out value="${category.name}"/></td>
                <td><c:out value="${category.description}"/></td>

                <td>
                    <c:choose>
                        <c:when test="${category.active}">
                            <span class="active">Active</span>
                        </c:when>
                        <c:otherwise>
                            <span class="passive">Inactive</span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>


    <c:choose>
                <c:when test="${category.active}">
                    <a class="btn" href="${pageContext.request.contextPath}/admin/categories?action=status&id=${category.id}&active=false">
                        Deactivate
                    </a>
                </c:when>
                <c:otherwise>
                    <a class="btn" href="${pageContext.request.contextPath}/admin/categories?action=status&id=${category.id}&active=true">
                        Activate
                    </a>
                </c:otherwise>
            </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>

</div>

</body>
</html>