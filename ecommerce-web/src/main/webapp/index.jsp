<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="en_US"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Parfum Lab</title>

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

        header h1 {
            margin: 0;
        }

        .container {
            width: 90%;
            margin: 25px auto;
        }

        .products {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .card {
            background: white;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        .card img {
            width: 100%;
            height: 160px;
            object-fit: cover;
            background-color: #eee;
        }

        .price {
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
    <p>Perfume Store</p>
    <c:choose>
    <c:when test="${not empty sessionScope.user}">
        <p>Hello, <c:out value="${sessionScope.user.fullName}"/></p>

        <a class="btn" href="cart">My Cart</a>
        <a class="btn" href="my-orders">My Orders</a>
        <a class="btn" href="logout">Sign Out</a>

        <c:if test="${sessionScope.user.role == 'ADMIN'}">
            <a class="btn" href="admin/dashboard">Admin Dashboard</a>
        </c:if>
    </c:when>

    <c:otherwise>
        <a class="btn" href="login">Sign In</a>
        <a class="btn" href="register">Register</a>
        <a class="btn" href="cart">My Cart</a>
    </c:otherwise>
</c:choose>
</header>

<div class="container">
    <h2>Products</h2>

    <div style="margin-bottom: 20px;">
    <a class="btn" href="home">All Products</a>

    <c:forEach var="category" items="${categories}">
        <a class="btn" href="home?categoryId=${category.id}">
            <c:out value="${category.name}"/>
        </a>
    </c:forEach>
</div>

    <div class="products">

        <c:forEach var="product" items="${products}">
            <div class="card">
                <img src="<c:out value='${product.imageUrl}'/>" alt="<c:out value='${product.name}'/>">

                <h3><c:out value="${product.name}"/></h3>

                <p><c:out value="${product.description}"/></p>

                <p>Category: <c:out value="${product.categoryName}"/></p>

                <p class="price">
                    <fmt:formatNumber value="${product.price}" type="number" minFractionDigits="2"/> TRY
                </p>

                <p>Stock: ${product.stock}</p>

                <c:choose>
                    <c:when test="${product.stock > 0}">
                        <a class="btn" href="${pageContext.request.contextPath}/cart?action=add&id=${product.id}">Add to Cart</a>
                        <a class="btn" href="product?id=${product.id}">Details</a>            
                            </c:when>
                    <c:otherwise>
                        <span class="btn disabled">Out of Stock</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:forEach>

    </div>
</div>

</body>
</html>