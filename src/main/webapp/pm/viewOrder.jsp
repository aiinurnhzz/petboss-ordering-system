<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="true"%>
<%@ page import="java.util.List" %>
<%@ page import="com.petboss.model.Order" %>
<%@ page import="com.petboss.model.OrderItem" %>

<%
String staffId = (String) session.getAttribute("staffId");
if (staffId == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

Order order = (Order) request.getAttribute("order");
List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems");

Double subtotalObj = (Double) request.getAttribute("subtotal");
Double taxObj = (Double) request.getAttribute("tax");
Double grandObj = (Double) request.getAttribute("grandTotal");

double subtotal = subtotalObj != null ? subtotalObj : 0.0;
double tax = taxObj != null ? taxObj : 0.0;
double grandTotal = grandObj != null ? grandObj : 0.0;

if (order == null) {
    response.sendRedirect(request.getContextPath() + "/order");
    return;
}

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String orderDateStr = order.getOrderDate() != null
        ? sdf.format(order.getOrderDate())
        : "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>View Order</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
html, body {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #fdf8e9;
}
th {
    background-color: #e6f4ea;
    border: 1px solid #009a49;
}
td {
    border: 1px solid #009a49;
    padding: 8px;
    text-align: center;
    font-size: 0.85rem;
}

/* 🚫 VIEW ONLY CURSOR */
.view-only {
    cursor: not-allowed;
}
</style>
</head>

<body class="font-sans flex flex-col h-screen">

<!-- ===== HEADER ===== -->
<header class="w-full bg-[#266b8b] flex justify-between items-center px-6 py-3">
    <h1 class="text-white text-2xl font-bold">Pet Boss Centre Cash and Carry</h1>
    <form action="<%=request.getContextPath()%>/logout" method="post">
        <button class="text-white font-semibold text-sm">
            <i class="fas fa-sign-out-alt"></i> Logout
        </button>
    </form>
</header>

<div class="flex flex-1 overflow-hidden">

<!-- ===== SIDEBAR ===== -->
<aside class="w-60 bg-[#266b8b] px-5 py-4 flex flex-col h-full">

<nav class="flex-1 space-y-5">

<a href="<%=request.getContextPath()%>/dashboard"
   class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
          px-4 rounded-full flex items-center gap-3
          border-2 border-white shadow-md text-sm font-semibold">
    <i class="fas fa-home w-5 text-center"></i> Home
</a>

<a href="<%=request.getContextPath()%>/profile"
   class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
          px-4 rounded-full flex items-center gap-3
          border-2 border-white shadow-md text-sm font-semibold">
    <i class="fas fa-user-circle w-5 text-center"></i> Profile
</a>

<a href="<%=request.getContextPath()%>/product"
   class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
          px-4 rounded-full flex items-center gap-3
          border-2 border-white shadow-md text-sm font-semibold">
    <i class="fas fa-box w-5 text-center"></i> Product
</a>

<a href="<%=request.getContextPath()%>/supplier"
   class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
          px-4 rounded-full flex items-center gap-3
          border-2 border-white shadow-md text-sm font-semibold">
    <i class="fas fa-truck w-5 text-center"></i> Supplier
</a>

<a href="<%=request.getContextPath()%>/order"
   class="mx-auto w-[85%] h-11 bg-[#009a49] text-white
          px-4 rounded-full flex items-center gap-3
          border-2 border-white shadow-md text-sm font-semibold">
    <i class="fas fa-file-invoice w-5 text-center"></i> Order
</a>

<a href="<%=request.getContextPath()%>/receive-product"
   class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
          px-4 rounded-full flex items-center gap-3
          border-2 border-white shadow-md text-sm font-semibold">
    <i class="fas fa-box-open w-5 text-center"></i> Receive Product
</a>

<a href="<%=request.getContextPath()%>/product-qc"
   class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
          px-4 rounded-full flex items-center gap-3
          border-2 border-white shadow-md text-sm font-semibold">
    <i class="fas fa-check-circle w-5 text-center"></i> Product QC
</a>

</nav>

	<div class="flex justify-center mt-auto pb-4">
	    <img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
	    	class="w-36 sm:w-40 md:w-44 opacity-100">
	</div>

</aside>

<!-- ===== MAIN ===== -->
<main class="flex-1 p-8 overflow-y-auto">

<!-- ===== CONTENT CARD ===== -->
<div class="bg-white p-8 rounded-2xl border-2 border-green-600 max-w-7xl mx-auto">

<!-- ===== TITLE (EXACT LIKE EXAMPLE) ===== -->
<div class="flex items-center gap-4 mb-4">
    <a href="<%=request.getContextPath()%>/order"
       class="text-green-700 text-2xl hover:text-green-900">
        <i class="fas fa-arrow-left"></i>
    </a>
    <h2 class="text-3xl font-black text-cyan-900">VIEW ORDER</h2>
</div>

<hr class="border-green-600 mb-6">

<!-- ===== ORDER INFO ===== -->
<div class="grid grid-cols-4 gap-6 mb-8 border-2 border-green-600 p-6 rounded-xl">

<div>
<label class="text-sm font-bold">Order ID</label>
<input class="w-full border p-2 bg-gray-100 view-only"
       value="<%=order.getOrderId()%>" readonly>
</div>

<div>
<label class="text-sm font-bold">Supplier</label>
<input class="w-full border p-2 bg-gray-100 view-only"
       value="<%=order.getSupplierName()%>" readonly>
</div>

<div>
<label class="text-sm font-bold">Order By</label>
<input class="w-full border p-2 bg-gray-100 view-only"
       value="<%=order.getStaffName()%>" readonly>
</div>

<div>
<label class="text-sm font-bold">Order Date</label>
<input class="w-full border p-2 bg-gray-100 view-only"
       value="<%=orderDateStr%>" readonly>
</div>

</div>

<!-- ===== TABLE ===== -->
<table class="w-full mb-6">
<thead>
<tr>
<th>Product ID</th>
<th>Product</th>
<th>Quantity</th>
<th>Unit Price (RM)</th>
<th>Total (RM)</th>
</tr>
</thead>

<tbody>
<% if (orderItems == null || orderItems.isEmpty()) { %>
<tr>
<td colspan="5" class="py-4 text-gray-500">No items</td>
</tr>
<% } else {
for (OrderItem i : orderItems) { %>
<tr>
<td><%= i.getProductId() %></td>
<td><%= i.getProductName() %></td>
<td><%= i.getQuantity() %></td>
<td><%= String.format("%.2f", i.getUnitPrice()) %></td>
<td><%= String.format("%.2f", i.getTotal()) %></td>
</tr>
<% }} %>
</tbody>
</table>

<!-- ===== SUMMARY ===== -->
<div class="space-y-2 text-sm max-w-md ml-auto">
<div class="flex justify-between">
<span>Subtotal (RM)</span>
<span><%= String.format("%.2f", subtotal) %></span>
</div>

<div class="flex justify-between">
<span>Tax (6%)</span>
<span><%= String.format("%.2f", tax) %></span>
</div>

<hr>

<div class="flex justify-between font-bold text-green-700">
<span>Grand Total (RM)</span>
<span><%= String.format("%.2f", grandTotal) %></span>
</div>
</div>

</div>
</main>
</div>
</body>
</html>