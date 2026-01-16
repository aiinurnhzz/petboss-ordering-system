<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="true"%>
<%@ page import="java.util.List" %>
<%@ page import="com.petboss.model.Product" %>
<%@ page import="com.petboss.model.Activity" %>

<%
String staffId = (String) session.getAttribute("staffId");
String role = (String) session.getAttribute("role");

if (staffId == null || role == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

String staffName = (String) session.getAttribute("staffName");
String period = request.getParameter("period");
if (period == null) period = "today";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>PM Dashboard</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
html, body {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #fdf8e9;
}

/* Scrollbar kemas */
::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-thumb {
    background-color: #94a3b8;
    border-radius: 6px;
}
::-webkit-scrollbar-track { background: transparent; }

/* Hentikan scroll tembus */
.scroll-lock {
    overscroll-behavior: contain;
}
</style>
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
           class="mx-auto w-[85%] h-11 bg-[#009a49] hover:bg-[#009a49] text-white
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
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
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

<!-- ===== MAIN ===== -->
<main class="flex-1 p-6 overflow-hidden">

<!-- GREETING -->
<div class="mb-4">
    <h2 class="text-3xl font-black text-cyan-900 uppercase">
        Welcome, <%= staffName %>
    </h2>
</div>

<!-- ===== STATS ===== -->
<div class="grid grid-cols-4 gap-6 mb-6">

<div class="bg-[#4FA3A5] text-white p-6 rounded-xl text-center shadow-md">
    <i class="fas fa-boxes text-2xl mb-2"></i>
    <p class="text-4xl font-bold"><%= request.getAttribute("totalProducts") %></p>
    <p class="text-sm">Products</p>
</div>

<div class="bg-[#F4A261] text-white p-6 rounded-xl text-center shadow-md">
    <i class="fas fa-users text-2xl mb-2"></i>
    <p class="text-4xl font-bold"><%= request.getAttribute("totalStaff") %></p>
    <p class="text-sm">Staff</p>
</div>

<div class="bg-[#355070] text-white p-6 rounded-xl text-center shadow-md">
    <i class="fas fa-truck text-2xl mb-2"></i>
    <p class="text-4xl font-bold"><%= request.getAttribute("totalSuppliers") %></p>
    <p class="text-sm">Suppliers</p>
</div>

<div onclick="highlightAlerts()"
     class="cursor-pointer bg-red-500 text-white p-6 rounded-xl text-center shadow-md">
    <i class="fas fa-exclamation-triangle text-2xl mb-2"></i>
    <p class="text-4xl font-bold"><%= request.getAttribute("lowStockCount") %></p>
    <p class="text-sm">Low Stock</p>
</div>

</div>

<!-- ===== ALERTS + ACTIVITY ===== -->
<div class="grid grid-cols-1 lg:grid-cols-2 gap-6">

<!-- ALERTS -->
<div id="alertCard" class="bg-white rounded-xl shadow-md flex flex-col h-[360px] overflow-hidden">
    <!-- ⭐ UPDATED -->
    <div class="px-4 py-3 border-b text-lg font-bold">
        Alerts
    </div>

    <div class="px-4 py-3 flex-1 overflow-y-auto text-sm space-y-3 scroll-lock">
        <%
        List<Product> lowStock = (List<Product>) request.getAttribute("lowStockList");
        if (lowStock != null) {
            for (Product p : lowStock) {
        %>
        <div class="border-b pb-2">
            <b><%= p.getName() %></b><br>
            Stock <%= p.getQuantity() %> (Min: <%= p.getMinQuantity() %>)
        </div>
        <% }} %>
    </div>
</div>

<!-- RECENT ACTIVITY -->
<div class="bg-white rounded-xl shadow-md flex flex-col h-[360px] overflow-hidden">
    <!-- ⭐ UPDATED -->
    <div class="px-4 py-3 border-b flex justify-between items-center">
        <span class="text-lg font-bold">Recent Activity</span>

        <form method="get">
            <select name="period"
                    onchange="this.form.submit()"
                    class="text-sm border rounded-md px-3 py-1">
                <option value="today" <%= "today".equals(period) ? "selected" : "" %>>Today</option>
                <option value="week" <%= "week".equals(period) ? "selected" : "" %>>Week</option>
                <option value="month" <%= "month".equals(period) ? "selected" : "" %>>Month</option>
            </select>
        </form>
    </div>

    <div class="px-4 py-3 flex-1 overflow-y-auto text-sm space-y-3 scroll-lock">
        <%
        List<Activity> activities = (List<Activity>) request.getAttribute("recentActivities");
        if (activities != null) {
            for (Activity a : activities) {
        %>
        <div class="border-b pb-2">
            <b><%= a.getTime() %></b><br>
            <%= a.getStaffName() %> <%= a.getDescription() %>
        </div>
        <% }} %>
    </div>
</div>

</div>
</main>
</div>

<script>
function highlightAlerts() {
    const card = document.getElementById("alertCard");
    card.classList.add("ring-4","ring-red-400");
    setTimeout(()=>card.classList.remove("ring-4","ring-red-400"),2000);
}
</script>

</body>
</html>
