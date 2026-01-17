<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.petboss.model.Order"%>
<%@ page import="com.petboss.model.OrderItem"%>

<%
Order order = (Order) request.getAttribute("order");
List<OrderItem> itemList =
    (List<OrderItem>) request.getAttribute("itemList");

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

if (order == null) {
    response.sendRedirect(request.getContextPath() + "/receive-order");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Receive Product</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
 href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
.info-input{
 width:100%;
 border:1px solid #ccc;
 border-radius:6px;
 padding:6px;
 background:#f3f4f6;
 }
 
html, body {
    height: 100%;
    margin: 0;
    background-color: #fdf8e9;
}
th {
    background-color: #e6f4ea;
    border: 1px solid #009a49;
}
td {
    border: 1px solid #009a49;
    text-align: center;
    font-size: 0.85rem;
    padding: 8px;
}
.nav-btn{
    display:block;
    background:#f2711c;
    color:white;
    padding:10px 16px;
    border-radius:9999px;
    text-align:center;
    font-weight:600;
}
.nav-btn.active{
    background:#009a49;
}

.readonly-box{
    cursor: not-allowed;
}

</style>

<script>
function openReceive(orderDetailId, productId, productName, remaining) {
    document.getElementById("popup").classList.remove("hidden");

    document.getElementById("orderDetailId").value = orderDetailId;
    document.getElementById("productId").value = productId;

    document.getElementById("displayProductId").value = productId;
    document.getElementById("displayProductName").value = productName;

    document.getElementById("productName").value = productName;
    document.getElementById("qty").max = remaining;

    // default arrival date = today
    document.getElementById("arrivalDate").value =
        new Date().toISOString().split("T")[0];
}

function closePopup() {
    document.getElementById("popup").classList.add("hidden");
}
</script>
</head>
<body class="font-sans flex flex-col h-screen">

<!-- ===== HEADER (SAME AS ADMIN) ===== -->
	<header
		class="w-full bg-[#266b8b] flex justify-between items-center px-6 py-3">
		<h1 class="text-white text-2xl font-bold">Pet Boss Centre Cash
			and Carry</h1>

		<form action="<%=request.getContextPath()%>/logout" method="post">
			<button
				class="text-white font-semibold text-sm">
				<i class="fas fa-sign-out-alt"></i> Logout
			</button>
		</form>
	</header>

	<div class="flex flex-1 overflow-hidden">

		<!-- ===== SIDEBAR (NO SCROLL, BALANCED VERSION) ===== -->
<aside class="w-60 bg-[#266b8b] px-5 py-4 flex flex-col h-full">

    <!-- ===== NAVIGATION ===== -->
    <nav class="flex-1 space-y-5">

        <a href="<%=request.getContextPath()%>/dashboard"
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-home w-5 text-center"></i>
            <span>Home</span>
        </a>

        <a href="<%=request.getContextPath()%>/profile"
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-user-circle w-5 text-center"></i>
            <span>Profile</span>
        </a>

        <a href="<%=request.getContextPath()%>/product"
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-box w-5 text-center"></i>
            <span>Product</span>
        </a>

        <a href="<%=request.getContextPath()%>/supplier"
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-truck w-5 text-center"></i>
            <span>Supplier</span>
        </a>

        <a href="<%=request.getContextPath()%>/order"
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-file-invoice w-5 text-center"></i>
            <span>Order</span>
        </a>

        <a href="<%=request.getContextPath()%>/receive-product"
           class="mx-auto w-[85%] h-11 bg-[#009a49] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-box-open w-5 text-center"></i>
            <span>Receive Order</span>
        </a>

        <a href="<%=request.getContextPath()%>/product-qc"
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-check-circle w-5 text-center"></i>
            <span>Product QC</span>
        </a>

    </nav>

   <!-- ===== LOGO (SAFE FOR SMALL SCREEN) ===== -->
	<div class="flex justify-center mt-auto pb-4">
	    <img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
	    	class="w-36 sm:w-40 md:w-44 opacity-100">
	</div>
</aside>

<!-- ================= MAIN ================= -->
<main class="flex-1 p-8 overflow-y-auto">

<!-- ===== CONTENT CARD ===== -->
<div class="bg-white p-8 rounded-2xl border-2 border-green-600 max-w-7xl mx-auto">

<!-- ===== TITLE INSIDE SAME WHITE BOX ===== -->
<div class="flex items-center gap-4 mb-4">
    <a href="<%=request.getContextPath()%>/receive-product"
       class="text-green-700 text-2xl hover:text-green-900">
        <i class="fas fa-arrow-left"></i>
    </a>
    <h2 class="text-3xl font-black text-cyan-900">RECEIVE ORDER</h2>
</div>

<!-- ===== GREEN DIVIDER ===== -->
<hr class="border-green-600 mb-6">

<!-- ================= ORDER INFO ================= -->
<div class="bg-white border-2 border-green-600 rounded-xl p-6 mb-8 w-full">

    <h3 class="font-black text-lg mb-4 text-green-700">
        ORDER DETAILS
    </h3>

    <div class="grid grid-cols-2 gap-4 text-sm">


        <div class="readonly-box">
            <label class="font-bold">Supplier</label>
            <input class="info-input"
                   value="<%=order.getSupplierName()%>" readonly>
        </div>

        <div class="readonly-box">
            <label class="font-bold">Order Date</label>
            <input class="info-input"
                   value="<%=sdf.format(order.getOrderDate())%>" readonly>
        </div>

        <div class="readonly-box">
            <label class="font-bold">Order By</label>
            <input class="info-input"
                   value="<%=order.getStaffName()%>" readonly>
        </div>

        <div class="readonly-box">
            <label class="font-bold">Order Status</label>
            <input class="info-input"
                   value="<%=order.getStatus()%>" readonly>
        </div>

    </div>

</div>

<!-- ================= PRODUCT DETAILS ================= -->
<div class="bg-white border-2 border-[#009a49] rounded-2xl p-5 mb-8">

    <h3 class="font-black text-lg mb-4 text-green-700">
        PRODUCT DETAILS
    </h3>

    <table class="w-full border-collapse text-sm">
<thead>
<tr class="bg-[#e6f4ea] text-center">
    <th>Product ID</th>
    <th>Product</th>
    <th>Quantity Ordered</th>
    <th>Previously Received</th>
    <th>Remaining</th>
    <th>Action</th>
</tr>
</thead>

<tbody>
<% for (OrderItem i : itemList) {
   int remaining = i.getQuantity() - i.getReceived();
%>
<tr class="text-center">
<td><%=i.getProductId()%></td>
<td><%=i.getProductName()%></td>
<td><%=i.getQuantity()%></td>
<td><%=i.getReceived()%></td>
<td><%=remaining%></td>
<td>
<% if (remaining > 0) { %>
<button
 onclick="openReceive(
   <%=i.getOrderDetailId()%>,
   '<%=i.getProductId()%>',
   '<%=i.getProductName()%>',
   <%=remaining%>)"
 class="bg-[#009a49] text-white px-5 py-1 rounded-full">
 Receive
</button>
<% } else { %>
<span class="bg-gray-400 text-white text-xs font-bold px-5 py-1 rounded-full">
 Complete
</span>
<% } %>
</td>
</tr>
<% } %>
</tbody>
</table>

