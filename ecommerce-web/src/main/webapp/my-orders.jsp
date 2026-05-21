<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="en_US"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Orders - Parfum Lab</title>

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
            padding: 8px 12px;
            background-color: #222;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 8px;
        }

        .status {
            font-weight: bold;
        }
    </style>
</head>
<body>

<header>
    <h1>Parfum Lab</h1>
    <p>My Orders</p>
</header>

<div class="container">

    <a class="btn" href="home">Home</a>
    <a class="btn" href="cart">My Cart</a>

    <h2>My Orders</h2>

    <c:if test="${empty orders}">
        <p>You have no orders yet.</p>
    </c:if>

    <c:if test="${not empty orders}">
        <table>
            <tr>
                <th>Order No.</th>
                <th>Date</th>
                <th>Total Amount</th>
                <th>Status</th>
            </tr>

            <c:forEach var="order" items="${orders}">
                <tr>
                    <td>${order.id}</td>

                    <td>
                        <fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm"/>
                    </td>

                    <td>
                        <fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2"/> TRY
                    </td>

                    <td class="status"><c:out value="${order.status}"/></td>
                </tr>
            </c:forEach>
        </table>
    </c:if>

</div>

</body>
</html>