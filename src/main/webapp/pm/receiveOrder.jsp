<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.petboss.model.ReceiveOrder" %>

<%
String staffId = (String) session.getAttribute("staffId");
String role = (String) session.getAttribute("role");

if (staffId == null || role == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

String tab = request.getParameter("tab");
if (tab == null) tab = "pending";

List<ReceiveOrder> orderList =
    (List<ReceiveOrder>) request.getAttribute("orderList");

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Receive Order</title>

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

    cursor:not-allowed;      /* 🚫 mouse icon */
    pointer-events:auto;     /* still selectable */
}

.info-input:hover{
    box-shadow: inset 0 0 0 1px #9ca3af;
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

/* ===== TAB BUTTON ===== */
.tab-btn{
    min-width:160px;
    height:44px;
    display:flex;
    align-items:center;
    justify-content:center;
    font-weight:600;
    font-size:0.95rem;
    border-radius:8px;
    border:2px solid #009a49;
    background:#e5e7eb;
    color:#4b5563;
    cursor:pointer;
    transition:all 0.2s ease;
    text-decoration:none;
}

.tab-btn.active{
    background:#0f8f4f;
    color:white;
    cursor:default;
    pointer-events:none;
}

.tab-btn:not(.active):hover{
    background:#cbd5e1;
}

/* ===== SEARCH BAR ===== */
.search-wrapper{
    position:relative;
    width:600px;
}

.search-input{
    width:100%;
    height:44px;
    border:2px solid #009a49;
    border-radius:6px;
    padding:0 44px 0 16px;
    font-size:0.95rem;
    outline:none;
}

.search-input:focus{
    box-shadow:0 0 0 2px rgba(0,154,73,0.25);
}

.search-icon{
    position:absolute;
    right:14px;
    top:50%;
    transform:translateY(-50%);
    color:#009a49;
}

/* ===== ACTION BUTTONS ===== */
.receive-btn{
    background:#16a34a;
    color:white;
    padding:4px 16px;
    border-radius:999px;
    display:inline-block;
    transition:all 0.2s ease;
    cursor:pointer;
}

.receive-btn:hover{
    background:#15803d;
    transform:scale(1.08);
}

.view-icon{
    color:black;
    font-size:1.1rem;
    cursor:pointer;
    transition:transform 0.2s ease;
}

.view-icon:hover{
    transform:scale(1.25);
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
            <span>Receive Product</span>
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

<!-- ===== CONTENT ===== -->
<main class="flex-1 p-8 overflow-y-auto">

<div class="bg-white border-2 border-[#009a49] rounded-2xl p-6 shadow">

<h2 class="text-3xl font-black text-cyan-900 mb-4">RECEIVE ORDER</h2>
<hr class="border-green-600 mb-6">

<div class="flex justify-between items-center mb-6">
<div class="flex gap-3">
<a href="?tab=pending" class="tab-btn <%= "pending".equals(tab) ? "active" : "" %>">Pending Receive</a>
<a href="?tab=completed" class="tab-btn <%= "completed".equals(tab) ? "active" : "" %>">Completed Receive</a>
</div>

<div class="search-wrapper">
<input id="searchInput" class="search-input" placeholder="Search Receive Order by ID or Supplier">
<i class="fas fa-search search-icon"></i>
</div>
</div>

<table class="w-full border-collapse">
<thead>
<tr>
<th>Order ID</th>
<th>Supplier</th>
<th>Order Date</th>
<th>Status</th>
<th>Items</th>
<th>Action</th>
</tr>
</thead>

<tbody>
<% if (orderList != null && !orderList.isEmpty()) {
for (ReceiveOrder o : orderList) { %>

<tr>
<td><%=o.getOrderId()%></td>
<td><%=o.getSupplierName()%></td>
<td><%=sdf.format(o.getOrderDate())%></td>
<td>
<span class="inline-block min-w-[130px] text-center px-3 py-1 rounded-md text-xs font-semibold
<%= "COMPLETED".equals(o.getStatus()) ? "bg-green-200 text-green-800"
   : "SUBMITTED".equals(o.getStatus()) ? "bg-blue-200 text-blue-800"
   : "bg-orange-200 text-orange-800" %>">
<%=o.getStatus()%>
</span>
</td>
<td><%=o.getItemCount()%></td>
<td>
<a href="<%=request.getContextPath()%>/receive-order?orderId=<%=o.getOrderId()%>">
<% if ("COMPLETED".equals(o.getStatus())) { %>
<i class="fas fa-eye view-icon"></i>
<% } else { %>
<span class="receive-btn">Receive</span>
<% } %>
</a>
</td>
</tr>

<% }} else { %>
<tr>
<td colspan="6" class="text-center py-6">No orders found</td>
</tr>
<% } %>
</tbody>
</table>

</div>
</main>
</div>

<script>
document.getElementById("searchInput").addEventListener("keyup", function () {
 let f=this.value.toLowerCase();
 document.querySelectorAll("tbody tr").forEach(r=>{
  r.style.display=r.innerText.toLowerCase().includes(f)?"":"none";
 });
});
</script>
</body>
</html>