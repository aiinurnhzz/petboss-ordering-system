<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="true"%>
<%@ page import="java.util.*"%>
<%@ page import="com.petboss.model.Product"%>

<%
String staffId = (String) session.getAttribute("staffId");
if (staffId == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

List<Product> products = (List<Product>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Product</title>

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
    font-weight: bold;
}

td {
    border: 1px solid #009a49;
    text-align: center;
    font-size: 0.85rem;
    padding: 8px;
}

.search-form {
    display: flex;
    gap: 16px;
    margin-bottom: 24px;
}

.search-box {
    position: relative;
    flex: 1;
}

.search-input {
    width: 100%;
    border: 2px solid #009a49;
    border-radius: 8px;
    padding: 10px 42px 10px 16px;
}

.search-icon {
    position: absolute;
    right: 14px;
    top: 50%;
    transform: translateY(-50%);
    color: #009a49;
}

.filter-box {
    width: 220px;
}

.filter-container {
    display: flex;
    align-items: center;
    border: 2px solid #009a49;
    border-radius: 8px;
    background: white;
    position: relative;
}

.filter-icon {
    padding: 0 14px;
    border-right: 2px solid #009a49;
    color: #009a49;
}

.filter-select {
    width: 100%;
    padding: 10px 40px 10px 14px;
    appearance: none;
    background: transparent;
    cursor: pointer;
}

.filter-arrow {
    position: absolute;
    right: 14px;
    pointer-events: none;
    color: #6b7280;
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

		<!-- ===== SIDEBAR (DO NOT CHANGE) ===== -->
		<aside class="w-60 bg-[#266b8b] px-5 py-4 flex flex-col h-full">
			<nav class="flex-1 space-y-5 mt-6">

				<a href="<%=request.getContextPath()%>/dashboard"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-home w-5 text-center"></i><span>Home</span>
				</a> 
				
				<a href="<%=request.getContextPath()%>/profile"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-user-circle w-5 text-center"></i><span>Profile</span>
				</a> 
				
				<a href="<%=request.getContextPath()%>/staff"
					class="mx-auto w-[85%] h-11 bg-[#009a49] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-users w-5 text-center"></i><span>Staff</span>
				</a> 
				
				<a href="<%=request.getContextPath()%>/product"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-box w-5 text-center"></i><span>Product</span>
				</a> 
				
				<a href="<%=request.getContextPath()%>/supplier"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-truck w-5 text-center"></i><span>Supplier</span>
				</a>
			</nav>

			<div class="flex justify-center mt-auto pb-4">
				<img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
					class="w-36 sm:w-40 md:w-44 opacity-100">
			</div>
		</aside>

<!-- ===== CONTENT ===== -->
<main class="flex-1 p-8 overflow-y-auto">

<div class="bg-white border-2 border-[#009a49] rounded-xl p-6 shadow">

<h2 class="text-2xl font-bold text-cyan-900 mb-4">PRODUCT LIST</h2>
<hr class="border-green-600 mb-6">

<!-- ===== SEARCH (SERVER SIDE) ===== -->
<form method="get" action="<%=request.getContextPath()%>/product"
      class="flex gap-4 mb-6">

    <input type="text" name="keyword"
           placeholder="Search product..."
           class="border-2 border-[#009a49] rounded px-4 py-2 w-72">

    <select name="category"
            class="border-2 border-[#009a49] rounded px-3 py-2">
        <option value="">All Category</option>
        <option value="PET_FOOD">Pet Food</option>
        <option value="PET_MEDICINE">Pet Medicine</option>
        <option value="PET_CARE">Pet Care</option>
        <option value="PET_ACCESSORY">Pet Accessory</option>
    </select>

    <button class="bg-[#009a49] text-white px-6 rounded">
        Search
    </button>
</form>

<!-- ===== TABLE ===== -->
<table class="w-full border-collapse">
<thead>
<tr>
    <th>Image</th>
    <th>Product ID</th>
    <th>Name</th>
    <th>Category</th>
    <th>Quantity</th>
    <th>Selling Price (RM)</th>
    <th>Action</th>
</tr>
</thead>

<tbody>

<%
if (products != null && !products.isEmpty()) {
    for (Product p : products) {
%>
<tr>

<td>
<%
if (p.getImage() != null) {
%>
<img src="<%=request.getContextPath()%>/product-image?file=<%=p.getImage()%>"
     class="h-10 mx-auto">
<%
} else {
%> - <%
}
%>
</td>

<td><%=p.getProductId()%></td>
<td><%=p.getName()%></td>
<td><%=p.getCategory()%></td>
<td><%=p.getQuantity()%></td>
<td>RM <%=String.format("%.2f", p.getSellingPrice())%></td>

<td>
<a href="<%=request.getContextPath()%>/product?action=view&id=<%=p.getProductId()%>"
   class="text-blue-600 hover:underline">
   <i class="fas fa-eye"></i> View
</a>
</td>

</tr>
<%
}
} else {
%>
<tr>
<td colspan="7" class="py-6 text-gray-500">No product found</td>
</tr>
<%
}
%>

</tbody>
</table>

</div>
</main>
</div>

</body>
</html>
