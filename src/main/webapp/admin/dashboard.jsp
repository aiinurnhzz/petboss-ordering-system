<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.petboss.model.Order" %>
<%@ page import="com.petboss.model.OrderItem" %>

<%
    Order order = (Order) request.getAttribute("order");
    List<OrderItem> itemList =
        (List<OrderItem>) request.getAttribute("itemList");
    List<String> receiveHistory =
        (List<String>) request.getAttribute("receiveHistory");

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>

<!DOCTYPE html>
<html>
<head>
<title>View Received Order</title>

<style>
body {
    margin:0;
    font-family: Arial, sans-serif;
    background:#f7f2e9;
}

.sidebar {
    width:220px;
    background:#1f6787;
    position:fixed;
    top:0;
    bottom:0;
    padding-top:20px;
}

.sidebar a {
    display:block;
    padding:12px 20px;
    color:white;
    text-decoration:none;
}

.sidebar a.active {
    background:#2ea44f;
}

.content {
    margin-left:220px;
    padding:30px;
}

h2 {
    margin-bottom:10px;
}

.section {
    background:white;
    border:2px solid #2ea44f;
    border-radius:12px;
    padding:20px;
    margin-bottom:25px;
}

.info-grid {
    display:grid;
    grid-template-columns: repeat(2, 1fr);
    gap:10px 30px;
}

.info-grid div {
    font-size:14px;
}

table {
    width:100%;
    border-collapse:collapse;
}

th {
    background:#e9fff3;
    padding:12px;
    text-align:left;
}

td {
    padding:12px;
    border-top:1px solid #ddd;
}

.status {
    padding:4px 12px;
    border-radius:999px;
    font-size:12px;
    font-weight:600;
    background:#e8f5e9;
    color:#2e7d32;
}

.back-btn {
    display:inline-block;
    margin-top:10px;
    background:#2ea44f;
    color:white;
    padding:8px 18px;
    border-radius:999px;
    text-decoration:none;
    font-size:13px;
    font-weight:600;
}
</style>
</head>

<body>

<div class="sidebar">
    <a class="active">Receive Product</a>
</div>

<div class="content">

<h2>Completed Receiving</h2>

<!-- ===== ORDER INFO ===== -->
<div class="section">
    <h3>Order Information</h3>

    <div class="info-grid">
        <div><b>Order ID:</b> <%=order.getOrderId()%></div>
        <div><b>Supplier:</b> <%=order.getSupplierName()%></div>
        <div><b>Order Date:</b> <%=sdf.format(order.getOrderDate())%></div>
        <div><b>Status:</b> <span class="status"><%=order.getStatus()%></span></div>
        <div><b>Staff:</b> <%=order.getStaffName()%></div>
    </div>
</div>

<!-- ===== ITEM LIST ===== -->
<div class="section">
    <h3>Received Items</h3>

    <table>
        <thead>
            <tr>
                <th>Product</th>
                <th>Quantity Ordered</th>
                <th>Quantity Received</th>
            </tr>
        </thead>
        <tbody>
        <%
            if (itemList != null && !itemList.isEmpty()) {
                for (OrderItem i : itemList) {
        %>
            <tr>
                <td><%=i.getProductName()%></td>
                <td><%=i.getQuantity()%></td>
                <td><%=i.getReceived()%></td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="3" style="text-align:center;padding:20px;">
                    No items found
                </td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<!-- ===== RECEIVE HISTORY ===== -->
<div class="section">
    <h3>Receive History</h3>

    <ul>
    <%
        if (receiveHistory != null && !receiveHistory.isEmpty()) {
            for (String h : receiveHistory) {
    %>
        <li><%=h%></li>
    <%
            }
        } else {
    %>
        <li>No receive history available</li>
    <%
        }
    %>
    </ul>
</div>

<a class="back-btn"
   href="<%=request.getContextPath()%>/receive-order?tab=completed">
   ← Back to Completed Orders
</a>

</div>
</body>
</html>