</div>

<!-- ================= RECEIVE HISTORY ================= -->
<div class="bg-white border-2 border-[#009a49] rounded-xl p-5">

<h3 class="font-black text-lg mb-3 text-left text-green-700">
    RECEIVE HISTORY
</h3>

    <div class="max-h-56 overflow-y-auto border border-[#009a49] rounded-lg">

        <table class="w-full text-sm border-collapse">
            <thead class="bg-[#e6f4ea] sticky top-0 z-10">
            <tr class="text-center">
                <th class="border border-[#009a49] px-2 py-1">Product ID</th>
                <th class="border border-[#009a49] px-2 py-1">Batch No</th>
                <th class="border border-[#009a49] px-2 py-1">Quantity</th>
                <th class="border border-[#009a49] px-2 py-1">Date</th>
            </tr>
            </thead>

            <tbody>
            <%
            List<String[]> history =
                (List<String[]>) request.getAttribute("receiveHistory");

            if (history != null && !history.isEmpty()) {
                for (String[] h : history) {
            %>
            <tr class="text-center">
                <td class="border border-[#009a49] px-2 py-1"><%=h[0]%></td>
                <td class="border border-[#009a49] px-2 py-1"><%=h[1]%></td>
                <td class="border border-[#009a49] px-2 py-1"><%=h[2]%></td>
                <td class="border border-[#009a49] px-2 py-1"><%=h[3]%></td>
            </tr>
            <% }} else { %>
            <tr>
                <td colspan="4" class="text-center py-3 text-gray-500">
                    No receive history
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        </div>
</div> <!-- END CONTENT CARD -->
</main>

<!-- RECEIVE PRODUCT POPUP -->
<div id="popup"
 class="hidden fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center z-50">

<div class="bg-white border-2 border-[#009a49] rounded-xl p-6 w-[420px]">

<h3 class="text-xl font-bold mb-4">Receive Product</h3>
<%
String errorMsg = (String) request.getAttribute("errorMessage");
if (errorMsg != null) {
%>
<div class="bg-red-100 border border-red-500
            text-red-700 text-sm
            px-3 py-2 rounded mb-3 text-center">
    <%= errorMsg %>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("popup").classList.remove("hidden");
});
</script>
<%
}
%>
<form method="post" action="<%=request.getContextPath()%>/receive-product">
<!-- hidden -->
<input type="hidden" name="orderId" value="<%=order.getOrderId()%>">
<input type="hidden" name="orderDetailId" id="orderDetailId"
 value="<%= request.getAttribute("popupOrderDetailId") != null
          ? request.getAttribute("popupOrderDetailId") : "" %>">

