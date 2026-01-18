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
/* ===== SAME CSS (UNCHANGED) ===== */
html, body { height:100%; margin:0; overflow:hidden; background:#fdf8e9; }
th { background:#e6f4ea; border:1px solid #009a49; font-weight:bold; }
td { border:1px solid #009a49; text-align:center; font-size:.85rem; padding:8px; }
.search-form { display:flex; gap:16px; margin-bottom:24px; }
.search-box { position:relative; flex:1; }
.search-input { width:100%; border:2px solid #009a49; border-radius:8px; padding:10px 42px 10px 16px; }
.search-icon { position:absolute; right:14px; top:50%; transform:translateY(-50%); color:#009a49; }
.filter-box { width:220px; }
.filter-container { display:flex; align-items:center; border:2px solid #009a49; border-radius:8px; background:white; }
.filter-icon { padding:0 14px; border-right:2px solid #009a49; color:#009a49; }
.filter-select { width:100%; padding:10px 40px 10px 14px; appearance:none; background:transparent; }
.filter-arrow { position:absolute; right:14px; pointer-events:none; }
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

<!-- ===== SIDEBAR (UNCHANGED) ===== -->
<aside class="w-60 bg-[#266b8b] px-5 py-4 flex flex-col h-full">
<nav class="flex-1 space-y-5 mt-6">
<a href="<%=request.getContextPath()%>/dashboard" class="mx-auto w-[85%] h-11 bg-[#f2711c] text-white rounded-full flex items-center gap-3 px-4 border-2 border-white shadow-md text-sm font-semibold">
<i class="fas fa-home"></i> Home
</a>
<a href="<%=request.getContextPath()%>/product" class="mx-auto w-[85%] h-11 bg-[#009a49] text-white rounded-full flex items-center gap-3 px-4 border-2 border-white shadow-md text-sm font-semibold">
<i class="fas fa-box"></i> Product
</a>
</nav>
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
<img src="<%=request.getContextPath()%>/product-image?file=<%=p.getImage()%>" class="h-10 mx-auto">
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
document.getElementById("viewImg").src="<%=request.getContextPath()%>/product-image?file="+img;
document.getElementById("viewModal").classList.remove("hidden");
}
function closeViewModal(){
document.getElementById("viewModal").classList.add("hidden");
}
</script>

</body>
</html>
