<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="en_US"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cart - Parfum Lab</title>

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
            border: none;
        }

        input {
            width: 60px;
            padding: 5px;
        }

        .total {
            margin-top: 20px;
            font-size: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>

<header>
    <h1>Parfum Lab</h1>
    <p>Shopping Cart</p>
</header>

<div class="container">

    <a class="btn" href="home">Continue Shopping</a>

    <h2>My Cart</h2>
    <c:if test="${not empty error}"><p role="alert"><c:out value="${error}"/></p></c:if>

    <c:if test="${empty sessionScope.cart}">
        <p>Your cart is empty.</p>
    </c:if>

    <c:if test="${not empty sessionScope.cart}">
        <table>
            <tr>
                <th>Product</th>
                <th>Unit Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
                <th>Action</th>
            </tr>

            <c:forEach var="item" items="${sessionScope.cart}">
                <tr>
                    <td><c:out value="${item.product.name}"/></td>

                    <td>
                        <fmt:formatNumber value="${item.product.price}" type="number" minFractionDigits="2"/> TRY
                    </td>

                    <td>
                        <form action="${pageContext.request.contextPath}/cart" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${item.product.id}">
                            <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.stock}">
                            <button class="btn" type="submit">Update</button>
                        </form>
                    </td>

                    <td>
                        <fmt:formatNumber value="${item.subtotal}" type="number" minFractionDigits="2"/> TRY
                    </td>

                    <td>
                    <a class="btn" href="${pageContext.request.contextPath}/cart?action=remove&id=${item.product.id}">Remove</a>                    </td>
                </tr>
            </c:forEach>
        </table>

        <p class="total">
            Grand Total:
            <fmt:formatNumber value="${total}" type="number" minFractionDigits="2"/> TRY
        </p>

        <form action="${pageContext.request.contextPath}/order" method="post">
            <button class="btn" type="submit">Place Order</button>
        </form>
            </c:if>

</div>

</body>
</html>