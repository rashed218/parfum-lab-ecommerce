<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="en_US"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product Details - Parfum Lab</title>

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
            width: 80%;
            margin: 30px auto;
            background: white;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        .product-img {
            width: 300px;
            height: 260px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #ddd;
            margin: 15px 0;
        }

        .price {
            font-weight: bold;
            color: #7a4b20;
            font-size: 20px;
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

        .disabled {
            background-color: gray;
        }
    </style>
</head>
<body>

<header>
    <h1>Parfum Lab</h1>
    <p>Product Details</p>
</header>

<div class="container">

    <a class="btn" href="home">Back to Home</a>

    <c:if test="${product == null}">
        <h2>Product not found.</h2>
        <p>Please return to the home page.</p>
    </c:if>

    <c:if test="${product != null}">
        <h2><c:out value="${product.name}"/></h2>

        <img class="product-img"
             src="${pageContext.request.contextPath}/<c:out value='${product.imageUrl}'/>"
             alt="<c:out value='${product.name}'/>">

        <p><c:out value="${product.description}"/></p>

        <p>Category: <c:out value="${product.categoryName}"/></p>

        <p class="price">
            <fmt:formatNumber value="${product.price}" type="number" minFractionDigits="2"/> TRY
        </p>

        <p>Stock quantity: ${product.stock}</p>

        <c:choose>
            <c:when test="${product.stock > 0}">
                <a class="btn" href="${pageContext.request.contextPath}/cart?action=add&id=${product.id}">Add to Cart</a>            </c:when>
            <c:otherwise>
                <span class="btn disabled">Out of Stock</span>
            </c:otherwise>
        </c:choose>
    </c:if>

</div>

</body>
</html>