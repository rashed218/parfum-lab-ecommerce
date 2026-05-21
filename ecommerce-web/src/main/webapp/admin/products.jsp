<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="en_US"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product Management - Parfum Lab</title>

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
    <p>Product Management</p>
</header>

<div class="container">

    <a class="btn" href="dashboard">Dashboard</a>
    <a class="btn" href="../home">Home</a>

    <h2>Product List</h2>
        <h3>Add New Product</h3>

<form action="products" method="post" style="margin-bottom: 20px;">
    <input type="text" name="name" placeholder="Product name" required>

    <select name="categoryId" required>
        <c:forEach var="category" items="${categories}">
            <option value="${category.id}"><c:out value="${category.name}"/></option>
        </c:forEach>
    </select>

    <input type="text" name="description" placeholder="Description">
    <input type="number" step="0.01" name="price" placeholder="Price" required>
    <input type="number" name="stock" placeholder="Stock" required>
    <input type="text" name="imageUrl" placeholder="Image path">

    <button class="btn" type="submit">Add Product</button>
</form>
    <table>
        <tr>
            <th>ID</th>
            <th>Product Name</th>
            <th>Category</th>
            <th>Price</th>
            <th>Stock</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

        <c:forEach var="product" items="${products}">
            <tr>
                <td>${product.id}</td>
                <td><c:out value="${product.name}"/></td>
                <td><c:out value="${product.categoryName}"/></td>

                <td>
                    <fmt:formatNumber value="${product.price}" type="number" minFractionDigits="2"/> TRY
                </td>

                <td>${product.stock}</td>

                <td>
                    <c:choose>
                        <c:when test="${product.active}">
                            <span class="active">Active</span>
                        </c:when>
                        <c:otherwise>
                            <span class="passive">Inactive</span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>
                   <form action="products" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="updateStock">
                    <input type="hidden" name="id" value="${product.id}">
                    <input type="number" name="stock" value="${product.stock}" min="0" style="width:70px;">
                    <button class="btn" type="submit">Update Stock</button>
                       </form>

                    <c:choose>
                        <c:when test="${product.active}">
                            <a class="btn" href="products?action=status&id=${product.id}&active=false">Deactivate</a>
                        </c:when>
                        <c:otherwise>
                            <a class="btn" href="products?action=status&id=${product.id}&active=true">Activate</a>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>

</div>

</body>
</html>