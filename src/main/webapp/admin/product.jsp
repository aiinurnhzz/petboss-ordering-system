<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.petboss.model.Product"%>

<%
List<Product> products = (List<Product>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Products</title>

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

input:disabled {
	cursor: not-allowed;
	background-color: #f3f4f6; /* light gray */
	color: #374151;
	border-color: #009a49;
}

/* ===== MODAL ACTION BUTTON GROUP ===== */
.modal-actions {
	display: flex;
	justify-content: flex-end;
	gap: 16px;
	margin-top: 32px;
}

/* ===== COMMON BUTTON SIZE ===== */
.modal-btn {
	width: 140px;
	height: 44px;
	border-radius: 999px;
	font-weight: 700;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: all 0.2s ease;
}

/* ===== CANCEL / CLOSE ===== */
.btn-cancel {
	background: #ef4444;
	color: white;
}

.btn-cancel:hover {
	background: #dc2626;
	transform: scale(1.08);
	box-shadow: 0 6px 14px rgba(0, 0, 0, 0.2);
}

/* ===== SAVE ===== */
.btn-save {
	background: #16a34a;
	color: white;
}

.btn-save:hover {
	background: #15803d;
	transform: scale(1.08);
	box-shadow: 0 6px 14px rgba(0, 0, 0, 0.25);
}

/* ===== MODAL SECTION TITLE (UNIFIED) ===== */
.modal-section-title {
	font-size: 0.95rem; /* same size everywhere */
	font-weight: 700;
	color: #15803d; /* green-700 */
	margin-bottom: 1rem;
	padding-bottom: 0.25rem;
	border-bottom: 1px solid #bbf7d0; /* soft green divider */
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
			<button class="text-white font-semibold text-sm">
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
				</a> <a href="<%=request.getContextPath()%>/profile"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-user-circle w-5 text-center"></i><span>Profile</span>
				</a> <a href="<%=request.getContextPath()%>/staff"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-users w-5 text-center"></i><span>Staff</span>
				</a> <a href="<%=request.getContextPath()%>/product"
					class="mx-auto w-[85%] h-11 bg-[#009a49] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-box w-5 text-center"></i><span>Product</span>
				</a> <a href="<%=request.getContextPath()%>/supplier"
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

<!-- ===== MAIN ===== -->
<main class="flex-1 p-8 overflow-y-auto">

<div class="bg-white border-2 border-[#009a49] rounded-2xl p-6 shadow">

<h2 class="text-3xl font-black text-cyan-900 mb-4">PRODUCT</h2>

<form method="get" action="<%=request.getContextPath()%>/product" class="search-form">

<div class="search-box">
<input type="text" name="keyword"
 value="<%=request.getParameter("keyword")!=null?request.getParameter("keyword"):""%>"
 placeholder="Search product by ID or Name"
 class="search-input">
<i class="fas fa-search search-icon"></i>
</div>

<div class="filter-box">
<div class="filter-container">
<div class="filter-icon"><i class="fas fa-filter"></i></div>
<select name="category" class="filter-select">
<option value="">All Category</option>
<option value="PET_FOOD" <%= "PET_FOOD".equals(request.getParameter("category"))?"selected":""%>>Pet Food</option>
<option value="PET_MEDICINE" <%= "PET_MEDICINE".equals(request.getParameter("category"))?"selected":""%>>Pet Medicine</option>
<option value="PET_CARE" <%= "PET_CARE".equals(request.getParameter("category"))?"selected":""%>>Pet Care</option>
<option value="PET_ACCESSORY" <%= "PET_ACCESSORY".equals(request.getParameter("category"))?"selected":""%>>Pet Accessory</option>
</select>
</div>
</div>

<button class="bg-green-600 text-white px-6 rounded-full font-semibold">Search</button>
</form>

<table class="w-full border-collapse mt-6">
<thead>
<tr>
<th>Image</th><th>ID</th><th>Name</th><th>Qty</th><th>Category</th><th>Price</th><th>Action</th>
</tr>
</thead>

<tbody>
<% if(products!=null && !products.isEmpty()){
for(Product p:products){ %>
<tr>
<td>
<%
String img = p.getImage();
boolean isUrl = img != null && img.startsWith("http");
String imgSrc = isUrl
    ? img
    : request.getContextPath() + "/images/products/" + img;
%>

<img src="<%=imgSrc%>"
     class="h-10 mx-auto"
     onerror="this.src='<%=request.getContextPath()%>/images/default-product.png'">
</td>
<td><%=p.getProductId()%></td>
<td><%=p.getName()%></td>
<td><%=p.getQuantity()%></td>
<td><%=p.getCategory()%></td>
<td>RM <%=String.format("%.2f",p.getSellingPrice())%></td>
<td>
<i class="fas fa-eye cursor-pointer"
 onclick="openViewModal('<%=p.getProductId()%>',
 '<%=p.getName()%>',
 '<%=p.getCategory()%>',
 '<%=p.getBrand()%>',
 <%=p.getQuantity()%>,
 <%=p.getMinQuantity()%>,
 <%=p.getPurchasePrice()%>,
 <%=p.getSellingPrice()%>,
 '<%=p.getImage()%>')"></i>
</td>
</tr>
<% }} else { %>
<tr><td colspan="7" class="p-6 text-center text-gray-500">No products</td></tr>
<% } %>
</tbody>
</table>

</div>
</main>
</div>

<!-- ✅ FIX: VIEW MODAL DIPINDAH KE SINI (LUAR TABLE) -->
<div id="viewModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center">
<div class="bg-white p-6 rounded-xl w-96">
<h3 class="font-bold mb-4">Product View</h3>
<img id="viewImg" class="w-full mb-3">
<input id="viewName" disabled class="w-full mb-2">
<input id="viewCategory" disabled class="w-full mb-2">
<button onclick="closeViewModal()" class="bg-red-500 text-white px-4 py-2 rounded">Close</button>
</div>
</div>

<script>
function openViewModal(id,name,cat,brand,qty,min,buy,sell,img){
document.getElementById("viewName").value=name;
document.getElementById("viewCategory").value=cat;
let imgSrc = img && img.startsWith("http")
    ? img
    : "<%=request.getContextPath()%>/images/products/" + img;
document.getElementById("viewImg").src = imgSrc;
document.getElementById("viewModal").classList.remove("hidden");
}
function closeViewModal(){
document.getElementById("viewModal").classList.add("hidden");
}
</script>

</body>
</html>