<input type="hidden" name="productId" id="productId"
 value="<%= request.getAttribute("popupProductId") != null
          ? request.getAttribute("popupProductId") : "" %>">

<input type="hidden" name="productName" id="productName"
 value="<%= request.getAttribute("popupProductName") != null
          ? request.getAttribute("popupProductName") : "" %>">

<!-- DISPLAY INFO -->
<div class="mb-3">
    <label class="text-sm font-semibold">Product ID</label>
    <input id="displayProductId"
       class="w-full border rounded px-3 py-2 bg-gray-100"
       value="<%= request.getAttribute("popupProductId") != null
                ? request.getAttribute("popupProductId")
                : "" %>"
       disabled>
</div>

<div class="mb-3">
    <label class="text-sm font-semibold">Product</label>
    <input id="displayProductName"
       class="w-full border rounded px-3 py-2 bg-gray-100"
       value="<%= request.getAttribute("popupProductName") != null
                ? request.getAttribute("popupProductName")
                : "" %>"
       disabled>
</div>

<!-- OPTIONAL -->
<div class="mb-3">
    <label class="text-sm font-semibold">Invoice Number</label>
    <input name="invoiceNo"
       value="<%= request.getAttribute("popupInvoiceNo") != null
                ? request.getAttribute("popupInvoiceNo")
                : "" %>"
       class="w-full border rounded px-3 py-2"
       placeholder="Optional">

</div>

<!-- REQUIRED -->
<div class="mb-3">
    <label class="text-sm font-semibold">Quantity Receive</label>
    <input id="qty" name="quantityReceived" type="number"
           min="1" required
           class="w-full border rounded px-3 py-2">
</div>

<div class="mb-4">
    <label class="text-sm font-semibold">Arrival Date</label>
    <input id="arrivalDate" name="arrivalDate" type="date"
           required
           class="w-full border rounded px-3 py-2">
</div>

<!-- ACTION -->
<div class="flex justify-center gap-4 mt-6">
<button type="button"
 onclick="closePopup()"
 class="bg-gray-400 text-white px-6 py-1 rounded-full">
 Cancel
</button>

<button type="submit"
 class="bg-[#009a49] text-white px-6 py-1 rounded-full font-semibold">
 Save
</button>
</div>

</form>
</div>
</div>
</div>
</body>
</html>
