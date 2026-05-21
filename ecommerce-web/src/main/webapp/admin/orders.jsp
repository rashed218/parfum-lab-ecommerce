<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="en_US"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Management - Parfum Lab</title>

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
            border: none;
            margin: 3px;
        }

        select {
            padding: 6px;
        }

        .beklemede {
            color: orange;
            font-weight: bold;
        }

        .tamamlandi {
            color: green;
            font-weight: bold;
        }

        .iptal {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>

<header>
    <h1>Parfum Lab</h1>
    <p>Order Management</p>
</header>

<div class="container">

    <a class="btn" href="dashboard">Dashboard</a>
    <a class="btn" href="../home">Home</a>

    <h2>Order List</h2>

    <table>
        <tr>
            <th>Order ID</th>
            <th>Customer</th>
            <th>Date</th>
            <th>Total Amount</th>
            <th>Status</th>
            <th>Update Status</th>
        </tr>

        <c:forEach var="order" items="${orders}">
            <tr>
                <td>${order.id}</td>
                <td><c:out value="${order.customerName}"/></td>

                <td>
                    <fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm"/>
                </td>

                <td>
                    <fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2"/> TRY
                </td>

                <td>
                    <c:choose>
                        <c:when test="${order.status == 'Pending'}">
                            <span class="beklemede"><c:out value="${order.status}"/></span>
                        </c:when>
                        <c:when test="${order.status == 'Completed'}">
                            <span class="tamamlandi"><c:out value="${order.status}"/></span>
                        </c:when>
                        <c:when test="${order.status == 'Cancelled'}">
                            <span class="iptal"><c:out value="${order.status}"/></span>
                        </c:when>
                        <c:otherwise>
                            <span><c:out value="${order.status}"/></span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>
                    <form action="orders" method="post">
                        <input type="hidden" name="orderId" value="${order.id}">

                        <select name="status">
                            <option value="Pending" ${order.status == 'Pending' ? 'selected' : ''}>Pending</option>
                            <option value="Processing" ${order.status == 'Processing' ? 'selected' : ''}>Processing</option>
                            <option value="Shipped" ${order.status == 'Shipped' ? 'selected' : ''}>Shipped</option>
                            <option value="Completed" ${order.status == 'Completed' ? 'selected' : ''}>Completed</option>
                            <option value="Cancelled" ${order.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                        </select>

                        <button class="btn" type="submit">Update</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>

</div>

</body>
</html>